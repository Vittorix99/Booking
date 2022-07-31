 import 'dart:io';

import 'package:bookingmobile2/Models/ModelProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/prenotazione_flow_bloc.dart';
import '../Bloc/profile_bloc.dart';
import '../Models/Prenotazione.dart';
import '../Repos/data_repo.dart';
import 'componenti_riutilizzabili.dart';
import 'constants.dart';
import 'image_caching.dart';

class Functions{


  static bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  static Future<Widget> getOfficeImage(String path, BuildContext context, Office ufficio) async{

    String url = await  ImageUrlCache.instance.getUrl(path);


    try {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Hero(

          tag: ufficio.name,

          child: CachedNetworkImage(
            imageUrl: url, fit: BoxFit.fill, width: MediaQuery
              .of(context)
              .size
              .width * 0.22, height: double.infinity,
          errorWidget: (context, url, error) {
          return  Icon(Icons.home_work_outlined,size: 40,color: blackLight,);
          }

            ,),

        ),
      );
    }catch(e){
      print(e);
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          color: Colors.white,
          width: MediaQuery
              .of(context)
              .size
              .width * 0.22, height: double.infinity,

        ),
      );

    }




  }




  static void showSnackBar(BuildContext context ,
      String message){
    final snackBar = SnackBar(content: Text(message),backgroundColor:Colors.redAccent,elevation: 3,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);


  }
  static void showSuccessSnackBar(BuildContext context ,
      String message){
    final snackBar = SnackBar(content: Text(message),backgroundColor:Colors.green,elevation: 3,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);


  }


  static String greetingSentence(){
    DateTime now = DateTime.now();

    if(now.hour>12 && now.hour<18) return"Buon Pomeriggio";
    if(now.hour<12 && now.hour> 5) return "Buona Giorno";
    if(now.hour >18 && now.hour <5) return "Buona Serata";
    return "Buon Pomeriggio";
  }

 static List<DateTime> getCurrentWeek() {
    DateTime today = DateTime.now();
    List<DateTime> days = [];
    for (var i = 1; i < 15; i++) {
      days.add(today.subtract((Duration(days: today.weekday - i))));
    }

    return days;
  }

  static void showErrorDialog(BuildContext context, String errore) {

    if(Platform.isIOS){


      showDialog(context: context, builder: (_){
return CupertinoAlertDialog(
title: Text("Errore nella prenotazione"),
content: Text(errore));
      });



    }else{

      showDialog(context: context, builder: (_){
        return AlertDialog(

          elevation: 20,


          titleTextStyle: TextStyle(
              fontFamily: "Montserrat",
              fontSize: MediaQuery.of(context).size.height *0.01*multiplierSubtitle,
              fontWeight: FontWeight.bold,
              color: blackLight
          )  ,

            title: Text("Errore nella prenotazione",textAlign: TextAlign.center,style:TextStyle(
              fontFamily: "Montserrat",
              fontSize: MediaQuery.of(context).size.height *0.01*multiplierSubtitle,
              fontWeight: FontWeight.bold,
              color: blackLight
            ) ,),
            content: Text(errore,textAlign: TextAlign.center,style:TextStyle(
                fontFamily: "Montserrat",
                fontSize: MediaQuery.of(context).size.height *0.01*multiplierParagraph,
               color: blackLight

            ) ,),);
      });


    }


  }


}