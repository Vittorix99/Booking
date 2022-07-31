import 'package:bookingmobile2/Cubit/session_cubit.dart';
import 'package:bookingmobile2/Cubit/session_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_page.dart';


class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double heightSize = MediaQuery.of(context).size.height;
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double multiplierBigTitle =3.5;
    double multiplierParagraph = 2.1;
    print(heightSize);
    double picSize = 0;
    picSize = heightSize> 700?  0.98:(heightSize<600? 1.29:1.09);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:  Color(0xFF151C3D),
      floatingActionButton: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 8.0, vertical: 14),
        child: GestureDetector(
          onTap: (){

            BlocProvider.of<SessionCubit>(context).showAuth();


          },
          child: Container(

              width: double.infinity,
              height: unitHeightValue*8,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
              ),
              child:
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Accedi",
                  style: TextStyle(

                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: "Poppins"

                  ),
                  textAlign: TextAlign.center,


                ),
              )


          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,


      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.45,
                color: Color(0xFF151A2E),


              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height*0.38,
                decoration: BoxDecoration(
                  color: Colors.white, 
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)))
                ,

                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height*0.025,),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 18, vertical: unitHeightValue*3),
                        child: RichText(


                          text: TextSpan(

                              text: "Book a Workstation & ",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize:multiplierBigTitle * unitHeightValue,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1E1E1E)


                              ),
                              children: [
                                TextSpan(text: "Worskpace",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: multiplierBigTitle * unitHeightValue,
                                        fontWeight: FontWeight
                                            .w700,
                                        color: Color(0xFF10ACD5)

                                    )
                                ),
                                TextSpan(text: " On-Demand",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: multiplierBigTitle * unitHeightValue,
                                        fontWeight: FontWeight
                                            .w700,
                                        color: Color(0xFF1E1E1E)

                                    )
                                ),

                              ]


                          ),


                        )
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 18, ),
                      child: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut eiusmod tempor ",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: multiplierParagraph*unitHeightValue,


                        ),
                      ),

                    )


                  ],
                ),

              ),
              Flexible(
                child: Container(
                  width: double.infinity,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.5,

                  color: Color(0xFF151C3D),
                  child:  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 20, horizontal: 16),


                  ),
                ),
              ),






                  ]
              ),

          Positioned(
              left: heightSize>800?  MediaQuery.of(context).size.width*0.04:MediaQuery.of(context).size.width*0.078 ,
              top: MediaQuery.of(context).size.height*0.03,
              child: Image.asset("assets/images/astronauta.png", scale: picSize,)


          ),
          Positioned(
              top:MediaQuery.of(context).size.height*0.276,
              left:heightSize>800?  MediaQuery.of(context).size.height*0.07: MediaQuery.of(context).size.height*0.08,
              child: Container(
                width:heightSize>800? MediaQuery.of(context).size.width*0.35:MediaQuery.of(context).size.width*0.29,
                height:MediaQuery.of(context).size.width*0.2,
                
                decoration: BoxDecoration(
                  color:  Color(0xFF10ACD5),
                  borderRadius: BorderRadius.circular(28)
    
                ),
              )
          )

        ],

      )
    );


  }
}