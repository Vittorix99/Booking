


import 'package:bookingmobile2/Bloc/profile_bloc.dart';
import 'package:bookingmobile2/Cubit/auth_cubit.dart';
import 'package:bookingmobile2/Models/AuthCredential.dart';
import 'package:bookingmobile2/Repos/login_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:email_validator/email_validator.dart';

import '../Utils/exceptions.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState>{
final AuthRepository? authRepo;
final AuthCubit? authCubit;
LoginBloc({this.authRepo, this.authCubit}): super(LoginState());

@override
  Stream<LoginState> mapEventToState(LoginEvent event) async*{

  if (event is LoginUsernameChanged){
    yield state.copyWith(username: event.username);


  }else if (event is LoginPasswordChanged){
    yield state.copyWith(password: event.password);

  } else if (event is LoginSubmitted){
    yield state.copyWith(status: FormSubmitting());

    try{
      final userId = await authRepo?.login(mail: state.username, password: state.password, );

      yield state.copyWith(status: SubmissionSuccess());


      authCubit?.launchSession(AuthCredentials(mail: state.username, userId: userId));


      yield state.copyWith(username: state.username, password: state.password);

    }catch(e){
if(e is WrongCredentialsException)
      yield state.copyWith(username:state.username,password: state.password, status: SubmissionFailed(message: "Credenziali non valide"));

else  yield state.copyWith(username:state.username,password: state.password, status: SubmissionFailed(message: "Errore nel login"));

    }
  }

  else if (event is GoogleLogin){
    yield state.copyWith(status: FormSubmitting());


    try {
      this.authCubit?.googleLogin();

      yield state.copyWith(status: SubmissionSuccess());
    }catch(e){
      print(e);

      yield state.copyWith(username:state.username,password: state.password, status: SubmissionFailed( message: "Login non riuscito"));

    }


  }





}





}







class LoginState{

  final String username;
  final String password;
  final FormSubmissionStatus formStatus;

  LoginState({this.username='',this.password='', this.formStatus = const InitialFormStatus()});
  LoginState copyWith({String? username, String? password, FormSubmissionStatus? status}){
    return LoginState(username: username ?? this.username, password: password ?? this.password, formStatus: status ?? this.formStatus);
  }

  bool get isValidEmail => EmailValidator.validate(this.username);
  bool get isPasswordValid => this.password.length >6;

}










abstract class FormSubmissionStatus{
  const FormSubmissionStatus();
}

class InitialFormStatus extends FormSubmissionStatus{

  const InitialFormStatus();



}
class FormSubmitting extends FormSubmissionStatus{

}

class SubmissionSuccess extends FormSubmissionStatus{
  const SubmissionSuccess();



}

class SubmissionFailed extends FormSubmissionStatus{
  final String message;
   SubmissionFailed({required this.message});

}



abstract class LoginEvent{

}

class GoogleLogin extends LoginEvent{

}

class LoginUsernameChanged extends LoginEvent{
  final String username;
  LoginUsernameChanged(this.username);

}

class LoginPasswordChanged extends LoginEvent{
  final String password;
  LoginPasswordChanged(this.password);




}


class LoginSubmitted extends LoginEvent{

}