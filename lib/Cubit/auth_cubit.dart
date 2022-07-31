

import 'package:bookingmobile2/Bloc/login_bloc.dart';
import 'package:bookingmobile2/Cubit/session_cubit.dart';
import 'package:bookingmobile2/Cubit/session_state.dart';
import 'package:bookingmobile2/Models/AuthCredential.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AuthState {login, loggedIn}

class AuthCubit extends Cubit<AuthState>{
  final SessionCubit? sessionCubit;

  AuthCubit({this.sessionCubit}): super(AuthState.login);
  AuthCredentials? credentials;

  void showLogin() => emit(AuthState.login);
  void launchSession(AuthCredentials credentials) => sessionCubit?.showSession(credentials);

  void googleLogin() => sessionCubit?.emit(GoogleAuth());

}