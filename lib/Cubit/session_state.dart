import 'package:bookingmobile2/Models/ModelProvider.dart';

import '../Models/User.dart';
import '../Models/User.dart';

abstract class SessionState{

}

class UnknownSessionState extends SessionState{}

class Unauthenticated extends SessionState{}

class Authenticated extends SessionState{
  final User user;

  Authenticated(this.user);

}

class GoogleAuth extends SessionState{



}

class InvalidProfile extends SessionState{
String message;
InvalidProfile(this.message);

}

class InfoState extends SessionState{
  User user;
  InfoState(this.user);


}