
import 'package:bookingmobile2/Repos/data_repo.dart';
import 'package:bookingmobile2/Utils/exceptions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../Bloc/calendar_Bloc.dart';
import '../Bloc/prenotazione_flow_bloc.dart';
import '../Bloc/profile_bloc.dart';
import '../Models/Calendar.dart';
import '../Models/Prenotazione.dart';
import '../Models/Sala.dart';
import '../Utils/componenti_riutilizzabili.dart';
import '../Utils/constants.dart';
import '../Utils/functions.dart';





class PrenotazioneSheet extends StatefulWidget {
  PrenotazioneState state;
  bool isForSala = false;
   PrenotazioneSheet({required this.state, required this.isForSala});



  @override
  State<PrenotazioneSheet> createState() => _PrenotazioneSheetState();
}

class _PrenotazioneSheetState extends State<PrenotazioneSheet> {
  SfRangeValues _rangeValues = SfRangeValues(9, 18);
  SfRangeValues get rangeValues => _rangeValues;

  set rangeValues(SfRangeValues value) {
    _rangeValues = value;
  }

  @override
  void initState() {
    // TODO: implement initState
    this.controllerName.text =context.read<ProfileBloc>().state.name!;
    controllerSurname.text = context.read<ProfileBloc>().state.surname!;
    controllerMail.text = context.read<ProfileBloc>().state.mail!;
    widget.state.prenotazione!.picture = context.read<ProfileBloc>().state.avatarPath!;
  }

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  late RangeValues range;
  CalendarBloc _calendarBloc = CalendarBloc();

  SfRangeValues sfRangeValues = new SfRangeValues(9, 18);
  final controllerName = TextEditingController();
  final controllerSurname = TextEditingController();
  final controllerMail = TextEditingController();
  void updateRange(SfRangeValues rangeValues){
    setState(() {
      this.sfRangeValues = rangeValues;
    });
  }
  SfRangeValues GetSfRangeValues(){
    return this.sfRangeValues;
  }


  @override
  Widget build(BuildContext context) {

    double heightSize = MediaQuery.of(context).size.height;
    var selectedRange = RangeValues(9, 18);

    return BlocListener<BookBloc, PrenotazioneState>(
      listener: (context, state){

        if(state is PrenotazioneFinished){

          if(widget.isForSala)  Navigator.pushNamed(context, "/confirmation_sala");
          else Navigator.pushNamed(context, "/confirmation");

          print("Prenotazione effettuata");
        } else if (state is PrenotazioneFailed){


          Functions.showErrorDialog(context, state.errore);
        }

      },
      child: Container(
              height: MediaQuery
                  .of(context).viewInsets.bottom==0 ? MediaQuery.of(context).size.height *0.82 : MediaQuery
                  .of(context)
                  .size
                  .height *0.98,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18))),
              child: StreamBuilder<List<Calendar>>(
                  stream: _calendarBloc.calendarListStream,
                  initialData: _calendarBloc.calendarList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData==true || snapshot.data!=null){
                      return Stack(
                        children: [
                          Column(
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
                            Padding(padding: EdgeInsets.only(right: MediaQuery
                                .of(context)
                                .size
                                .width / 2.3, top: 10, left: 15, bottom: heightSize*0.02),
                              child: Text(
                                "La tua prenotazione", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: multiplierBigTitle*heightSize*0.01,
                                  color: blackLight

                              ),
                              ),

                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: widget.state.isMoreDays== true?heightSize * 0.04: heightSize * 0.065),
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_today, color: Color(0xFFAFAFB0),
                                    size: heightSize * 0.03,),
                                  SizedBox(width: 8,),
                                  Column(
                                      children: [



                                        widget.state.isMoreDays == true ?
                                        Text("Da ${giorniSettimana[snapshot.data![0]
                                            .weekDay - 1]} ${snapshot.data![0].day
                                            .toString()} a ${giorniSettimana[snapshot
                                            .data![1].weekDay - 1]} ${snapshot
                                            .data![1].day.toString()}"
                                          , style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: heightSize * 0.008 *
                                                multiplierSubtitle2,


                                          ),):
                                        Text("${giorniSettimana[widget.state.prenotazione!.date!
                                            .weekday - 1]} ${widget.state.prenotazione!.date!.day
                                            .toString()}", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: heightSize * 0.01 *
                                                multiplierSubtitle2))

                                        ,

                                        Text("Giorno", style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: heightSize * 0.009 *
                                                multiplierParagraph2)),
                                      ]),
                                  Spacer(),
                                  Icon(
                                      Icons.person_outline, color: Color(0xFFAFAFB0)),
                                  SizedBox(width: 8,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Builder(
                                        builder: (context) {
                                         if(!widget.isForSala)
                                          return Text(

                                          "${widget.state.prenotazione!.postazione?.postazione}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: heightSize * 0.01 *
                                                    multiplierSubtitle
                                            ),);

                                         return FutureBuilder<Sala?>(
                                           future: context.read<DataRepository>().getSalaById(widget.state.prenotazione!.salaID!),
                                           builder: (context, sala) {
                                            if(sala.hasData)
                                             return Text(

                                               "${sala.data!.name}",
                                               style: TextStyle(
                                                   fontWeight: FontWeight.bold,
                                                   fontSize: heightSize * 0.01 *
                                                       multiplierSubtitle
                                               ),);
                                            return Loading();
                                           }
                                         );
                                        }
                                      ),
                                      Text(widget.isForSala?"Sala":"Postazione", style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: heightSize * 0.009 *
                                              multiplierParagraph2


                                      ),
                                      )

                                    ],
                                  )

                                ],
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(
                                left: 15,right: 15, top: heightSize*0.01, bottom: 10),
                              child: Text("Orario di utilizzo", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: heightSize * multiplierSubtitle2 * 0.01
                              ),),
                            ),
                            Padding(padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 0),
                              child: Center(
                                  child: Container(
                                      height: 10,
                                      child: CustomSlider(pre: widget.state, )
                                  )

                              ),


                            ),


                            Padding(
                              padding: EdgeInsets.only(
                                  left: 14, right: 14, top: heightSize * 0.06,  ),

                              child: TextFormField(
                                textAlignVertical: TextAlignVertical.bottom,
                                showCursor: false,
                                controller: controllerName,


                                style: TextStyle(
                                  color: Color(0xFF757575).withOpacity(0.8),
                                  fontWeight: FontWeight.w400,
                                  fontSize: multiplierParagraph * heightSize * 0.012,

                                ),

                                decoration: InputDecoration(
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  alignLabelWithHint: false,
                                  labelText: "Name",
                                  labelStyle: TextStyle(
                                      fontSize: multiplierParagraph * heightSize *
                                          0.013,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF757575).withOpacity(0.8)
                                  ),

                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none
                                      )
                                  ),
                                  contentPadding: EdgeInsets.only(
                                      top: heightSize * 0.033,
                                      left: 19,
                                      bottom: heightSize * 0.025),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 14, right: 14, top: heightSize * 0.02, ),

                              child: TextFormField(
                                textAlignVertical: TextAlignVertical.bottom,
                                showCursor: false,
                                controller: controllerSurname ,

                                style: TextStyle(
                                  color: Color(0xFF757575).withOpacity(0.8),
                                  fontWeight: FontWeight.w400,
                                  fontSize: multiplierParagraph * heightSize * 0.012,

                                ),

                                decoration: InputDecoration(
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  alignLabelWithHint: false,
                                  labelText: "Cognome",
                                  labelStyle: TextStyle(
                                      fontSize: multiplierParagraph * heightSize *
                                          0.013,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF757575).withOpacity(0.8)
                                  ),

                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none
                                      )
                                  ),
                                  contentPadding: EdgeInsets.only(
                                      top: heightSize * 0.033,
                                      left: 19,
                                      bottom: heightSize * 0.025),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 14, right: 14, top: heightSize * 0.02,),

                              child: TextFormField(
                                textAlignVertical: TextAlignVertical.bottom,
                                showCursor: false,
                                controller: controllerMail,
                                readOnly: true,

                                style: TextStyle(
                                  color: Color(0xFF757575).withOpacity(0.8),
                                  fontWeight: FontWeight.w400,
                                  fontSize: multiplierParagraph * heightSize * 0.012,

                                ),

                                decoration: InputDecoration(
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  alignLabelWithHint: false,
                                  labelText: "Email",
                                  labelStyle: TextStyle(
                                      fontSize: multiplierParagraph * heightSize *
                                          0.013,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF757575).withOpacity(0.8)
                                  ),

                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none
                                      )
                                  ),
                                  contentPadding: EdgeInsets.only(
                                      top: heightSize * 0.033,
                                      left: 19,
                                      bottom: heightSize * 0.025),
                                ),
                              ),
                            ),








                          ],),
                           Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: heightSize*0.02, right: heightSize*0.02, bottom: heightSize>700? heightSize*0.03:10, top:  heightSize>700? heightSize*0.08:heightSize*0.05),
                              child: GestureDetector(
                                onTap: () {
                                  PrenotazioneState pre = widget.state;

                                  pre.prenotazione!.name = controllerName.text;
                                  pre.prenotazione!.surname = controllerSurname.text;
                                  pre.prenotazione!.mail = controllerMail.text;



                                  try {
                                    _checkPrenotazione(pre.prenotazione);

                                    if (widget.isForSala) {
                                      BlocProvider.of<BookBloc>(context).add(
                                          PrenotazioneSalaToSubmit(pre));
                                    } else {
                                      BlocProvider.of<BookBloc>(context).add(
                                          PrenotazioneToSubmit(pre));
                                    }
                                  }catch(e) {
                                    if(e is PrenotazioneNotValid)
                                      Functions.showErrorDialog(context, e.message?? "Impossibile effettuare la prenotazione");

                                    else
                                      Functions.showErrorDialog(context,  "Impossibile effettuare la prenotazione");

                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: heightSize*0.09,

                                  decoration: BoxDecoration(
                                      color: purpleFluo,
                                      borderRadius: BorderRadius.circular(20),
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
                                      "CONFERMA LA PRENOTAZIONE", style: TextStyle(
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
                          )




                    ]
                      );

                    } else return Loading();
                  }
              ),
            )

      );







  }


  bool _checkStartandEndTime(int? startTime, int? endTime){

    if(startTime == null || endTime == null ) return false;

if(startTime< Constant.INITIAL_WORKING_HOUR || endTime>Constant.END_WORKING_HOUR) return false;

if(endTime< startTime) return false;

return true;

  }

  void _checkPrenotazione(Prenotazione? pre){
    if(pre == null) throw PrenotazioneNotValid(message: "Prenotazione non valida");
    bool isTimeValid = _checkStartandEndTime(pre.startTime, pre.endTime);
    if(isTimeValid== false) throw PrenotazioneNotValid(message: "Orario di inizio o fine non validi");

    if(pre.name== null || pre.date== null || pre.name == null || pre.surname == null || pre.mail== null    || pre.officeID == null) throw PrenotazioneNotValid(message:"Impossibile inviare");
    if(pre.name!.isEmpty || pre.mail!.isEmpty || pre.surname!.isEmpty)  throw PrenotazioneNotValid(message:"Credenziali di prenotazioni non valide");
  }
  



}
