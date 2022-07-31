


import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:bookingmobile2/Bloc/profile_bloc.dart';
import 'package:bookingmobile2/Models/AuthCredential.dart';
import 'package:bookingmobile2/Repos/login_repo.dart';
import 'package:bookingmobile2/Cubit/session_state.dart';
import 'package:bookingmobile2/Repos/prenotazioni_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Models/Office.dart';
import '../Models/Prenotazione.dart';
import '../Models/User.dart';
import '../Repos/data_repo.dart';
import '../Utils/image_caching.dart';

enum AuthState { login, logged }

class SessionCubit extends Cubit<SessionState>{
  final AuthRepository? authRepo;
  final DataRepository? dataRepo;
  final PrenotazioniRepo? prenotazioniRepo;
  final ProfileBloc? profileBloc;
  late String? accessToken;


 SessionCubit({this.authRepo, this.dataRepo, this.profileBloc, this.prenotazioniRepo}) : super(UnknownSessionState());

void showAuth()=> emit(Unauthenticated());
void showInfos(User user) => emit(InfoState(user));


void showGoogleSession(CognitoUser cognitoUser, List<CognitoUserAttribute> attributi) async {
  // final user = dataRepo.getUser(credentials.userId); Qui prendiamo le credenziali
  try {

    User? user = await dataRepo?.getUserByMail(cognitoUser.username!);

    if (user != null){

      if (user.name == null || user.surname == null || user.mail == null) {
        emit(InvalidProfile("Errore di caricamento dell'utente"));
        this.signOut();

        throw Exception();
      }

      else {
        String avatar = " ";
        for(CognitoUserAttribute attribute in attributi){
          if(attribute.getName() =="picture")
            avatar = attribute.value!;
          if(attribute.getName()=="custom:access_token")
            this.accessToken = attribute.value!;

        }
        initGoogleProfile(user, avatar);
        Future.delayed(const Duration(milliseconds: 500), () {
          emit(Authenticated(user));
          return;
        });

      }
  }
    else
      throw UserNotFoundException("User è null");

  } catch (e) {

      if (e is UserNotFoundException){
      try {
      User? user = await dataRepo?.createCognitoUser(cognitoUser, attributi);
      }catch (e) {
      print("Impossibile salvare l'utente");
      this.signOut();
      throw e;
      }
      }

}

  }

void showSession(AuthCredentials credentials) async {

  // final user = dataRepo.getUser(credentials.userId); Qui prendiamo le credenziali
 try{
   //User? user = await dataRepo?.getUserById(credentials.userId!);
   //if(user == null){

   User? user = await dataRepo?.getUserByMail(credentials.mail);



   /*if (user == null) {
     user = await dataRepo?.createUser(
         userId: credentials.userId!, mail: credentials.mail);
   }*/
if(user== null) throw UserNotFoundException("User è null");
   if(user.name==null ||user.surname== null || user.mail == null ){
     emit(InvalidProfile("Errore di caricamento dell'utente"));
   this.signOut();

     throw Exception();



   }else{


     initProfile(user);
     Future.delayed(const Duration(milliseconds: 500), () {
    // Here you can write your code
    emit(Authenticated(user));
  });
   }

 }catch(e){
   print("Errore nel caricamento dell'utente");



   this.signOut();
   
 }



}

void signOut(){
  authRepo?.signOut();
  profileBloc?.add(SignOutEvent());
  emit(Unauthenticated());


}
  Future<bool> GoogleSignOut() async{

   try {
    bool? isLoggedOut = await authRepo?.GoogleSignOut(this.accessToken!);
    if(isLoggedOut!= true){

    profileBloc?.add(ErrorEvent("Impossibile eseguire il logout"));
    return false;

    }
     profileBloc?.add(SignOutEvent());
     emit(Unauthenticated());
     return true;
   }catch(e){

     profileBloc?.add(ErrorEvent("Impossibile eseguire il logout"));
     return false;

   }


  }


Future<void> initProfile(User user)async {



  String? avatarKey = await ImageUrlCache.instance.getUrlByUser(user) as String;
  List<Office>? preferiti = await dataRepo?.getAllFavoritesOffice(user.favorites!);
  List<Prenotazione>? prenotazioni = await prenotazioniRepo?.fetchPrenotazioniOfUser(user.mail!);
  profileBloc?.add(InitProfile(user: user, prenotazioni: prenotazioni!, preferiti:preferiti!,avatarKey: avatarKey, isLoggedWithGoogle: false ));

}

  Future<void> initGoogleProfile(User user, String? avatar) async {
    String? avatarKey = " ";


    if(user.avatarKey == null) avatarKey = avatar;
    else  avatarKey = await ImageUrlCache.instance.getUrlByUser(user) as String;

    List<Office>? preferiti = await dataRepo?.getAllFavoritesOffice(user.favorites!);
    List<Prenotazione>? prenotazioni = await prenotazioniRepo?.fetchPrenotazioniOfUser(user.mail!);
    profileBloc?.add(InitProfile(user: user, prenotazioni: prenotazioni!, preferiti:preferiti!,avatarKey: avatarKey, isLoggedWithGoogle: true ));

  }


}