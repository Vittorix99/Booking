

import 'package:bookingmobile2/Bloc/calendar_Bloc.dart';
import 'package:bookingmobile2/Bloc/profile_bloc.dart';
import 'package:bookingmobile2/BottomSheets/prenotazione_sheet.dart';
import 'package:bookingmobile2/Models/ModelProvider.dart';
import 'package:bookingmobile2/Models/Prenotazione.dart';
import 'package:bookingmobile2/Repos/data_repo.dart';
import 'package:bookingmobile2/Repos/prenotazioni_repo.dart';
import 'package:bookingmobile2/Repos/storage_repo.dart';

import 'package:bookingmobile2/Utils/componenti_riutilizzabili.dart';
import 'package:bookingmobile2/Utils/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'dart:ui' as ui;

import '../Bloc/prenotazione_flow_bloc.dart';

import '../Models/Calendar.dart';

import '../Models/Postazione.dart';
import 'confirm_reservation.dart';

class SelectPostazionePage extends StatefulWidget {
Office office;
SelectPostazionePage(this.office);

  @override
  _SelectPostazionePageState createState() => _SelectPostazionePageState();
}

class _SelectPostazionePageState extends State<SelectPostazionePage> {
  int selectedItem = -1;
   bool putBlankSpace = false;
  Postazione? pos;
  SfRangeValues _rangeValues = SfRangeValues(9, 18);

  SfRangeValues get rangeValues => _rangeValues;

  set rangeValues(SfRangeValues value) {
    _rangeValues = value;
  }

  late RangeValues range;
  CalendarBloc _calendarBloc = CalendarBloc();


@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  @override
  void initState() {
    // TODO: implement initState
 //
    super.initState();
    range =  RangeValues(9 , 18);

  }

  @override
  Widget build(BuildContext context) {
    final bookBloc = BlocProvider.of<BookBloc>(context);


    double unitHeightValue = MediaQuery
        .of(context)
        .size
        .height * 0.01;
    double heightSize = MediaQuery
        .of(context)
        .size
        .height;
    double widthSize = MediaQuery
        .of(context)
        .size
        .width;

        return BlocBuilder<BookBloc, PrenotazioneState>(
              builder: (context,state) {


                return FutureBuilder<List<Prenotazione>>(
                  future: context.read<PrenotazioniRepo>().getPrenotazioniByDayAndOffice(widget.office, state.prenotazione!.date),
                  builder: (context,prenotazioniDelGiorno) {
                    return Scaffold(
                      backgroundColor: backGround,
                      floatingActionButtonLocation: FloatingActionButtonLocation
                          .centerDocked,
                      floatingActionButton: Padding(
                        padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                        child: GestureDetector(
                          onTap: () {
                            if (this.selectedItem != -1) {
                              PrenotazioneState pre = state;
                              pre.prenotazione!.postazione = this.pos;
                              pre.prenotazione!.prenotazionePostazioneId = this.pos!.id;


                              bookBloc.add(PrenotazioneBuilding(pre));



                              showModalBottomSheet(shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(40),
                                    topLeft: Radius.circular(40)),
                              ),

                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return PrenotazioneSheet(state: pre, isForSala: false,);
                                  });
                            }




                          },
                          child: Container(
                            width: double.infinity,
                            height: heightSize * 0.075,
                            decoration: BoxDecoration(
                                color: selectedItem == -1 ? backGround : Colors
                                    .white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      color: selectedItem == -1
                                          ? backGround
                                          : Colors
                                          .white10,
                                      offset: Offset(0, 3),

                                      blurRadius: 15
                                  )
                                ]
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("PRENOTA LA POSTAZIONE", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: multiplierSubtitle * unitHeightValue,
                                fontWeight: FontWeight.w700,
                                color: selectedItem == -1
                                    ? Colors.white
                                    : backGround,
                              ),),
                            ),
                          ),
                        ),
                      ),
                      body: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TopBar(color: Colors.white),

                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text("Scegli la sede", style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: multiplierBigTitle * unitHeightValue,
                                color: Colors.white
                            ),
                            ),
                          ),


                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 10, left: 15, right: 15, bottom: heightSize*0.1 ),
                              child: Container(

                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Color(0x14FFFFFF),
                                      borderRadius: BorderRadius.circular(16)
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: heightSize * 0.03, vertical: 0),
                                    child: FutureBuilder<List<Postazione>?>(
                                      future: context.read<DataRepository>().getPostazioniofOffice(widget.office),
                                      builder: (context, postazioni) {
                                        int addedIndex = (widget.office.capienza/4).toInt();
                                        int itemCount = widget.office.capienza +addedIndex;
                                        int indice = -1;

                                        if(postazioni.hasData && postazioni.data!.isNotEmpty) {
                                         postazioni.data!.sort((a,b)=> a.postazione!.compareTo(b.postazione!) );
                                         return StaggeredGridView.countBuilder(
                                           addAutomaticKeepAlives:true
                                             ,
                                             padding: EdgeInsets.only(top: 10),
                                             crossAxisCount: 4,
                                             shrinkWrap: true,
                                             itemCount:itemCount,
                                             crossAxisSpacing: 12,
                                             mainAxisSpacing: 12,
                                             itemBuilder: (context, index) {
                                               Postazione pos;
                                               if ((index + 1) % 5 != 0) indice++;

                                                try {
                                                pos = postazioni
                                                      .data!.elementAt(indice);
                                                }catch(e){
                                                   pos = Postazione(officeID: widget.office.id,postazione: "P"+indice.toString());
                                                  context.read<DataRepository>().addPostazione(pos);

                                                }
                                             if(pos == null){
                                       Postazione pos = Postazione(officeID: widget.office.id,postazione: "P"+index.toString());
                                       context.read<DataRepository>().addPostazione(pos);
                                                           }

                                             if ((index + 1) % 5 == 0) {
                                              // if (putBlankSpace == false) {
                                                   Container c = Container(
                                                     width: double.infinity,
                                                     height: 2,
                                                     color: Colors.white24,
                                                   );


                                                     return c;
                                                 /* else {
                                                   SizedBox ret = new SizedBox(
                                                     height: heightSize *
                                                         0.03,);
                                                   putBlankSpace = false;
                                                   return ret;
                                                 }*/
                                               }else {
                                                 List<
                                                     Prenotazione> pre = prenotazioniDelGiorno
                                                     .requireData.where((
                                                     element) =>
                                                 element
                                                     .prenotazionePostazioneId ==
                                                     pos.id).toList();


                                                 if (pre.isEmpty) {


                                                   return Padding(
                                                     padding: EdgeInsets
                                                         .symmetric(
                                                         vertical: 6),
                                                     child: GestureDetector
                                                       (
                                                         onTap: () {
                                                           putBlankSpace =
                                                           false;

                                                           setState(() {
                                                             this.pos = pos;
                                                             selectedItem =
                                                                 index;
                                                           });
                                                         },
                                                         child: BookingBox(
                                                             larghezza: 5,
                                                             lunghezza: 5,
                                                             selected: this
                                                                 .selectedItem ==
                                                                 index)


                                                     ),
                                                   );

                                                 }

                                                 else {

                                                   return FutureBuilder<
                                                       String?>(
                                                       future: _getUserAvatar(
                                                           pre.first.mail,
                                                           context),
                                                       builder: (context,
                                                           avatarUrl) {
                                                         if (avatarUrl
                                                             .hasData) {

                                                             return Padding(
                                                               padding: EdgeInsets
                                                                   .symmetric(
                                                                   vertical: 6),
                                                               child: Tooltip(
                                                                 message: "${pre.first.name} ${pre.first.surname} ",
                                                                 child: ClipRRect(
                                                                   borderRadius: BorderRadius
                                                                       .circular(
                                                                       20),
                                                                   child: Container(

                                                                     width: 26,
                                                                     height: 26,
                                                                     decoration: BoxDecoration(
                                                                       borderRadius: BorderRadius
                                                                           .circular(
                                                                           20),
                                                                       color: Colors
                                                                           .white70,


                                                                     ),
                                                                     child: Builder(
                                                                         builder: (
                                                                             context) {
                                                                           try {
                                                                             return ImageSliver(
                                                                                 pre.first
                                                                                     .picture ??
                                                                                     " ", pre.first);
                                                                           } catch (e) {
                                                                             return Icon(
                                                                               Icons
                                                                                   .person,
                                                                               size: 50,);
                                                                           }
                                                                         }
                                                                     ),

                                                                   ),
                                                                 ),
                                                               ),
                                                             );

                                                         }
                                                         else
                                                           return Loading();

                                                       });
                                                 }





                                               }
                                             },
                                             staggeredTileBuilder: (index) =>
                                             (index + 1) % 5 == 0
                                                 ? StaggeredTile.fit(6)
                                                 : StaggeredTile.count(1, 1)


                                         );
                                       }
                                       else{
                                         return Center(child: Loading(),);
                                       }
                                      }
                                    ),

                                  )
                              ),
                            ),
                          ),

                        ],

                      ),


                    );
                  }
                );
              }
          );



  }

  Future<String?> _getUserAvatar(String? mail, BuildContext context) async {
    try {
      User? us = await context.read<DataRepository>().getUserByMail(mail!);

      if (us != null) {
        String res = await context.read<StorageRepository>()
            .getProfileImageByUser(us);
        if(res!= null)
        return res;
        else return null;
      }


    }catch(e){

      print(e);
      return null;
    }


  }






  /*Widget _alreadyBookedSheet(){
    double heightSize = MediaQuery.of(context).size.height;
    var selectedRange = RangeValues(9, 18);
    return  Container(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.82,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18))),
      child: StreamBuilder<List<Calendar>>(
          stream: _calendarBloc.calendarListStream,
          initialData: _calendarBloc.calendarList,
          builder: (context, snapshot) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(

                  child: Padding(
                      padding: EdgeInsets.all(
                          MediaQuery
                              .of(context)
                              .size
                              .height * 0.01),
                      child: Container(
                        height: 4,
                        width: MediaQuery
                            .of(context)
                            .size
                            .height * 0.08,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey.withOpacity(0.8),
                        ),
                      )),
                ),
                Padding(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width/2, top: 10,left: 15, bottom: 15),
                  child: Text(
                    "La postazione è prenotata" , style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: blackLight

                  ),
                  ),

                ),
                Padding(
                  padding:  EdgeInsets.symmetric(vertical:10, horizontal: heightSize*0.065),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today,color:Color(0xFFAFAFB0) , size: heightSize*0.03,),
                      SizedBox(width: 8,),
                      Column(
                          children: [
                            widget.recurrentReservation!=true?

                            Text("${giorniSettimana[widget.date.weekday-1]} ${widget.date.day.toString()}",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: heightSize*0.008*multiplierSubtitle2)):
                            Text("Da ${giorniSettimana[snapshot.data![0].weekDay-1]} ${snapshot.data![0].day.toString()} a ${giorniSettimana[snapshot.data![1].weekDay-1]} ${snapshot.data![1].day.toString()}"
                              ,style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: heightSize*0.008*multiplierSubtitle2,



                              ),)
                            ,

                            Text("Giorno",style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: heightSize*0.009*multiplierParagraph2)),
                          ]),
                      Spacer(),
                      Icon(Icons.person_outline,color:Color(0xFFAFAFB0)),
                      SizedBox(width: 8,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("P${this.selectedItem}", style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: heightSize*0.008*multiplierSubtitle
                          ),),
                          Text("Postazione", style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: heightSize*0.009*multiplierParagraph2


                          ),
                          )

                        ],
                      )

                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 15,vertical: 18),
                  child: Text("Orario di utilizzo", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: heightSize*multiplierSubtitle2*0.01
                  ),),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 0, horizontal: 015),
                  child: Text("h 8:00 - h 20:00" , style: TextStyle(fontWeight: FontWeight.bold),),


                ),
                Padding(
                  padding: EdgeInsets.only(left: 14,right: 14, top: heightSize*0.06),

                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.bottom,
                    showCursor: false,


                    style: TextStyle(
                      color: Color(0xFF757575).withOpacity(0.8),
                      fontWeight: FontWeight.w400,
                      fontSize: multiplierParagraph*heightSize*0.012,


                    ),

                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      alignLabelWithHint: false,
                      labelText: "Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              width: 2,
                              style: BorderStyle.solid,
                            color: Color(0xFF757575).withOpacity(0.88)
                          )
                      ),

                      labelStyle: TextStyle(
                          fontSize:multiplierParagraph*heightSize*0.013,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF757575).withOpacity(0.8)
                      ),


                      filled: true,
                      fillColor: Colors.white,


                      contentPadding: EdgeInsets.only(top: heightSize*0.033, left: 19, bottom: heightSize*0.025),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 14,right: 14, top: heightSize*0.02),

                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.bottom,
                    showCursor: false,

                    style: TextStyle(
                      color: Color(0xFF757575).withOpacity(0.8),
                      fontWeight: FontWeight.w400,
                      fontSize: multiplierParagraph*heightSize*0.012,

                    ),

                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      alignLabelWithHint: false,
                      labelText: "Cognome",
                      labelStyle: TextStyle(
                          fontSize:multiplierParagraph*heightSize*0.013,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF757575).withOpacity(0.8)
                      ),

                      filled: true,
                      fillColor: Colors.white,
                      border:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              width: 2,
                              style: BorderStyle.solid,
                              color: Color(0xFF757575).withOpacity(0.88)
                          )
                      ),
                      contentPadding: EdgeInsets.only(top: heightSize*0.033, left: 19, bottom: heightSize*0.025),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 14,right: 14, top: heightSize*0.02),

                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.bottom,
                    showCursor: false,

                    style: TextStyle(
                      color: Color(0xFF757575).withOpacity(0.8),
                      fontWeight: FontWeight.w400,
                      fontSize: multiplierParagraph*heightSize*0.012,

                    ),

                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      alignLabelWithHint: false,
                      labelText: "Email",
                      labelStyle: TextStyle(
                          fontSize:multiplierParagraph*heightSize*0.013,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF757575).withOpacity(0.8)
                      ),

                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              width: 2,
                              style: BorderStyle.solid,
                              color: Color(0xFF757575).withOpacity(0.88)
                          )
                      ),
                      contentPadding: EdgeInsets.only(top: heightSize*0.033, left: 19, bottom: heightSize*0.025) ,
                    ),
                  ),
                ),
                Expanded(

                  child: Padding(
                    padding:  EdgeInsets.only( left: 15, right: 15, bottom: 10, top: MediaQuery.of(context).size.height*0.03),
                    child: GestureDetector(

                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ReservationPage( date: this.selectedDate!,ufficio: widget.ufficio,recurrentReservation: false,)));

                      },
                      child: Container(
                        width: double.infinity,
                        height: heightSize*0.04,
                        decoration: BoxDecoration(
                            color: purpleFluo,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color:purpleFluo,
                                  offset: Offset(0, 3),

                                  blurRadius: 10
                              )
                            ]
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("RICHIEDI DISPONIBILITA'", style:  TextStyle(
                            fontFamily: "Poppins",
                            fontSize: multiplierSubtitle*heightSize*0.01, fontWeight: FontWeight.w700,color:  Colors.white,
                          ),),
                        ),
                      ),
                    ),
                  ),
                )






              ],);
          }
      ),
    );

  }*/
}
