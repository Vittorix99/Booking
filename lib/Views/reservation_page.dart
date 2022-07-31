import 'package:bookingmobile2/Bloc/calendar_Bloc.dart';

import 'package:bookingmobile2/Bloc/profile_bloc.dart';
import 'package:bookingmobile2/BottomSheets/calendar_sheet.dart';
import 'package:bookingmobile2/Models/ModelProvider.dart';

import 'package:bookingmobile2/Models/Prenotazione.dart';
import 'package:bookingmobile2/Repos/prenotazioni_repo.dart';
import 'package:bookingmobile2/Repos/data_repo.dart';

import 'package:bookingmobile2/Utils/componenti_riutilizzabili.dart';
import 'package:bookingmobile2/Utils/constants.dart';
import 'package:bookingmobile2/Utils/functions.dart';
import 'package:bookingmobile2/Utils/image_caching.dart';
import 'package:bookingmobile2/Views/calendar_page.dart';
import 'package:bookingmobile2/Views/select_office_page.dart';
import 'package:bookingmobile2/Views/select_workstation_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



import '../Bloc/prenotazione_flow_bloc.dart';
import '../BottomSheets/prenotazione_sheet.dart';
import '../Models/Calendar.dart';


class ReservationPage extends StatefulWidget {
  Office office;
  ReservationPage(this.office);

  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {

   bool starSelected = false;
  List isSelectedDate = List<bool>.filled(8, false, growable: false);
  List isDayFull = List<bool>.filled(8, false, growable: false);
  bool prenotazioneRicorrente = false;
  final CalendarBloc _calendarBloc = CalendarBloc();
  DateTime? selectedDate;
List<DateTime> days = [];

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    days = Functions.getCurrentWeek();



    /*Future.delayed(Duration.zero,() async {
      isDayFull = await days.map((e) => context.read<PrenotazioniRepo>().isDayFull(e, widget.office)).toList();
      //here is the async code, you can execute any async code here

    });*/



    DateTime date = DateTime.now();
    isSelectedDate[date.weekday-1] = true;
    selectedDate=date;



    ProfileState profileState = context.read<ProfileBloc>().state;
    List<String> favorites = profileState.preferiti!.map((e) => e.id).toList() ;
    if(favorites.contains(widget.office.id)){
       starSelected= true;
      }else{
       starSelected = false;
         }

  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    final bookBloc = BlocProvider.of<BookBloc>(context);
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double heightSize = MediaQuery.of(context).size.height;
    double widthSize = MediaQuery.of(context).size.width;




    return Scaffold(
      backgroundColor: Color(0xFF151C3D),
      body: FutureBuilder<List<bool>?>(
        future: context.read<PrenotazioniRepo>().fetchFullDays(this.days, widget.office),
        builder: (context, giorni) {
    if(giorni.hasData){
    this.isDayFull = giorni.data!;
    return BlocBuilder<BookBloc, PrenotazioneState>(
    builder: (context, state) {

    if(state.prenotazione!.officeID != null) {
    var name = widget.office.name ;
    var address = widget.office.indirizzo ;
    var immagine = ImageUrlCache.instance.getUrl(
    widget.office.immagine);

    return Column(
    children: [
    Column(
    children: [
    TopBar(color: Colors.white, function: () {
    Navigator.of(context).pop();
    BlocProvider.of<BookBloc>(context).add(PrenotazioneStart());
    }),
    Row(
    children: [
    Padding(
    padding: EdgeInsets.only(left: 22, top: heightSize * 0.001),
    child: Text("Scegli il giorno",
    style: TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: multiplierBigTitle * unitHeightValue,
    color: Colors.white)),
    ),
    Spacer(),
    GestureDetector(
    onTap: () {
    showModalBottomSheet(
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
    topRight: Radius.circular(40),
    topLeft: Radius.circular(40)),
    ),
    isScrollControlled: true,
    context: context,
    builder: (context) {
    return CalendarSheet(state, widget.office);
    });
    },
    child: Padding(
    padding: EdgeInsets.only(right: 10.0),
    child: Icon(
    Icons.calendar_month,
    color: Colors.white,
    size: 25,
    ),
    ),
    ),
    ],
    ),
    ],
    ),
    getDaysofTheWeek(context),
    Flexible(
    child: Container(
    width: double.infinity,
    decoration: BoxDecoration(
    color: Color(0xFFF7F9FB),
    borderRadius: BorderRadius.only(
    topRight: Radius.circular(30),
    topLeft: Radius.circular(30)),
    ),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Padding(
    padding: EdgeInsets.fromLTRB(
    heightSize * 0.019,
    heightSize * 0.013,
    heightSize * 0.019,
    heightSize * 0.007),
    child: Container(
    height: MediaQuery
        .of(context)
        .size
        .height * 0.32,
    width: MediaQuery
        .of(context)
        .size
        .width,
    child: FutureBuilder<String?>(
    future: immagine,
    builder: (context, snapshot) {
    if (snapshot.hasData) {
    try {
    return Hero(
    tag: widget.office.name,
    child: ClipRRect(
    borderRadius: BorderRadius.circular(
    30),
    child: CachedNetworkImage(
    imageUrl: snapshot.data!,
      errorWidget: (context, url, error)=>Icon(Icons.home_work_outlined,size: 30, color: blackLight,),
    fit: BoxFit.cover,)
    ),
    );
    } catch (e) {
    return ClipRRect(
    borderRadius: BorderRadius.circular(30),
    child: Container(
    color: Colors.white,

    ));
    }
    } else
    return Loading();
    }
    )
    ),
    ),
    Row(children: [
    Padding(
    padding:
    EdgeInsets.only(left: 18, right: 18, top: 8),
    child: Text(
    name,
    style: TextStyle(
    fontWeight: FontWeight.w700,
    fontSize:
    multiplierBigTitle * unitHeightValue,
    color: Color(0xFF1E1E1E)),
    ),
    ),
    Spacer(),
    _favouriteStar(widget.office),
    ]),
    Padding(
    padding: EdgeInsets.only(
    left: 18, right: 18, bottom: widthSize * 0.002),
    child: Text(
    address,
    style: TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: multiplierSubtitle * unitHeightValue,
    color: Color(0xFF1E1E1E)),
    ),
    ),
    Padding(
    padding: EdgeInsets.symmetric(
    horizontal: 18, vertical: widthSize * 0.02),
    child: Text(
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ipsum nunc, laoreet vel.",
    style: TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: multiplierParagraph * unitHeightValue,
    color: Color(0xFF1E1E1E)),
    ),
    ),
    Padding(
    padding:
    EdgeInsets.symmetric(horizontal: 17, vertical: 0),
    child: Row(
    children: [
    WhiteRoundedBox(
    text:
    "${widget.office.capienza
        .toString()} postazioni",
    icon: Icons.person_outline),
    SizedBox(
    width: 8,
    ),
    WhiteRoundedBox(
    text: " con schermo", icon: Icons.tv),
    ],
    ),
    ),
    Padding(
    padding:
    EdgeInsets.symmetric(horizontal: 17, vertical: 2),
    child: Row(
    children: [
    WhiteRoundedBox(
    text: "3 meeting room",
    icon: Icons.meeting_room),
    SizedBox(
    width: 8,
    ),
    WhiteRoundedBox(
    text: "Aria Condizionata",
    icon: Icons.ac_unit),
    ],
    ),
    ),
    Expanded(
    child: Padding(
    padding:
    EdgeInsets.only(left: 15, right: 15, bottom: heightSize*0.02),
    child: Align(
    alignment: FractionalOffset.bottomCenter,
    child: GestureDetector(
    onTap: () {


    if(!isDayFull[selectedDate!.weekday-1]) {
    PrenotazioneState pre = state;
    pre.prenotazione!.date = selectedDate;
    pre.isMoreDays = false;
    context.read<BookBloc>().add(
    PrenotazioneBuilding(pre));


    Navigator.of(context, rootNavigator: true)
        .pushNamed(
    "/workstation", arguments: {'office':widget.office});
    }
    },
    child: Container(
    width: double.infinity,
    height: heightSize * 0.079,
    decoration: BoxDecoration(
    color: isDayFull[selectedDate!.weekday-1] ? backGround2: Color(0xFF8645FF),
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
    BoxShadow(
    color:isDayFull[selectedDate!.weekday-1]? Colors.grey: Color(0x808645FF),
    offset: Offset(0, 3),
    blurRadius: isDayFull[selectedDate!.weekday-1]? 0: 15)
    ]),
    child: Align(
    alignment: Alignment.center,
    child: Text(
    isDayFull[selectedDate!.weekday-1]? "RICHIEDI DISPONIBILITA'":"SCEGLI LA POSTAZIONE",
    style: TextStyle(
    fontFamily: "Poppins",
    fontSize: multiplierSubtitle *
    unitHeightValue,
    fontWeight: FontWeight.w700,
    color:isDayFull[selectedDate!.weekday-1]?blackLight.withOpacity(0.78): Colors.white,
    shadows: [
    if(!isDayFull[selectedDate!.weekday-1])...[
    Shadow(
    color: Color(0x808645FF),
    blurRadius: 10,
    )]
    ]),
    ),
    ),
    ),
    ),
    ),
    ),
    )
    ])))
    ],
    );
    } else{
    return Center(child: Loading(),);
    }

    });
    }
    else{
      return Center(child: Loading(),);
    }
        }
      ),
    );
  }



  Widget getDaysofTheWeek(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double heightSize = MediaQuery.of(context).size.height;
    double widthSize = MediaQuery.of(context).size.width;




    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: heightSize * 0.010, horizontal: heightSize * 0.001),
      child: Container(
        height: heightSize * 0.095,
        child: Builder(
          builder: (context) {
            return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (BuildContext context, int index) {





                  return FutureBuilder<bool>(
                    future:  context.read<PrenotazioniRepo>().isDayFull(days[index], widget.office),
                    builder: (context, isFull) {


                      if(isFull.hasData) {
                        this.isDayFull[index]= isFull.data!;
                        return GestureDetector(

                          onTap: () {
                            setState(() {
                              if(index!=6) {
                                selectedDate = days[index];
                                for (var i = 0; i < 7; i++) {
                                  isSelectedDate[i] = false;
                                }
                                isSelectedDate[index] = true;
                              }
                            });

                          },
                          child: Container(
                            width: heightSize * 0.084,
                            height: heightSize * 0.16,
                            decoration: BoxDecoration(
                                color: isSelectedDate[index] == true
                                    ? Color(0xFF8645FF)
                                    : Color(0xFF151C3D),
                                borderRadius: BorderRadius.circular(13),
                                boxShadow: [
                                  if (isSelectedDate[index]) ...[
                                    BoxShadow(
                                        color: Color(0x808645FF),
                                        offset: Offset(0, 3),
                                        blurRadius: 18)
                                  ]
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 3,
                                      vertical: heightSize * 0.0047),
                                  child: Text(
                                    stringDays[days[index].weekday]!,
                                    style: TextStyle(
                                        fontSize: unitHeightValue *
                                            multiplierSubtitle,
                                        fontWeight: isSelectedDate[index] ==
                                            true
                                            ? FontWeight.w700
                                            : FontWeight.w300,
                                        color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 3,
                                      vertical: heightSize * 0.0044),
                                  child: Text(
                                    days[index].day.toString(),
                                    style: TextStyle(
                                        fontSize: isSelectedDate[index] == true
                                            ? multiplierSubtitle2 *
                                            unitHeightValue
                                            : multiplierSubtitle2 *
                                            unitHeightValue,
                                        fontWeight: isSelectedDate[index] ==
                                            true
                                            ? FontWeight.w700
                                            : FontWeight.w300,
                                        color: Colors.white),
                                  ),


                                ),
                                Container(
                                  height: isFull.data! ? 4 : 0,
                                  width: 4,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,


                                  ),


                                )
                              ],
                            ),
                          ),
                        );
                      }
                      else return Loading();
                    }
                  );



                });
          }
        ),
      ),
    );
  }



  Widget _favouriteStar(Office office) {

    return Padding(
      padding: EdgeInsets.only(right: 15),
      child: GestureDetector(
        onTap: () {
          setState(() {


           if(!starSelected==true) {
             BlocProvider.of<ProfileBloc>(context).add(AddPreferito(office));
             starSelected = !starSelected;
           }
           else if(!starSelected==false){
             BlocProvider.of<ProfileBloc>(context).add(EliminaPreferito(office));
             starSelected = !starSelected;
           }

          });
        },
        child: Icon(starSelected == false ? (Icons.star_border) : (Icons.star),
            color: starSelected == false ? Colors.grey : Color(0xFFFFB61D),
            size: MediaQuery.of(context).size.height * 0.04),
      ),
    );
  }
}


class ReservationSalaPage extends StatefulWidget {
  Sala sala;
  Office office;
  ReservationSalaPage(this.sala, this.office);

  @override
  _ReservationSalaPageState createState() => _ReservationSalaPageState();
}

class _ReservationSalaPageState extends State<ReservationSalaPage> {

  bool starSelected = false;
  List isSelectedDate = List<bool>.filled(8, false, growable: false);
 List<bool> isDayFull = List<bool>.filled(8, false, growable: false);
  bool prenotazioneRicorrente = false;
  final CalendarBloc _calendarBloc = CalendarBloc();
  DateTime? selectedDate;
  List<DateTime> days = [];

  @override
  void initState()  {
    // TODO: implement initState
    days = Functions.getCurrentWeek();



    DateTime date = DateTime.now();
    isSelectedDate[date.weekday-1] = true;
    selectedDate=date;


    ProfileState profileState = context.read<ProfileBloc>().state;
    List<String> favorites = profileState.preferiti!.map((e) => e.id).toList() ;
    if(favorites.contains(widget.sala.id)){
      starSelected= true;
    }else{
      starSelected = false;
    }

  }

  @override
  Widget build(BuildContext context) {
    final bookBloc = BlocProvider.of<BookBloc>(context);
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double heightSize = MediaQuery.of(context).size.height;
    double widthSize = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFF151C3D),
      body: FutureBuilder<List<bool>?>(
        future: context.read<PrenotazioniRepo>().fetchSalaFullDays(days, widget.sala),

        builder: (context, giorni) {
          if(giorni.hasData) {
            this.isDayFull = giorni.data!;
            return BlocBuilder<BookBloc, PrenotazioneState>(
                builder: (context, state) {
                  if (widget.sala.id != null) {
                    var name = widget.sala.name;

                    var immagine = ImageUrlCache.instance.getUrl(
                        widget.sala.immagine);

                    return Column(
                      children: [
                        Column(
                          children: [
                            TopBar(color: Colors.white, function: () {
                              Navigator.of(context).pop();
                            }),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 22, top: heightSize * 0.001),
                                  child: Text("Scegli il giorno",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: multiplierBigTitle *
                                              unitHeightValue,
                                          color: Colors.white)),
                                ),


                              ],
                            ),
                          ],
                        ),
                        getDaysofTheWeek(context),
                        Flexible(
                            child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF7F9FB),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      topLeft: Radius.circular(30)),
                                ),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            heightSize * 0.019,
                                            heightSize * 0.013,
                                            heightSize * 0.019,
                                            heightSize * 0.007),
                                        child: Container(
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.32,
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width,
                                            child: FutureBuilder<String?>(
                                                future: immagine,
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    try {
                                                      return Hero(
                                                        tag: widget.sala.name!,
                                                        child: ClipRRect(
                                                            borderRadius: BorderRadius
                                                                .circular(
                                                                30),
                                                            child: CachedNetworkImage(
                                                              imageUrl: snapshot
                                                                  .data!,
                                                              errorWidget: (context, url, error)=>Icon(Icons.home_work_outlined,size: 30, color: blackLight,),
                                                              fit: BoxFit
                                                                  .cover,)
                                                        ),
                                                      );
                                                    } catch (e) {
                                                      return ClipRRect(
                                                          borderRadius: BorderRadius
                                                              .circular(30),
                                                          child: Container(
                                                            color: Colors.white,

                                                          ));
                                                    }
                                                  } else
                                                    return Loading();
                                                }
                                            )
                                        ),
                                      ),
                                      Row(children: [
                                        Padding(
                                          padding:
                                          EdgeInsets.only(
                                              left: 18, right: 18, top: 8),
                                          child: Text(
                                            name!,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize:
                                                multiplierBigTitle *
                                                    unitHeightValue,
                                                color: Color(0xFF1E1E1E)),
                                          ),
                                        ),
                                        Spacer(),
                                        // _favouriteStar(widget.s),
                                      ]),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 18,
                                            right: 18,
                                            bottom: widthSize * 0.002),
                                        child: Text(
                                          widget.office.indirizzo,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: multiplierSubtitle *
                                                  unitHeightValue,
                                              color: Color(0xFF1E1E1E)),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 18,
                                            vertical: widthSize * 0.02),
                                        child: Text(
                                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ipsum nunc, laoreet vel.",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: multiplierParagraph *
                                                  unitHeightValue,
                                              color: Color(0xFF1E1E1E)),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        EdgeInsets.symmetric(
                                            horizontal: 17, vertical: 0),
                                        child: Row(
                                          children: [
                                            WhiteRoundedBox(
                                                text:
                                                "${widget.sala.capienza
                                                    .toString()} postazioni",
                                                icon: Icons.person_outline),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            WhiteRoundedBox(
                                                text: "Piano n ${widget.sala
                                                    .piano}",
                                                icon: Icons.stairs_outlined),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        EdgeInsets.symmetric(
                                            horizontal: 17, vertical: 2),
                                        child: Row(
                                          children: [
                                            WhiteRoundedBox(
                                                text: "3 meeting room",
                                                icon: Icons.meeting_room),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            WhiteRoundedBox(
                                                text: "Aria Condizionata",
                                                icon: Icons.ac_unit),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                          EdgeInsets.only(left: 15,
                                              right: 15,
                                              bottom: heightSize * 0.02),
                                          child: Align(
                                            alignment: FractionalOffset
                                                .bottomCenter,
                                            child: GestureDetector(
                                              onTap: () {
                                                if (!isDayFull[selectedDate!
                                                    .weekday - 1]) {
                                                  PrenotazioneState pre = state;
                                                  pre.prenotazione!.date =
                                                      selectedDate;
                                                  pre.isMoreDays = false;
                                                  context.read<BookBloc>().add(
                                                      PrenotazioneBuilding(
                                                          pre));


                                                  showModalBottomSheet(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius
                                                            .only(
                                                            topRight: Radius
                                                                .circular(
                                                                40),
                                                            topLeft: Radius
                                                                .circular(
                                                                40)),
                                                      ),

                                                      isScrollControlled: true,
                                                      context: context,
                                                      builder: (context) {
                                                        return PrenotazioneSheet(
                                                            state: pre,
                                                            isForSala: true);
                                                      });
                                                }
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                height: heightSize * 0.079,
                                                decoration: BoxDecoration(
                                                    color: isDayFull[selectedDate!
                                                        .weekday - 1]
                                                        ? backGround2
                                                        : Color(0xFF8645FF),
                                                    borderRadius: BorderRadius
                                                        .circular(20),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: isDayFull[selectedDate!
                                                              .weekday - 1]
                                                              ? Colors.grey
                                                              : Color(
                                                              0x808645FF),
                                                          offset: Offset(0, 3),
                                                          blurRadius: isDayFull[selectedDate!
                                                              .weekday - 1]
                                                              ? 0
                                                              : 15)
                                                    ]),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    isDayFull[selectedDate!
                                                        .weekday - 1]
                                                        ? "SALA PIENA"
                                                        : "PRENOTA LA SALA",
                                                    style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontSize: multiplierSubtitle *
                                                            unitHeightValue,
                                                        fontWeight: FontWeight
                                                            .w700,
                                                        color: isDayFull[selectedDate!
                                                            .weekday - 1]
                                                            ? blackLight
                                                            .withOpacity(0.78)
                                                            : Colors.white,
                                                        shadows: [
                                                          if(!isDayFull[selectedDate!
                                                              .weekday - 1])...[
                                                            Shadow(
                                                              color: Color(
                                                                  0x808645FF),
                                                              blurRadius: 10,
                                                            )
                                                          ]
                                                        ]),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ])))
                      ],
                    );
                  } else {
                    return Center(child: Loading(),);
                  }
                });
          }else return Center(child: Loading(),);
        }
      ),
    );
  }



  Widget getDaysofTheWeek(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double heightSize = MediaQuery.of(context).size.height;
    double widthSize = MediaQuery.of(context).size.width;




    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: heightSize * 0.010, horizontal: heightSize * 0.001),
      child: Container(
        height: heightSize * 0.095,
        child: Builder(
            builder: (context) {
              return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 7,
                  itemBuilder: (BuildContext context, int index) {





                    return FutureBuilder<bool>(
                      future: context.read<PrenotazioniRepo>().isSalaDayFull(days[index], widget.sala),
                      builder: (context, isDayFull) {
                        if(isDayFull.hasData && isDayFull.data != null) {
                          this.isDayFull[index] = isDayFull.data!;

                          return GestureDetector(

                            onTap: () {
                              setState(() {
                                if (index != 7) {
                                  selectedDate = days[index];
                                  for (var i = 0; i < 7; i++) {
                                    isSelectedDate[i] = false;
                                  }
                                  isSelectedDate[index] = true;
                                }
                              });
                            },
                            child: Container(
                              width: heightSize * 0.084,
                              height: heightSize * 0.16,
                              decoration: BoxDecoration(
                                  color: isSelectedDate[index] == true
                                      ? Color(0xFF8645FF)
                                      : Color(0xFF151C3D),
                                  borderRadius: BorderRadius.circular(13),
                                  boxShadow: [
                                    if (isSelectedDate[index]) ...[
                                      BoxShadow(
                                          color: Color(0x808645FF),
                                          offset: Offset(0, 3),
                                          blurRadius: 18)
                                    ]
                                  ]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3,
                                        vertical: heightSize * 0.0047),
                                    child: Text(
                                      stringDays[days[index].weekday]!,
                                      style: TextStyle(
                                          fontSize: unitHeightValue *
                                              multiplierSubtitle,
                                          fontWeight: isSelectedDate[index] ==
                                              true
                                              ? FontWeight.w700
                                              : FontWeight.w300,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3,
                                        vertical: heightSize * 0.0044),
                                    child: Text(
                                      days[index].day.toString(),
                                      style: TextStyle(
                                          fontSize: isSelectedDate[index] ==
                                              true
                                              ? multiplierSubtitle2 *
                                              unitHeightValue
                                              : multiplierSubtitle2 *
                                              unitHeightValue,
                                          fontWeight: isSelectedDate[index] ==
                                              true
                                              ? FontWeight.w700
                                              : FontWeight.w300,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    height: isDayFull.data! ? 4 : 0,
                                    width: 4,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red,

                                    ),
                                  )
                                ],
                              ),
                            ),
                          );

                        }else return Loading();
                      }
                    );
                  });
               }
           ),
        ),
      );
    }



  Widget _favouriteStar(Office office) {

    return Padding(
      padding: EdgeInsets.only(right: 15),
      child: GestureDetector(
        onTap: () {
          setState(() {


            if(!starSelected==true) {
              BlocProvider.of<ProfileBloc>(context).add(AddPreferito(office));
              starSelected = !starSelected;
            }
            else if(!starSelected==false){
              BlocProvider.of<ProfileBloc>(context).add(EliminaPreferito(office));
              starSelected = !starSelected;
            }

          });
        },
        child: Icon(starSelected == false ? (Icons.star_border) : (Icons.star),
            color: starSelected == false ? Colors.grey : Color(0xFFFFB61D),
            size: MediaQuery.of(context).size.height * 0.04),
      ),
    );
  }
}