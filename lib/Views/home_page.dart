


import 'package:bookingmobile2/Bloc/profile_bloc.dart';
import 'package:bookingmobile2/Models/ModelProvider.dart';
import 'package:bookingmobile2/Repos/data_repo.dart';
import 'package:bookingmobile2/Utils/componenti_riutilizzabili.dart';
import 'package:bookingmobile2/Utils/constants.dart';
import 'package:bookingmobile2/Utils/functions.dart';
import 'package:bookingmobile2/Views/cities_page.dart';
import 'package:bookingmobile2/Views/prenotazioni_page.dart';
import 'package:bookingmobile2/Views/reservation_page.dart';
import 'package:bookingmobile2/Cubit/session_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/prenotazione_flow_bloc.dart';
import '../Cubit/session_cubit.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
super.initState();
  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double heightSize = MediaQuery.of(context).size.height;
    double widthSize = MediaQuery.of(context).size.width;
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;



    return   BlocBuilder<ProfileBloc, ProfileState>(

      builder: (context, profilestate) {
        return Scaffold(
          backgroundColor: backGround,
          body:
              Column(
              children: [
                SizedBox(height: heightSize*0.10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Text(
                        Functions.greetingSentence(),
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: multiplierBigTitle*unitHeightValue

                        ),


                      ),

                    ),
                    SizedBox(width: 50,),
                    GestureDetector(
                      onTap: (){

                      },
                      child:Image.asset(
                     'assets/images/Notification@2x.png',
                        scale: 1.9,


                      ),
                    ),
                    BlocBuilder<SessionCubit, SessionState>(
                      builder: (context, state) {

                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: GestureDetector(
                            onTap: (){

Navigator.of(context,rootNavigator: true).pushNamed("/account");

                            },
                            child:Image.asset(
                              'assets/images/Humburger2.png',
                              scale: 0.95,



                            ),
                          ),
                        );
                      }
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(left: 18),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${profilestate.name} ${profilestate.surname}",
                      style: TextStyle(
                          fontSize: multiplierSubtitle*unitHeightValue,
                          fontWeight: FontWeight.w300,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
                SizedBox(height: heightSize*0.05,),

                Flexible(
                 child: Stack(
                   clipBehavior: Clip.none,
                   alignment: Alignment.topCenter,
                   children: [
                     Container(
                     width: double.infinity,


                     decoration: BoxDecoration(
                         color: Color(0xFFF7F9FB),
                         borderRadius: BorderRadius.only(topLeft: Radius.circular(28),topRight: Radius.circular(28))

                     ),

                     child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         SizedBox(height: heightSize*0.1,),
                         Padding(
                           padding:  EdgeInsets.symmetric(horizontal: heightSize*0.04),
                           child: RichText(
                           textAlign: TextAlign.center ,

                             text: TextSpan(

                                 text: "Book a Workstation & ",
                                 style: TextStyle(
                                     fontFamily: "Poppins",
                                     fontSize: multiplierBigTitle*unitHeightValue,
                                     fontWeight: FontWeight.w700,
                                     color: Color(0xFF1E1E1E)


                                 ),
                                 children: [
                                   TextSpan(text: "Worskpace",
                                       style: TextStyle(
                                           fontFamily: "Poppins",
                                           fontSize:  multiplierBigTitle*unitHeightValue,
                                           fontWeight: FontWeight
                                               .w700,
                                           color: Color(0xFF10ACD5)

                                       )
                                   ),
                                   TextSpan(text: " On-Demand",
                                       style: TextStyle(
                                           fontFamily: "Poppins",
                                           fontSize:  multiplierBigTitle*unitHeightValue,
                                           fontWeight: FontWeight
                                               .w700,
                                           color: Color(0xFF1E1E1E)

                                       )
                                   ),

                                 ]


                             ),


                           ),
                         ),
                         SizedBox(height: heightSize*0.02,),
                         Padding(
                           padding: EdgeInsets.symmetric(horizontal: 15),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                             GestureDetector(
                               onTap: (){
                                 BlocProvider.of<BookBloc>(context).add(PrenotazioneStart());
                                 Navigator.of(context, rootNavigator: true).pushNamed("/cities",arguments: {'isSalabook':false});

                                 },

                               child: Container(
                                 height: heightSize*0.12,
                                 width: heightSize*0.12,
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(20),
                                   color: Colors.white,
                                   boxShadow: [
                                     BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.08), offset: Offset(0,3), blurRadius: 16)
                                   ]
                                 ),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     Image.asset("assets/images/razzo.png",scale: 1.1,),
                                     SizedBox(height: 15,),
                                     Text("Postazione", style: TextStyle(
                                       fontFamily: "Almarai",
                                       fontWeight: FontWeight.w400,
                                       fontSize: multiplierParagraph*unitHeightValue
                                     ),)
                                   ],

                                 ),

                               ),
                             ),
                               GestureDetector(
                                 onTap: (){
                                   BlocProvider.of<BookBloc>(context).add(PrenotazioneStart());
                                   Navigator.of(context, rootNavigator: true).pushNamed("/cities",arguments: {'isSalabook':true});

                                 },
                                 child: Container(
                                   height: heightSize*0.12,
                                   width: heightSize*0.12,
                                   decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(20),
                                       color: Colors.white,
                                       boxShadow: [
                                   BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.08), offset: Offset(0,3), blurRadius: 16)
                                   ]
                                   ),
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                       Image.asset("assets/images/alieni.png",scale: 1.1,),
                                       SizedBox(height: 15,),
                                       Text("Sala riunioni", style: TextStyle(
                                           fontFamily: "Almarai",
                                           fontWeight: FontWeight.w400,
                                           fontSize: multiplierParagraph*unitHeightValue
                                       ),)
                                     ],

                                   ),

                                 ),
                               ),
                               GestureDetector(
                                 onTap: (){

                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>PrenotazioniPage()));
                                 },
                                 child: Container(
                                   height: heightSize*0.12,
                                   width: heightSize*0.12 ,
                                   decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(20),
                                       color: Colors.white,
                                       boxShadow: [
                                         BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.08), offset: Offset(0,3), blurRadius: 16)
                                       ]
                                   ),
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                       Image.asset("assets/images/luna.png",scale: 1.1,),
                                       SizedBox(height: 15,),
                                       Text("Prenotazioni", style: TextStyle(
                                           fontFamily: "Almarai",
                                           fontWeight: FontWeight.w400,
                                           fontSize: multiplierParagraph*unitHeightValue
                                       ),)
                                     ],

                                   ),


                                 ),
                               ),
                             ],
                           ),

                         ),
                         SizedBox(height: heightSize*0.01,),
                         Padding(
                             padding: EdgeInsets.only(left: 15, top: heightSize*0.01),
                           child: Text(
                             "Consigliati per te",

                             style: TextStyle(
                               fontSize: multiplierSubtitle2*unitHeightValue,
                               fontWeight: FontWeight.w600,
                               color: Color(0xFF1E1E1E),

                             ),
                           ),
                         ),

                  fetchAllFavorites(context, profilestate),
                       ],
                     ),
                   ),
                     Positioned(
                       top: -heightSize*0.06,


                       child: Image.asset("assets/images/astronautaHome.png", width: heightSize*0.16,

                       ),
                     ),

                   ]
                 ),
                  ),
              ])
        );
      }
    );

  }


  Widget fetchAllFavorites(BuildContext context, ProfileState profilestate) {
    double heightSize = MediaQuery.of(context).size.height;
    double widthSize = MediaQuery.of(context).size.width;
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;




    if(profilestate.preferiti == null || profilestate.preferiti!.isEmpty){
      return Flexible(

          child:   Padding(
            padding:  EdgeInsets.only(top:heightSize*0.06,left: 25,right: 25),
            child: Container(
              height: heightSize*0.2,
              width: widthSize,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        backGround.withOpacity(0.90),
                        backGround.withOpacity(0.85)

                      ]

                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(color: Colors.grey, offset: Offset(0,7), blurRadius: 25)
                  ]
              ),
              child: Padding(
                padding:  EdgeInsets.only(right: 20.0, left: 20),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(

                    "Aggiungi un ufficio o una sala riunioni tra i preferiti",textAlign: TextAlign.center,  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: heightSize*0.025,
                      fontFamily: "Monteserrat",
                      color:  Colors.white


                  ),
                  ),
                ),
              ),
            ),
          )
      );}
    else  {
      return Flexible(
        child: ListView.builder(
            padding: EdgeInsets.symmetric(
                vertical: heightSize * 0.004),
            itemCount: profilestate.preferiti!.length,
            itemBuilder: (BuildContext context,
                int index) {
              return GestureDetector(
                onTap: () {
                  Prenotazione pre = Prenotazione(
                      officeID: profilestate.preferiti!.elementAt(index).id);
                  BlocProvider.of<BookBloc>(context)
                      .add(PrenotazioneBuilding(
                      PrenotazioneState(
                          prenotazione: pre)));

                  Navigator.of(context,rootNavigator:true).pushNamed( "/reservation", arguments: {"office":profilestate.preferiti!.where((element) => element.id==pre.officeID).toList().first});
                },
                child: (
                    OfficeCard(
                      ufficio: profilestate.preferiti!
                          .elementAt(
                          index),)
                ),
              );
            }),
      );
    }



    //To implemented

  }


}

