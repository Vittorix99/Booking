
import 'package:bookingmobile2/Bloc/calendar_Bloc.dart';
import 'package:bookingmobile2/Models/Prenotazione.dart';
import 'package:bookingmobile2/Utils/componenti_riutilizzabili.dart';
import 'package:bookingmobile2/Views/reservation_page.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/prenotazione_flow_bloc.dart';
import '../Models/Calendar.dart';

import '../Models/Office.dart';
import '../Models/Sala.dart';
import '../Repos/data_repo.dart';
import '../Utils/constants.dart';


class ConfirmReservationPage extends StatefulWidget {


  @override
  _ConfirmReservationPageState createState() => _ConfirmReservationPageState();
}

class _ConfirmReservationPageState extends State<ConfirmReservationPage> {
CalendarBloc _calendarBloc = CalendarBloc();
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double heightSize = MediaQuery.of(context).size.height;
    final bookBloc = BlocProvider.of<BookBloc>(context);
    return BlocBuilder<BookBloc, PrenotazioneState>(
      
      builder: (context, state) {
      
        return SafeArea(
          child: Scaffold(
            backgroundColor: Color(0xFFE5E5E5),
            floatingActionButton:  Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Padding(
                padding: EdgeInsets.only(
                    left: heightSize*0.026, right: heightSize*0.02, bottom: 10, top: MediaQuery
                    .of(context)
                    .size
                    .height * 0.043),
                child: GestureDetector(
                  onTap: () {



                   Prenotazione pre = Prenotazione();

                   pre.officeID = state.prenotazione!.officeID;


                   PrenotazioneState newState = PrenotazioneState(
                       prenotazione: pre, isMoreDays: state.isMoreDays);
                   bookBloc.add(PrenotazioneBuilding(newState));

                   Navigator.popUntil(context, ModalRoute.withName(
                       "reservation"),);

                  },
                  child: Container(
                    width: double.infinity,
                    height: heightSize * 0.076,
                    decoration: BoxDecoration(
                        color: purpleFluo,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: purpleFluo,
                              offset: Offset(0, 3),

                              blurRadius: 10
                          )
                        ]
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Prenota altri giorni", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: multiplierSubtitle * heightSize *
                            0.01,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),),
                    ),
                  ),
                ),
              ),
                Padding(
                  padding: EdgeInsets.only(
                      left: heightSize*0.026, right: heightSize*0.02, bottom: 10, top: MediaQuery
                      .of(context)
                      .size
                      .height * 0.01),
                  child: GestureDetector(
                    onTap: () {
                      //  bookBloc.add(PrenotazioneFinishedEvent(Prenotazione()));
                      Navigator.popUntil(context, (route) => route.isFirst);




                    },
                    child: Container(
                      width: double.infinity,
                      height: heightSize * 0.07,
                      decoration: BoxDecoration(
                          color: Color(0xFFE5E5E5),
                          borderRadius: BorderRadius.circular(15),


                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Torna alla home", style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: multiplierSubtitle * heightSize *
                              0.01,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF181059),
                        ),),
                      ),
                    ),
                  ),
                )


              ]
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            body: StreamBuilder<List<Calendar>>(
              initialData: _calendarBloc.calendarList,
              stream: _calendarBloc.calendarListStream,
              builder: (context, snapshot) {
                double paddingleft= 0;




                  return FutureBuilder<Office?>(
                    future: context.read<DataRepository>().getOfficeById(state.prenotazione!.officeID!),
                    builder: (context,office) {
    if(office.hasData) {
    paddingleft =
        office.data!
        .name
        .toString()
        .length > 12 ? heightSize * 0.01 : heightSize * 0.036;

    return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: heightSize *
                                  0.05, horizontal: heightSize * 0.05),
                              child: Image.asset(
                                "assets/images/reservationImage.png",),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: heightSize *
                                  0.05),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(

                                  text: "Hai prenotato ",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: multiplierBigTitle * heightSize *
                                          0.01,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF10ACD5)


                                  ),
                                  children: [
                                    TextSpan(text: "la tua postazione!",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: multiplierBigTitle *
                                                heightSize * 0.01,
                                            fontWeight: FontWeight
                                                .w700,
                                            color: Color(0xFF1E1E1E)

                                        )
                                    ),
                                  ],

                                ),),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: heightSize * 0.05,
                                  bottom: heightSize * 0.05,
                                  left: state.isMoreDays!
                                      ? paddingleft
                                      : heightSize * 0.025,
                                  right: state.isMoreDays!
                                      ? heightSize * 0.02
                                      : heightSize * 0.025),
                              child: Row(
                                children: [
                                  Image.asset("assets/images/orbytaIcon.png"),
                                  SizedBox(width: 6,),
                                  Column(
                                      children: [


                                        Text(office.data!.name
                                           , style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: state.isMoreDays == true
                                                ? heightSize * 0.008 *
                                                multiplierSubtitle2
                                                : heightSize * 0.0086 *
                                                multiplierSubtitle2)),


                                        Text("Ufficio", style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: heightSize * 0.009 *
                                                multiplierParagraph2)),
                                      ]),
                                  Spacer(),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 9.0),
                                    child: Icon(Icons.calendar_today,
                                      color: Color(0xFFAFAFB0),
                                      size: heightSize * 0.03,),
                                  ),
                                  SizedBox(width: 6,),
                                  Column(
                                      children: [

                                        state.isMoreDays == true ?
                                        Text("Da ${giorniSettimana[snapshot.data![0]
                                            .weekDay - 1]} ${snapshot.data![0].day
                                            .toString()} a ${giorniSettimana[snapshot
                                            .data![1].weekDay - 1]} ${snapshot
                                            .data![1].day.toString()}"
                                            , style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: heightSize * 0.007 *
                                                  multiplierSubtitle2,)) :
                                        Text("${giorniSettimana[state.prenotazione!
                                            .date!
                                            .weekday - 1]} ${state.prenotazione!
                                            .date!.day
                                            .toString()}", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: heightSize * 0.0086 *
                                                multiplierSubtitle2)),
                                        Text("Giorno", style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: heightSize * 0.009 *
                                                multiplierParagraph2)),


                                      ]),


                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: heightSize *
                                  0.01, horizontal: heightSize * 0.025),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.person_outline, color: Color(0xFFAFAFB0),
                                    size: heightSize * 0.033,),
                                  SizedBox(width: 6,),
                                  Column(
                                      children: [


                                        Text("${state.prenotazione!.postazione!
                                            .postazione}", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: heightSize * 0.0086 *
                                                multiplierSubtitle2)),


                                        Text("Postazione", style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: heightSize * 0.009 *
                                                multiplierParagraph2)),
                                      ]),
                                  Spacer(),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 9.0),
                                    child: Icon(
                                      Icons.access_time, color: Color(0xFFAFAFB0),
                                      size: heightSize * 0.03,),
                                  ),
                                  SizedBox(width: 6,),
                                  Column(
                                      children: [


                                        Text("h ${state.prenotazione!
                                            .startTime}:00-${state.prenotazione!
                                            .endTime}:00", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: heightSize * 0.0086 *
                                                multiplierSubtitle2)),

                                        Text("Orario", style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: heightSize * 0.009 *
                                                multiplierParagraph2)),
                                      ]),
                                ],
                              ),
                            )
                          ]
                      );
                    }else return Loading();

                }
                  );
              }
            ),
          )
        );
        
       
      }
    );
  }
}



class ConfirmReservationSalaPage extends StatefulWidget {


  @override
  _ConfirmReservationSalaPageState createState() => _ConfirmReservationSalaPageState();
}

class _ConfirmReservationSalaPageState extends State<ConfirmReservationSalaPage> {
  CalendarBloc _calendarBloc = CalendarBloc();
  @override
  Widget build(BuildContext context) {
    double heightSize = MediaQuery.of(context).size.height;
    final bookBloc = BlocProvider.of<BookBloc>(context);
    return BlocBuilder<BookBloc, PrenotazioneState>(

        builder: (context, state) {
         if(state.prenotazione?.date != null){
          return SafeArea(
              child: Scaffold(
                backgroundColor: Color(0xFFE5E5E5),
                floatingActionButton: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Padding(
                      padding: EdgeInsets.only(
                          left: heightSize * 0.026,
                          right: heightSize * 0.02,
                          bottom: 10,
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.043),
                      child: GestureDetector(
                        onTap: () {
                          Prenotazione pre = Prenotazione();
                          //pre.postazione = state.prenotazione!.postazione;
                          pre.officeID = state.prenotazione!.officeID;
                          pre.salaID = state.prenotazione!.salaID;


                          PrenotazioneState newState = PrenotazioneState(
                              prenotazione: pre, isMoreDays: state.isMoreDays);
                          bookBloc.add(PrenotazioneBuilding(newState));


                          Navigator.popUntil(context, ModalRoute.withName(
                              "reservation_sala"),);
                        },
                        child: Container(
                          width: double.infinity,
                          height: heightSize * 0.076,
                          decoration: BoxDecoration(
                              color: purpleFluo,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                    color: purpleFluo,
                                    offset: Offset(0, 3),

                                    blurRadius: 10
                                )
                              ]
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Prenota altri giorni", style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: multiplierSubtitle * heightSize *
                                  0.01,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),),
                          ),
                        ),
                      ),
                    ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: heightSize * 0.026,
                            right: heightSize * 0.02,
                            bottom: 10,
                            top: MediaQuery
                                .of(context)
                                .size
                                .height * 0.01),
                        child: GestureDetector(
                          onTap: () {
                            //  bookBloc.add(PrenotazioneFinishedEvent(Prenotazione()));
                            Navigator.popUntil(context, (route) =>
                            route.isFirst);
                          },
                          child: Container(
                            width: double.infinity,
                            height: heightSize * 0.07,
                            decoration: BoxDecoration(
                              color: Color(0xFFE5E5E5),
                              borderRadius: BorderRadius.circular(15),


                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Torna alla home", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: multiplierSubtitle * heightSize *
                                    0.01,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF181059),
                              ),),
                            ),
                          ),
                        ),
                      )


                    ]
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation
                    .centerDocked,
                body: Builder(

                    builder: (context) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: heightSize * 0.05,
                                  horizontal: heightSize * 0.05),
                              child: Image.asset(
                                "assets/images/reservationImage.png",),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: heightSize * 0.05),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(

                                  text: "Hai prenotato ",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: multiplierBigTitle *
                                          heightSize * 0.01,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF10ACD5)


                                  ),
                                  children: [
                                    TextSpan(text: "la tua postazione!",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: multiplierBigTitle *
                                                heightSize * 0.01,
                                            fontWeight: FontWeight
                                                .w700,
                                            color: Color(0xFF1E1E1E)

                                        )
                                    ),
                                  ],

                                ),),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: heightSize * 0.05,
                                  bottom: heightSize * 0.05,
                                  left: heightSize * 0.025,
                                  right: state.isMoreDays!
                                      ? heightSize * 0.02
                                      : heightSize * 0.025),
                              child: Row(
                                children: [
                                  Image.asset("assets/images/orbytaIcon.png"),
                                  SizedBox(width: 6,),
                                  Column(
                                      children: [


                                        FutureBuilder<Office?>(
                                            future: context.read<
                                                DataRepository>().getOfficeById(
                                                state.prenotazione!.officeID!),
                                            builder: (context, office) {
                                              //  var paddingleft = office.data!.name.toString().length> 12 ? heightSize*0.01 : heightSize *0.036;
                                              if (office.hasData &&
                                                  office.data != null) {
                                                return Text(
                                                    "${office.data!.name}",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        fontSize: heightSize *
                                                            0.0086 *
                                                            multiplierSubtitle2));
                                              } else
                                                return Loading();
                                            }
                                        ),


                                        Text("Ufficio", style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: heightSize * 0.009 *
                                                multiplierParagraph2)),
                                      ]),
                                  Spacer(),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 9.0),
                                    child: Icon(Icons.calendar_today,
                                      color: Color(0xFFAFAFB0),
                                      size: heightSize * 0.03,),
                                  ),
                                  SizedBox(width: 6,),
                                  Column(
                                      children: [


                                        Text("${giorniSettimana[state
                                            .prenotazione!.date!
                                            .weekday - 1]} ${state.prenotazione!
                                            .date!.day
                                            .toString()}", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: heightSize * 0.0086 *
                                                multiplierSubtitle2)),
                                        Text("Giorno", style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: heightSize * 0.009 *
                                                multiplierParagraph2)),


                                      ]),


                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: heightSize * 0.01,
                                  horizontal: heightSize * 0.025),
                              child: Row(
                                children: [
                                  Icon(Icons.person_outline,
                                    color: Color(0xFFAFAFB0),
                                    size: heightSize * 0.033,),
                                  SizedBox(width: 6,),
                                  Column(
                                      children: [


                                        FutureBuilder<Sala?>(
                                            future: context.read<
                                                DataRepository>().getSalaById(
                                                state.prenotazione!.salaID!),
                                            builder: (context, sala) {
                                              if (sala.hasData &&
                                                  sala.data != null)
                                                return Text(
                                                    "${sala.data!.name}",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        fontSize: heightSize *
                                                            0.0086 *
                                                            multiplierSubtitle2));
                                              else
                                                return Loading();
                                            }
                                        ),


                                        Text("Sala", style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: heightSize * 0.009 *
                                                multiplierParagraph2)),
                                      ]),
                                  Spacer(),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 9.0),
                                    child: Icon(Icons.access_time,
                                      color: Color(0xFFAFAFB0),
                                      size: heightSize * 0.03,),
                                  ),
                                  SizedBox(width: 6,),
                                  Column(
                                      children: [


                                        Text("h ${state.prenotazione!
                                            .startTime}:00-${state.prenotazione!
                                            .endTime}:00", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: heightSize * 0.0086 *
                                                multiplierSubtitle2)),

                                        Text("Orario", style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: heightSize * 0.009 *
                                                multiplierParagraph2)),
                                      ]),
                                ],
                              ),
                            )
                          ]
                      );
                    }
                ),
              )
          );}
         else{
           return Loading();
         }



        }
    );
  }
}
