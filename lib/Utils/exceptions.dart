
class LoginException implements Exception{
   final String message = "Impossibile effettuare login";
}
class WrongCredentialsException extends LoginException{
@override
  final String message = "Credenziali di log in errate";

}
class WrongPassException implements Exception{

String message = "Password errata";

}

class UnkwownError extends LoginException{
   @override
    final String message = "Errore nel tentativo di Login.";
}
class UserNotFoundException implements Exception{

}
class OfficeNotFoundException implements Exception{

}

class OltreCapienzaException implements Exception{
}

class UfficioPienoException implements Exception{

}

class PrenotazioneNotValid implements Exception{
String? message;
PrenotazioneNotValid({this.message});



}

class DateNotValid implements Exception{

}