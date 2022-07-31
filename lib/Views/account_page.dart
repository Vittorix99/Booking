

import 'dart:io';

import 'package:bookingmobile2/Bloc/login_bloc.dart';
import 'package:bookingmobile2/Bloc/profile_bloc.dart';
import 'package:bookingmobile2/Cubit/session_cubit.dart';
import 'package:bookingmobile2/Utils/componenti_riutilizzabili.dart';
import 'package:bookingmobile2/Utils/constants.dart';
import 'package:bookingmobile2/Cubit/session_state.dart';
import 'package:bookingmobile2/Utils/functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double heightSize = MediaQuery.of(context).size.height;
    double widthSize = MediaQuery.of(context).size.width;
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;

    return BlocBuilder<SessionCubit , SessionState>(
      builder: (context, state) {
        return Scaffold(

          backgroundColor: Color(0xFFE5E5E5),

          body: BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state){
              final formStatus = state.formStatus;
              if(formStatus is SubmissionFailed){
                Functions.showSnackBar(context, formStatus.message);
              }
            },
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, profilestate) {

                return Stack(

                  children:
                  [
                    SingleChildScrollView(
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TopBar(color: Color(0xFF1E1E1E), function: () => Navigator.of(context, rootNavigator: true).pop()), //BlocProvider.of<SessionCubit>(context).emit(Authenticated(profilestate.user!)),),
                        Padding(
                        padding:  EdgeInsets.only(top: 0, bottom: heightSize*0.03),
                        child:

                        Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white70

                            ),
                            width: heightSize*0.085*2,
                            height: heightSize*0.085*2,
                            child: profilestate.avatarPath == null? Icon(Icons.person,size: 50,):
                                Builder(
                                  builder: (context) {

                                    try {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: CachedNetworkImage(
                                          imageUrl: profilestate.avatarPath!,
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error){
                                            return Icon(Icons.person,size: 50,);

                                            },

                                        ),
                                      );
                                    }catch(e){
                                      return Icon(Icons.person,size: 50,);


                                    }
                                  }
                                )


                        ),
                          ),

                        Text("${profilestate.name} ${profilestate.surname}", style: TextStyle(
                          fontSize: unitHeightValue*multiplierBigTitle,
                          fontWeight: FontWeight.bold,



                        ),),

                      Container(
                        alignment: Alignment.center,

                        child: ListView(
                          padding: EdgeInsets.only(top: heightSize>600? heightSize*0.05:0, bottom: 20),
                          scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        dragStartBehavior: DragStartBehavior.down,



                        children: [ Padding(
                            padding:  EdgeInsets.only(left: 25.0, right: 25),
                            child: ListTile(
                              leading: PurpleBox(larghezza: heightSize*0.05 ,lunghezza: heightSize*0.05,image: Image.asset("assets/images/accountAstronauta.png", fit: BoxFit.contain,),),
                              title: Text("Dati Account", style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: unitHeightValue*multiplierSubtitle2
                              ),),
                              trailing: IconButton(
                                onPressed: () {

                                  Navigator.of(context).pushNamed("/account_details");

                                },
                                icon: Image.asset("assets/images/chevron-right.png",scale: 0.5,),


                              ),

                            ),


                          ),

                          Padding(
                              padding: EdgeInsets.symmetric(vertical: heightSize<600? heightSize*0.01: heightSize*0.025, horizontal: 35),
                            child: Container(
                              width: widthSize,
                              height: 2,
                              color: Color(0xFFD8D8D8),
                            ),


                          ),
                          if(!profilestate.isLoggedWithGoogle)...[
                          Padding(
                            padding:  EdgeInsets.only(left: 25.0,right: 25, bottom: heightSize*0.012, top:heightSize*0.001 ),
                            child: ListTile(
                              leading: RoundedBox(larghezza: heightSize*0.049 ,lunghezza: heightSize*0.049,color: Colors.white, image: Image.asset("assets/images/alien.png", fit: BoxFit.contain, scale: heightSize>1400? 1 : 1.2,),),
                              title: Text("Cambio Password", style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: unitHeightValue*multiplierSubtitle2*0.94
                              ),),
                              trailing: IconButton(
                                onPressed: () { Navigator.of(context).pushNamed("/password"); },
                                icon: Image.asset("assets/images/chevron-right.png",scale: 0.5,),


                              ),

                            ),
                          ),
                          ],

                         /* Padding(
                            padding:  EdgeInsets.only(left: 25.0,right: 25, bottom: heightSize*0.012, top:heightSize*0.001 ),
                            child: ListTile(
                              leading: RoundedBox(larghezza: heightSize*0.049 ,lunghezza: heightSize*0.049,color: Colors.white, image: Image.asset("assets/images/alien.png", fit: BoxFit.contain, scale: heightSize>1400? 1 : 1.2,),),
                              title: Text("Impostazioni", style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: unitHeightValue*multiplierSubtitle2*0.94
                              ),),
                              trailing: IconButton(
                                onPressed: () {  },
                                icon: Image.asset("assets/images/chevron-right.png",scale: 0.5,),


                              ),

                            ),
                          ),*/

                         if(profilestate.user?.role == "admin")...[
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 25.0, vertical: heightSize*0.012),
                            child: ListTile(
                              leading: RoundedBox(larghezza: heightSize*0.049 ,lunghezza: heightSize*0.049,color: Colors.white, image: Image.asset("assets/images/alien.png", fit: BoxFit.contain, scale: heightSize>1400? 1 : 1.2,),),
                              title: Text("Gestisci Uffici", style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: unitHeightValue*multiplierSubtitle2*0.94
                              ),),
                              trailing: IconButton(
                                onPressed: () { Navigator.of(context).pushNamed("/gestisci_uffici"); },
                                icon: Image.asset("assets/images/chevron-right.png",scale: 0.5,),


                              ),

                            ),
                          ),
                         /* Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 25.0, vertical: heightSize*0.012),
                            child: ListTile(
                              leading: RoundedBox(larghezza: heightSize*0.049 ,lunghezza: heightSize*0.049,color: Colors.white, image: Image.asset("assets/images/alien.png", fit: BoxFit.contain, scale: heightSize>1400? 1 : 1.2,),),
                              title: Text("Elimina Utente o ufficio", style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: unitHeightValue*multiplierSubtitle2*0.94
                              ),),
                              trailing: IconButton(
                                onPressed: () {  },
                                icon: Image.asset("assets/images/chevron-right.png",scale: 0.5,),


                              ),

                            ),
                          ),*/
                          ],
                          Padding(
                            padding: EdgeInsets.only( right: 35, left: 35),
                            child: Container(
                              width: widthSize,
                              height: 2,
                              color: Color(0xFFD8D8D8),
                            ),


                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding:  EdgeInsets.only(left: 25.0,right: 25.0, bottom: heightSize*0.034, top: heightSize>600? heightSize*0.05: heightSize*0.01),
                              child: ListTile(
                                leading: RoundedBox(larghezza: heightSize*0.05 ,lunghezza: heightSize*0.05,color: Colors.white, image: Image.asset("assets/images/blackHole.png", fit: BoxFit.contain,),),
                                title: Text("Logout", style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: unitHeightValue*multiplierSubtitle2*0.94
                                ),),
                                trailing: IconButton(
                                  onPressed: () async {

                                    if(profilestate.isLoggedWithGoogle) {

                                      try {
                                     bool isLoggedOut =  await  BlocProvider.of<SessionCubit>(context).GoogleSignOut();
                                     if (isLoggedOut)  Navigator.of(context, rootNavigator: true).pop();


                                      } catch(e){
                                       print(e.toString());
                                        throw e;
                                      }

                                    }
                                   else {
                                      BlocProvider.of<SessionCubit>(context)
                                          .signOut();
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    }








                                  },
                                  icon: Image.asset("assets/images/chevron-right.png",scale: 0.5,),


                                ),

                              ),
                            ),
                          ),
                   ] ),
                      )



                      ],


                  ),
                    ),
                    Positioned(
                      left: widthSize*0.23,
                      top: heightSize*0.2,

                      child: CustomPaint(
                        painter: DrawCircle(Color(0xFF151C3D).withOpacity(0.32), 18),
                      ),
                    ),
                    Positioned(
                      left: widthSize*0.3,
                      top: heightSize*0.25,

                      child: CustomPaint(
                        painter: DrawCircle(Color(0xFF8645FF).withOpacity(0.14), 30),
                      ),
                    ),
                    Positioned(
                      right: widthSize*0.26,
                      top: heightSize*0.24,

                      child: CustomPaint(
                        painter: DrawCircle(Color(0xFF10ACD5).withOpacity(0.14), 27),
                      ),
                    ),
                    Positioned(
                      right: widthSize*0.2,
                      top: heightSize*0.22,

                      child: CustomPaint(
                        painter: DrawCircle(Color(0xFF8645FF).withOpacity(0.3), 15),
                      ),
                    ),


                ]
                );
              }
            ),
          ),




        );
      }
    );
  }
}

