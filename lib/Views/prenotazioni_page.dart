

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:bookingmobile2/Bloc/prenotazione_flow_bloc.dart';
import 'package:bookingmobile2/Bloc/profile_bloc.dart';
import 'package:bookingmobile2/Repos/data_repo.dart';
import 'package:bookingmobile2/Repos/prenotazioni_repo.dart';
import 'package:bookingmobile2/Utils/componenti_riutilizzabili.dart';
import 'package:bookingmobile2/Utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Models/Office.dart';
import '../Models/Postazione.dart';
import '../Models/Prenotazione.dart';
import '../Models/Sala.dart';

class PrenotazioniPage extends StatefulWidget {


  @override
  State<PrenotazioniPage> createState() => _PrenotazioniPageState();
}

class _PrenotazioniPageState extends State<PrenotazioniPage> with SingleTickerProviderStateMixin {
AnimationController? _animationController;
bool showBookingsCardAfterDelete = false;


@override
void initState(){
  super.initState();
  _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));

  
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


    return BlocBuilder<ProfileBloc, ProfileState>(


      builder: (context,state) {
        return Scaffold(
          backgroundColor: backGround2,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBar(color: blackLight, function: (){Navigator.of(context).pop();},),
              Padding(
                padding:  EdgeInsets.symmetric(vertical: heightSize*0.02, horizontal: 20),
                child: Text("Le tue prenotazioni", style: TextStyle(
                  fontSize: multiplierBigTitle2*unitHeightValue,
                  fontWeight: FontWeight.bold,

                ),),
              ),
              Flexible(child: _buildList(context, state))








            ],
          ),

        );
      }
    );
  }
  Widget _buildList(BuildContext context, ProfileState state
      ){
    double heightSize = MediaQuery.of(context).size.height;
    double widthSize = MediaQuery.of(context).size.width;
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
  return  FutureBuilder<List<Prenotazione>?>(
    future: context.read<PrenotazioniRepo>().fetchPrenotazioniOfUser(state.user!.mail!),
    builder : (context, prenotazioni) {

      if(prenotazioni.hasData) {
        if (prenotazioni.data != null && prenotazioni.data!.isNotEmpty) {
         // prenotazioni.data?.sort((a,b)=> a.date!.compareTo(b.date!));
          return AnimatedList

            (
              key: listKey,
              initialItemCount: prenotazioni.data!.length,

              itemBuilder: (context, index, animation) {
                return SlideTransition(
                    position: animation.drive(
                        Tween<Offset>(begin: Offset(0, 3), end: Offset(0, 0))
                            .chain(CurveTween(curve: Curves.ease)))
                    ,
                    child: prenotazioni.data![index].salaID == null
                        ? PrenotazioneCard(prenotazioni.data![index], index)
                        : PrenotazioneSalaCard(
                        prenotazioni.data![index], index));
              }
          );
        }
        else {
          return Padding(
            padding: EdgeInsets.only(
                top: heightSize * 0.15, left: 25, right: 25),
            child: Container(
              height: heightSize * 0.2,
              width: widthSize,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(3, 0),
                        blurRadius: 20)
                  ]
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(

                  "Non ci sono prenotazioni", textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: heightSize * 0.025,
                      fontFamily: "Monteserrat",
                      color: Color(0xFF151C3D)


                  ),
                ),
              ),
            ),
          );
        }
      }else return Loading();
    }
    );



  }
}





class PrenotazioneCard extends StatelessWidget {
  Prenotazione prenotazione;
  int index;

  PrenotazioneCard(this.prenotazione, this.index);


  @override
  Widget build(BuildContext context) {

    double heightSize = MediaQuery.of(context).size.height;
    double widthSize = MediaQuery.of(context).size.width;
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    return FutureBuilder<Office?>(
        future: context.read<DataRepository>().getOfficeById(prenotazione.officeID!),
        builder: (context, ufficio) {
          if(prenotazione.postazione!=null) {
            if (ufficio.hasData) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Container(
                  width: widthSize,
                  height: heightSize * 0.163,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            blurRadius: 10
                        )


                      ]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,


                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 12, right: 12,),
                        child: Row(

                          children: [
                            Image.asset(
                              "assets/images/orbytaIcon.png", scale: 1.6,),
                            SizedBox(width: 8,),
                            Text(ufficio.data!.name, style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: multiplierParagraph * unitHeightValue *
                                  1.1,

                            ),),
                            Spacer(),
                            Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: PopUpMen(menuList: [

                                  PopupMenuItem(

                                      child:
                                      ListTile(

                                          leading: Icon(
                                            Icons.delete, color: Colors.red,
                                            size: 22,),
                                          title: Text(
                                            "Elimina", style: TextStyle(
                                              fontSize: multiplierSubtitle2 *
                                                  unitHeightValue
                                          ),),
                                          onTap: () {
                                            Navigator.pop(context);
                                            _removeItem(index, context);
                                            BlocProvider.of<ProfileBloc>(
                                                context).add(DeletePrenotazione(
                                                prenotazione));
                                          })
                                  )
                                ],
                                  icon: Icon(
                                    Icons.more_horiz, color: purpleFluo,
                                    size: 22,),
                                )
                            )
                          ],

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15.0,),
                        child: Text(
                          "${prenotazione.name} ${prenotazione.surname}",
                          style: TextStyle(
                              fontSize: unitHeightValue * multiplierParagraph *
                                  1.1
                          ),),
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 15.0,),
                        child: Text(ufficio.data!.indirizzo, style: TextStyle(
                            fontSize: unitHeightValue * multiplierParagraph *
                                1.1
                        ),),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 9.0, left: 9,),
                          child: Row(
                              children: [
                                Icon(Icons.person_outline,
                                  color: Color(0xFFAFAFB0),
                                  size: heightSize * 0.03,),
                                SizedBox(width: 6,),
                                FutureBuilder<Postazione?>(
                                  future: context.read<DataRepository>().getPostazioneById(prenotazione.prenotazionePostazioneId!),
                                  builder: (context, postazione) {
                                    if(postazione.hasData)
                                    return Text(postazione.data != null
                                        ?  postazione.data!.postazione!
                                        : " ",
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w500,
                                            fontSize: heightSize * 0.01 *
                                                multiplierParagraph));

                                    else return Loading();
                                  }
                                ),

                                SizedBox(width: 10,),

                                Icon(Icons.calendar_today,
                                  color: Color(0xFFAFAFB0),
                                  size: heightSize * 0.023,),

                                SizedBox(width: 6,),

                                Text("${prenotazione.date!.day}/${prenotazione
                                    .date!.month}/${prenotazione.date!.year}"
                                    , style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w500,
                                        fontSize: heightSize * 0.01 *
                                            multiplierParagraph)),

                                SizedBox(width: 10,),


                                Icon(
                                  Icons.access_time, color: Color(0xFFAFAFB0),
                                  size: heightSize * 0.023,),

                                SizedBox(width: 6,),
                                Text("h ${prenotazione.startTime
                                    .toString()}:00-${prenotazione.endTime
                                    .toString()}:00", style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500,
                                    fontSize: heightSize * 0.01 *
                                        multiplierParagraph))


                              ]
                          ),
                        ),
                      )
                    ],

                  ),
                ),
              );
            } else
              return Loading();
          }else return Loading();

        }
    );
  }

  void _removeItem(int index, BuildContext context) {
    double heightSize = MediaQuery.of(context).size.height;
    double widthSize = MediaQuery.of(context).size.width;
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;

   listKey.currentState!.removeItem(index, (context, animation){

      return SlideTransition(
          position:animation.drive(Tween<Offset>(begin: Offset(3,0), end: Offset(0,0)).chain(CurveTween(curve: Curves.ease)))
          ,child: PrenotazioneCard(prenotazione, index ));
    });


    }
}

class PrenotazioneSalaCard extends StatelessWidget {
  Prenotazione prenotazione;
  int index;

  PrenotazioneSalaCard(this.prenotazione, this.index);


  @override
  Widget build(BuildContext context) {

    double heightSize = MediaQuery.of(context).size.height;
    double widthSize = MediaQuery.of(context).size.width;
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    return FutureBuilder<Office?>(
        future: context.read<DataRepository>().getOfficeById(prenotazione.officeID!),
        builder: (context, ufficio) {
          if(ufficio.hasData) {
            return FutureBuilder<Sala?>(
              future:context.read<DataRepository>().getSalaById(prenotazione.salaID!),
              builder: (context, sala) {
                if(sala.hasData && sala.data != null)
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
                    width: widthSize,
                    height: heightSize * 0.163,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.6),
                              blurRadius: 10
                          )


                        ]
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,


                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 12, right: 12, ),
                          child: Row(

                            children: [
                              Image.asset("assets/images/orbytaIcon.png", scale: 1.6,),
                              SizedBox(width: 8,),
                              Text(ufficio.data!.name, style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: multiplierParagraph * unitHeightValue * 1.1,

                              ),),
                              Spacer(),
                              Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: PopUpMen(menuList: [

                                    PopupMenuItem(

                                        child:
                                        ListTile(

                                            leading: Icon(Icons.delete, color: Colors.red,size: 22,),
                                            title: Text("Elimina", style: TextStyle(
                                                fontSize: multiplierSubtitle2*unitHeightValue
                                            ),),
                                            onTap: (){
                                              Navigator.pop(context);
                                              _removeItem(index, context);
                                              BlocProvider.of<ProfileBloc>(context).add(DeletePrenotazione(prenotazione));

                                            })
                                    )
                                  ],
                                    icon: Icon(Icons.more_horiz, color: purpleFluo,size: 22,),
                                  )
                              )
                            ],

                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15.0,),
                          child: Text("Sala ${sala.data!.name}", style: TextStyle(
                              fontSize: unitHeightValue * multiplierParagraph * 1.1
                          ),),
                        ),

                        Padding(
                          padding: EdgeInsets.only(left: 15.0,),
                          child: Text(ufficio.data!.indirizzo, style: TextStyle(
                              fontSize: unitHeightValue * multiplierParagraph * 1.1
                          ),),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 9.0, left: 9,),
                            child: Row(
                                children: [


                                  Icon(Icons.calendar_today, color: Color(0xFFAFAFB0),
                                    size: heightSize * 0.023,),

                                  SizedBox(width: 6,),

                                  Text("${prenotazione.date!.day}/${prenotazione.date!.month}/${prenotazione.date!.year}"
                                      , style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500,
                                          fontSize: heightSize * 0.01 *
                                              multiplierParagraph)),

                                  SizedBox(width: 10,),


                                  Icon(Icons.access_time, color: Color(0xFFAFAFB0),
                                    size: heightSize * 0.023,),

                                  SizedBox(width: 6,),
                                  Text("h ${prenotazione.startTime
                                      .toString()}:00-${prenotazione.endTime
                                      .toString()}:00", style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w500,
                                      fontSize: heightSize * 0.01 *
                                          multiplierParagraph))


                                ]
                            ),
                          ),
                        )
                      ],

                    ),
                  ),
                );
                else return Loading();
              }
            );
          }else return Loading();
        }
    );
  }

  void _removeItem(int index, BuildContext context) {
    double heightSize = MediaQuery.of(context).size.height;
    double widthSize = MediaQuery.of(context).size.width;
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;

    listKey.currentState!.removeItem(index, (context, animation){

      return SlideTransition(
          position:animation.drive(Tween<Offset>(begin: Offset(3,0), end: Offset(0,0)).chain(CurveTween(curve: Curves.ease)))
          ,child: PrenotazioneCard(prenotazione, index ));
    });


  }
}







  class PopUpMen extends StatelessWidget{
  List<PopupMenuEntry> menuList;

  final Widget? icon;

  PopUpMen({ required this.menuList, this.icon});




  @override
  Widget build(BuildContext context) {
    return  PopupMenuButton(

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),  ),
        itemBuilder: (context){
          return menuList;
          },
        icon: icon,
    );


  }




}

