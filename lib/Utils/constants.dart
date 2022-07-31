import 'package:bookingmobile2/Models/ModelProvider.dart';
import 'package:flutter/cupertino.dart';

import '../Models/Office.dart';



  final double multiplierBigTitle2 =3.2;
  final double multiplierBigTitle =2.9;
  final double multiplierParagraph = 1.7;
  final double multiplierParagraph2 = 1.5;
  final double multiplierSubtitle = 2.3;
  final double multiplierSubtitle2 = 2.2;
  final Color backGround =  Color(0xFF151C3D);
  final Color backGround2 = Color(0xFFE5E5E5);
  final GlobalKey<AnimatedListState> listKey = GlobalKey();
  final GlobalKey<AnimatedListState> listOfficeKey = GlobalKey();

final refreshPage = ValueNotifier<int>(0);


 final TextStyle calendarStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Color(0xFF1E1E1E)
 );
     final List<String> giorniSettimana = [
       "Lunedì",
       "Martedì",
      "Mercoledì",
     "Giovedì",
     "Venerdì'",
     "Sabato",
     "Domenica",

     ];
Map<int, String> stringDays = {
  1: "Lun",
  2: "Mar",
  3: "Mer",
  4: "Gio",
  5: "Ven",
  6: "Sab",
  7: "Dom"
};

   final  Color purpleFluo = Color(0xFF8645FF);
    final Color blackLight = Color(0xFF1E1E1E);

    List<Office> mockedOffice = [
      Office(name: "Area 51", indirizzo: "Via XX Settembre 64", city: "Torino", capienza:34, immagine:"uffici/area_51.jpg" ),
      Office(name: "Ex BD", indirizzo: "Via Santa Teresa 12", city: "Milano", capienza: 10 , immagine:"uffici/ex_bd.jpg" ),
      Office(name: "Orbyta Compliance", indirizzo: "Piazza Catstello", city: "Torino", capienza: 1, immagine:"uffici/orbyta_compliance.jpg" ),



    ];

class Constant {
  static final int _WORKING_HOURS = 8;
  static final int _INITIAL_WORKING_HOUR = 9;
  static final int _END_WORKING_HOUR = 18;

  static  int get WORKING_HOURS => _WORKING_HOURS;

  static int get END_WORKING_HOUR => _END_WORKING_HOUR;

  static int get INITIAL_WORKING_HOUR => _INITIAL_WORKING_HOUR;
}



final COGNITO_CLIENT_ID = '18m3dheau9tcq2biqppgur4763';
final COGNITO_Pool_ID = 'eu-central-1_QvImdMvOD';
final COGNITO_POOL_URL = 'instavitto.auth.eu-central-1';  // CHANGE YOUR DOMAIN NAME
final CLIENT_SECRET = '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';






