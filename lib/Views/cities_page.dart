import 'package:bookingmobile2/Utils/componenti_riutilizzabili.dart';
import 'package:bookingmobile2/Utils/constants.dart';
import 'package:bookingmobile2/Views/select_office_page.dart';
import 'package:flutter/material.dart';

class CityPage extends StatelessWidget {
bool isSalabook;
CityPage(this.isSalabook);
  @override
  Widget build(BuildContext context) {
    double heightSize = MediaQuery.of(context).size.height;
    double widthSize = MediaQuery.of(context).size.width;
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    return Scaffold(
      backgroundColor: Color(0xFF151C3D) ,
      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          TopBar(color: Colors.white),

          Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Text("Scegli la sede", style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: multiplierBigTitle*unitHeightValue,
              color: Colors.white
             ),
            ),
          ),

          Padding(
            padding:  EdgeInsets.only(left: heightSize*0.04, right: 30, top: heightSize*0.05),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context, rootNavigator: true).pushNamed('/offices',  arguments: {'city': "Torino", "isSalabook":isSalabook});
                
                
              },
                child: Image.asset("assets/images/torino.png", width: heightSize*0.4,)
            )
          ),
          Padding(
              padding:   EdgeInsets.only(left:  heightSize*0.04, right: 30, top: heightSize*0.02),
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context, rootNavigator: true).pushNamed('/offices', arguments: {'city': "Milano", "isSalabook":isSalabook});
                },

                  child: Image.asset("assets/images/milano.png", width: heightSize*0.4)
              )
          ),
          Padding(
              padding:  EdgeInsets.only(left:  heightSize*0.04, right: 30, top: heightSize*0.02),
              child: GestureDetector(
                  onTap: (){
                    Navigator.of(context, rootNavigator: true).pushNamed('/offices',   arguments: {'city': "Roma", "isSalabook":isSalabook});
                  },
                  child: Image.asset("assets/images/roma.png", width: heightSize*0.4)
              )
          )
          




        ]

     )
    );






  }

}





