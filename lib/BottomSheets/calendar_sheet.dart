import 'package:bookingmobile2/Bloc/calendar_Bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/prenotazione_flow_bloc.dart';
import '../Models/Calendar.dart';
import '../Models/Office.dart';
import '../Utils/constants.dart';
import '../Views/calendar_page.dart';




class CalendarSheet extends StatefulWidget {
  PrenotazioneState state;
  Office office;


  CalendarSheet(this.state, this.office);

  @override
  State<CalendarSheet> createState() => _CalendarSheetState();
}

class _CalendarSheetState extends State<CalendarSheet> {
  CalendarBloc _calendarBloc = CalendarBloc();
  bool prenotazioneRicorrente = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double heightSize = MediaQuery.of(context).size.height;



    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.82,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
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
          SizedBox(
            height: 10,
          ),
          Flexible(child: CalendarPage()),
          Card(
            elevation: 50,
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.2,
              decoration: BoxDecoration(color: Colors.white),
              child: StreamBuilder<List<Calendar>>(
                  stream: _calendarBloc.calendarListStream,
                  initialData: _calendarBloc.calendarList,
                  builder: (context, snapshot) {
                    return Column(
                      children: [



                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.calendar_today),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: _calendarBloc.flag!= true?
                                Text(
                                    "Da ${giorniSettimana[snapshot.data![0].weekDay-1]} "
                                ):  Text(
                                    "Da ${giorniSettimana[snapshot.data![0].weekDay-1]} a ${giorniSettimana[snapshot.data![1].weekDay-1]} "
                                )

                            ),
                            Spacer(),
                            Text("Ricorrente",),
                            Switch(value: prenotazioneRicorrente, onChanged: (value){
                              setState(() {
                                prenotazioneRicorrente = value;
                              });
                            }),



                          ],
                        ),


                        Expanded(

                          child: Padding(
                            padding:  EdgeInsets.only( left: 15, right: 15, bottom: 10, top: MediaQuery.of(context).size.height*0.045 ),
                            child: GestureDetector(
                              onTap: (){

                                PrenotazioneState pre = widget.state;
                                DateTime date1 = new DateTime(snapshot.data!.first.year,snapshot.data!.first.month, snapshot.data!.first.day, );
                                DateTime date2 = new DateTime(snapshot.data!.last.year, snapshot.data!.last.month, snapshot.data!.last.day, );
                                int res= date2.difference(date1).inDays;
                                pre.isMoreDays = true;
                                pre.days = res;
                                pre.prenotazione!.date = date1;

                                BlocProvider.of<BookBloc>(context).add(PrenotazioneMoreDaysEvent(pre));
                                Navigator.pushNamed(context, "/workstation", arguments: widget.office);





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

                                          blurRadius: 15
                                      )
                                    ]
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("SELEZIONA LE DATE", style:  TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: multiplierSubtitle*heightSize*0.01, fontWeight: FontWeight.w700,color:  Colors.white,
                                  ),),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }
              ),
            ),
          )
        ],
      ),
    );





  }
}
