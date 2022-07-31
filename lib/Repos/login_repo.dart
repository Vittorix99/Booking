
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:bookingmobile2/Models/ModelProvider.dart';
import 'package:bookingmobile2/Models/Postazione.dart';
import 'package:bookingmobile2/Utils/constants.dart';

import '../Models/Prenotazione.dart';
import '../Utils/exceptions.dart';
import 'package:http/http.dart' as http;
class AuthRepository{

  Future<String> _getUserIdFromAttributes() async{
  try{
    final attributes = await Amplify.Auth.fetchUserAttributes();
    final userId = attributes.firstWhere((element) => element.userAttributeKey.key =="sub").value;
    return userId;




      }catch(e){
    throw e;
     }
  }

  Future<bool> updateUserPassword(String oldPassword, String newPassord) async{


    return false;
  }



  Future<String?> attemptAutoLogin() async {
    try {
      final session = await Amplify.Auth.fetchAuthSession();
      return session.isSignedIn ?  (await _getUserIdFromAttributes()) : null;


    }catch(e){
      print(e);
      throw e;
    }
  }


  Future<String?> login({required String mail , required String password}) async{

   try{



     final result = await Amplify.Auth.signIn(username: mail.trim(), password: password);
     bool isSigned =  result.isSignedIn;
     if(isSigned){

       await Amplify.DataStore.start();



       return   await _getUserIdFromAttributes();
     }
     else{
       throw UnkwownError();
     }

   }catch(e){

     await Amplify.Auth.signOut();

     if(e is NotAuthorizedException){
       throw WrongCredentialsException();
     }

     throw e;
   }
}

Future<void> signOut() async{

    await Amplify.Auth.signOut(options: SignOutOptions(globalSignOut: true));


  }

  Future<bool> GoogleSignOut(String accessToken) async{
try {
  String url = "https://${COGNITO_POOL_URL}" +
      ".amazoncognito.com/logout?client_id=${COGNITO_CLIENT_ID}" +
      "&logout_uri=https://www.google.it& state=STATE&scope=openid+profile+aws.cognito.signin.user.admin";


  final response = await http.get(Uri.parse(url),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'});

  if (response.statusCode == 200) {
   // String revokeAccess = "https://accounts.google.com/o/oauth2/revoke?token="+accessToken;

    return true;
  }
  return false;
}catch(e){
return false;
}

  }

  Future<bool> changePassword(String oldPass, String newPass)async {
    try {
      final response = await Amplify.Auth.updatePassword(
          oldPassword: oldPass, newPassword: newPass);
      return true;
    } catch (e) {
      return false;
    }
  }








}