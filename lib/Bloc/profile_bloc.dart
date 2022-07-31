

import 'dart:io';


import 'package:bookingmobile2/Bloc/login_bloc.dart';
import 'package:bookingmobile2/Cubit/auth_cubit.dart';
import 'package:bookingmobile2/Repos/data_repo.dart';
import 'package:bookingmobile2/Repos/login_repo.dart';
import 'package:bookingmobile2/Repos/prenotazioni_repo.dart';
import 'package:bookingmobile2/Repos/storage_repo.dart';
import 'package:bookingmobile2/Utils/exceptions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../Models/Office.dart';
import '../Models/Prenotazione.dart';

import '../Models/User.dart';

import '../Utils/image_caching.dart';


class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required this.dataRepo, required this.storageRepo, required this.prenotazioniRepo, required this.authRepo , }) : super(ProfileState());
  DataRepository dataRepo;
  StorageRepository storageRepo;
  PrenotazioniRepo prenotazioniRepo;
  AuthRepository authRepo;



  final _picker = ImagePicker();

  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {

    if(event is ChangeAvatarRequest){
      yield state.copyWith(imageSourceActionSheetIsVisible: true);


    }

    if(event is OpenImagePicker){
      yield state.copyWith(imageSourceActionSheetIsVisible: false);
      final pickedImage = await _picker.pickImage(source: event.imageSource);
      if(pickedImage == null) return;

      final key = await storageRepo.uploadFile(File(pickedImage.path), state.user!);
      final updatedUser = state.user!.copyWith(avatarKey: key);


     final results = await Future.wait([
      dataRepo.updateUser(updatedUser),
      storageRepo.getProfileImageUrl(key),

     ]);


      yield state.copyWith(avatarPath: results.last as String);
    }





    if(event is InitProfile){
     // String? avatarKey = await storageRepo.getProfileImageByUser(event.user);
    try {

      ProfileState newState = ProfileState(user: event.user,
          avatarPath: event.avatarKey?? " ",
          preferiti: event.preferiti,
          prenotazioni: event.prenotazioni,
          isLoggedWithGoogle: event.isLoggedWithGoogle);




      yield newState;
    }catch(e){

      yield ProfileState();
      throw e;



     }
    }
    if (event is SignOutEvent){
      ProfileState initState = ProfileState();
      yield initState;
    }

    if(event is ErrorEvent){
      yield state.copyWith(formStatus: SubmissionFailed(message: event.message));
    }

    if(event is PasswordChanged){

      yield state.copyWith(formStatus: FormSubmitting());

      try{
bool isChanged = await authRepo.changePassword(event.oldPass, event.newPass);
if(isChanged) yield state.copyWith(formStatus: SubmissionSuccess());
else yield state.copyWith(formStatus: SubmissionFailed(message: "Password non valida"));


      }catch(e){
     yield state.copyWith(formStatus: SubmissionFailed(message: "Password non valida"));


      }

    }


    if (event is AddPreferito){
      dataRepo.addPreferitoToUser(state.user!, event.preferito.id);
     ProfileState newstate = state;
     newstate.addPreferito(event.preferito);
      yield newstate;
    }
    if (event is AddPrenotazione){
      ProfileState newstate = state;
      newstate.addPrenotazione(event.prenotazione);
      yield newstate;
    }
    if(event is DeletePrenotazione){
      try{
        this.prenotazioniRepo.deletePrenotazione(event.prenotazione);

        ProfileState newstate = state;
        newstate.deletePrenotazione(event.prenotazione);

        yield newstate;

      }catch(e){
print("Impossibile eliminare la prenotazione");

      }

    }

    if(event is DeleteUfficio){

      try{

        prenotazioniRepo.deletePrenotazioniOfOfice(event.office);


        dataRepo.deleteOffice(event.office);

      }catch(e){
        throw e;
      }


    }
    if(event is EliminaPreferito){
      dataRepo.deletePreferitoFromUser(state.user!, event.preferito.id);
      ProfileState newstate = state;
      newstate.preferiti!.removeWhere((element) => element == event.preferito);
      yield newstate;
    }

     if (event is SaveProfileChanges) {
      yield state.copyWith(formStatus: FormSubmitting(), imageSourceActionSheetIsVisible: false);

if (event.user.mail!= state.mail) yield state.copyWith(formStatus: SubmissionFailed( message:"Impossibile" ), imageSourceActionSheetIsVisible:  false);


 else   try {


        await dataRepo.updateUser(event.user);
        yield state.copyWith(user: event.user,formStatus: SubmissionSuccess(), imageSourceActionSheetIsVisible: false);
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed( message: "Impossibile apportare le modifiche" ), imageSourceActionSheetIsVisible: false);
      }
    }

  }
}

class ProfileError extends ProfileState{


}
class ProfileState {
  final User? user;
  List<Office>? preferiti=[] ;
  List<Prenotazione>? prenotazioni = [];
  final String? avatarPath;
  final FormSubmissionStatus formStatus;
  final bool isLoggedWithGoogle;


  bool? imageSourceActionSheetIsVisible = false;
  ProfileState({ this.user, this.preferiti,this.formStatus = const InitialFormStatus(), this.prenotazioni, this.avatarPath, this.imageSourceActionSheetIsVisible,this.isLoggedWithGoogle = false
  });


  String? get mail => user?.mail;
  String? get name => user?.name;
  String? get surname => user?.surname;

  ProfileState copyWith({
    User? user,
    String? avatarPath,
    List<Office>? preferiti,
    bool? isLoggedWithGoogle,


    FormSubmissionStatus? formStatus,
    bool? imageSourceActionSheetIsVisible,
  }) {
    return ProfileState(
      user: user ?? this.user,
      preferiti: preferiti?? this.preferiti,
      isLoggedWithGoogle: isLoggedWithGoogle?? this.isLoggedWithGoogle,

      avatarPath: avatarPath ?? this.avatarPath,


      formStatus: formStatus ?? this.formStatus,
      imageSourceActionSheetIsVisible: imageSourceActionSheetIsVisible ??
          this.imageSourceActionSheetIsVisible,
    );
  }

  void addPrenotazione(Prenotazione prenotazione){
    this.prenotazioni?.add(prenotazione);
  }
  void deletePrenotazione(Prenotazione prenotazione){
    try{
      this.prenotazioni!.removeWhere((element) => element.id==prenotazione.id);
    }catch(e){
      print("Prenotazione non trovata nella lista di prenotazione dell'utente");
    }
  }
  void addPreferito (Office office){
    this.preferiti?.add(office);

  }


}

abstract class ProfileEvent {}

class DeleteUfficio extends ProfileEvent{
  Office office;
  DeleteUfficio(this.office);
}


class AddPreferito extends ProfileEvent{
  Office preferito;
  AddPreferito(this.preferito);
}
class EliminaPreferito extends ProfileEvent{
  Office preferito;
  EliminaPreferito(this.preferito);
}
class InitProfile  extends ProfileEvent{
  InitProfile(

  { required this.user, this.prenotazioni , this.preferiti , this.avatarKey, this.isLoggedWithGoogle = false});
User user;
List<Prenotazione>? prenotazioni;
String? avatarKey;
List<Office>? preferiti;
bool isLoggedWithGoogle;
}


class SignOutEvent extends ProfileEvent{

}

class PasswordChanged extends ProfileEvent{
  String newPass;
  String oldPass;
  PasswordChanged(this.newPass, this.oldPass);

}

class OpenImagePicker extends ProfileEvent{
  final ImageSource imageSource;
  OpenImagePicker(this.imageSource);

}
class ErrorEvent extends ProfileEvent{
  String message;
  ErrorEvent(this.message);

}

class ProvideImagePath extends ProfileEvent{
  final String avatarPath;
  ProvideImagePath(this.avatarPath);
}

class ChangeAvatarRequest extends ProfileEvent{}
class AddPrenotazione extends ProfileEvent{
  Prenotazione prenotazione;
  AddPrenotazione(this.prenotazione);
}
class DeletePrenotazione extends ProfileEvent{
  Prenotazione prenotazione;
  DeletePrenotazione(this.prenotazione);


}

class SaveProfileChanges extends ProfileEvent{
User user;
SaveProfileChanges(this.user);


}




















