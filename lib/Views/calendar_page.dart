import 'package:bookingmobile2/Bloc/calendar_Bloc.dart';
import 'package:bookingmobile2/Utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Models/Calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {

  int _day = DateTime.now().day;
  int _month = DateTime.now().month;
  int _year = DateTime.now().year;
  int _weekDay = DateTime.now().weekday;

  List _mesiCon31 = [1, 3, 5, 7, 8, 10, 12];
  List _mesiCon30 = [4, 6, 9, 11];





  final CalendarBloc _calendarBloc = CalendarBloc();

  @override
  Widget build(BuildContext context) {
    PageController _controller = PageController(initialPage: 0, keepPage: true);

    return Padding(
      padding: const EdgeInsets.only(top: 12.0,left: 12,right: 12),
      child: PageView(



        children: <Widget>[
          _calendar(_day, _month, _year),
          _calendar(1, (_month + 1) % 12, (_year)),
          _calendar(1, (_month + 2) % 12, (_year)),
          _calendar(1, (_month + 3) % 12, (_year)),
          _calendar(1, (_month + 4) % 12, (_year)),
          _calendar(1, (_month + 5) % 12, (_year)),
        ],
      ),
    );
  }
  int weekDay(int anno, int mese,  int giorno)
  {
   DateTime det = new DateTime(anno,mese,giorno );
   int weekday = det.weekday;
   return weekday;
  }
  Widget _calendar(int day, int month, int year) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.1;
    double containerHeight = 30;
    double containerWidth = MediaQuery.of(context).size.width / 7.5;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
                width: containerWidth,
                height: containerHeight,
                child: Center(
                    child: Text(
                  'Dom',
                  style: calendarStyle,
                ))),
            Container(
                width:containerWidth,
                height: containerHeight,
                child: Center(
                    child: Text(
                  'Lun',
                  style: calendarStyle,
                ))),
            Container(
                width:containerWidth ,
                height: containerHeight,
                child: Center(
                    child: Text(
                  'Mar',
                  style: calendarStyle,
                ))),
            Container(
                width: containerWidth,
                height: containerHeight,
                child: Center(
                    child: Text(
                  'Mer',
                  style: calendarStyle,
                ))),
            Container(
                width: containerWidth,
                height: containerHeight,
                child: Center(
                    child: Text(
                  'Gio',
                  style: calendarStyle,
                ))),
            Container(
                width: containerWidth,
                height: containerHeight,
                child: Center(
                    child: Text(
                  'Ven',
                  style: calendarStyle,
                ))),
            Container(
                width: containerWidth,
                height: containerHeight,
                child: Center(
                    child: Text(
                  'Sab',
                  style: calendarStyle,
                ))),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 18.0, top: 12, bottom: 12),
          child: Text(
            _calendarBloc.monthHeadings[month],
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height *
                  0.01 *
                  multiplierSubtitle2,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Flexible(
            child: GridView.count(
          crossAxisCount: 7,
          primary: false,
          children:
              List.generate(42, (index) => _date(index, day, month, year)),
        ))
      ],
    );
  }

  Widget _date(int index, int day, int month, int year) {
    int _firstDay = _weekDay - (day % 7 - 1);

    if (month > this._month % 12) {
      _firstDay =
          DateTime.parse('$year-' + month.toString().padLeft(2, '0') + '-01')
              .weekday;
    }

    index -= _firstDay - 1;

    if (month != 2) {
      for (int i in _mesiCon31) {
        if (month == i) {
          if (index >= day && index <= 31) {
            return _availableDates(index, month, year);
          } else if (index > 0 && index < day) {
            return _unavailableDates(index);
          } else {
            return Text('');
          }
        }
      }

      for (int i in _mesiCon30) {
        if (month == i) {
          if (index >= day && index <= 30) {
            return _availableDates(index, month, year);
          } else if (index > 0 && index < day) {
            return _unavailableDates(index);
          } else {
            return Text('');
          }
        }
      }
    }

    if (month == 2) {
      if (year % 4 != 0) {
        if (index >= day && index <= 28) {
          return _availableDates(index, month, year);
        } else if (index > 0 && index < day) {
          return _unavailableDates(index);
        } else {
          return Text('');
        }
      } else {
        if (index >= day && index <= 29) {
          return _availableDates(index, month, year);
        } else if (index > 0 && index < day) {
          return _unavailableDates(index);
        } else {
          return Text('');
        }
      }
    }

    return Container();
  }

  Widget _unavailableDates(int index) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.blueGrey.withOpacity(0.3)),
        child: Center(
          child: Text('$index'),
        ),
      ),
    );
  }

  Widget _availableDates(int index, int month, int year) {
    return StreamBuilder<List<Calendar>>(
        initialData: _calendarBloc.calendarList,
        stream: _calendarBloc.calendarListStream,
        builder: (context, snapshot) {
          return InkWell(

            borderRadius: BorderRadius.circular(10),
            onTap: () {
              if (_calendarBloc.flag == true) {
                if (year < _calendarBloc.calendarList[1].year) {
                  _calendarBloc.calendarStartDate
                      .add(Calendar(index, month, year, weekDay(year,month,index)));
                  _calendarBloc.calendarEndDate.add(Calendar(0, 0, 0, 1));
                  _calendarBloc.flag = !_calendarBloc.flag;
                } else if (year == _calendarBloc.calendarList[1].year) {
                  if (month < _calendarBloc.calendarList[1].month) {
                    _calendarBloc.calendarStartDate
                        .add(Calendar(index, month, year, weekDay(year,month,index)));
                    _calendarBloc.calendarEndDate.add(Calendar(0, 0, 0, 1));
                    _calendarBloc.flag = !_calendarBloc.flag;
                  } else if (month == _calendarBloc.calendarList[1].month) {
                    if (index <= _calendarBloc.calendarList[1].day) {
                      _calendarBloc.calendarStartDate
                          .add(Calendar(index, month, year, weekDay(year,month,index)));
                      _calendarBloc.calendarEndDate.add(Calendar(0, 0, 0, 1));
                      _calendarBloc.flag = !_calendarBloc.flag;
                    } else {
                      _calendarBloc.calendarStartDate
                          .add(Calendar(index, month, year, weekDay(year,month,index)));
                      _calendarBloc.calendarEndDate.add(Calendar(0, 0, 0, 1));
                      _calendarBloc.flag = !_calendarBloc.flag;
                    }
                  } else {
                    _calendarBloc.calendarStartDate
                        .add(Calendar(index, month, year, weekDay(year,month,index)));
                    _calendarBloc.calendarEndDate.add(Calendar(0, 0, 0, 1));
                    _calendarBloc.flag = !_calendarBloc.flag;
                  }
                } else {
                  _calendarBloc.calendarStartDate
                      .add(Calendar(index, month, year, weekDay(year,month,index)));
                  _calendarBloc.calendarEndDate.add(Calendar(0, 0, 0, 1));
                  _calendarBloc.flag = !_calendarBloc.flag;
                }
              } else {
                if (year > _calendarBloc.calendarList[0].year) {
                  _calendarBloc.calendarEndDate
                      .add(Calendar(index, month, year, weekDay(year,month,index)));
                  _calendarBloc.flag = !_calendarBloc.flag;
                } else if (year == _calendarBloc.calendarList[0].year) {
                  if (month > _calendarBloc.calendarList[0].month) {
                    _calendarBloc.calendarEndDate
                        .add(Calendar(index, month, year, weekDay(year,month,index)));
                    _calendarBloc.flag = !_calendarBloc.flag;
                  } else if (month == _calendarBloc.calendarList[0].month) {
                    if (index > _calendarBloc.calendarList[0].day) {
                      _calendarBloc.calendarEndDate
                          .add(Calendar(index, month, year, weekDay(year,month,index)));
                      _calendarBloc.flag = !_calendarBloc.flag;
                    }else{
                      _calendarBloc.calendarStartDate
                          .add(Calendar(index, month, year, weekDay(year,month,index)));



                    }
                  }
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:3, vertical: 3),
              child:
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    if ((index == snapshot.data?[0].day &&
                            month == snapshot.data?[0].month &&
                            year == snapshot.data?[0].year) ||
                        (index == snapshot.data?[1].day &&
                            month == snapshot.data?[1].month &&
                            year == snapshot.data?[1].year)) ...[
                      BoxShadow(
                          color: Color(0xff10ACD5),
                          offset: Offset(0, 3),
                          blurRadius: 10)
                    ]
                  ],
                  borderRadius:(index > snapshot.data![0].day &&
                      month == snapshot.data![0].month &&
                      year == snapshot.data![0].year) &&
                      (index < snapshot.data![1].day &&
                          month == snapshot.data![1].month &&
                          year == snapshot.data![1].year)?BorderRadius.circular(0): BorderRadius.circular(10.0),
                  gradient: (index == snapshot.data?[0].day &&
                              month == snapshot.data?[0].month &&
                              year == snapshot.data?[0].year) ||
                          (index == snapshot.data?[1].day &&
                              month == snapshot.data?[1].month &&
                              year == snapshot.data?[1].year)
                      ? LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                              Color(0xff10ACD5).withOpacity(0.5),
                              Color(0xff10ACD5).withOpacity(0.8)
                            ])
                      : ((index > snapshot.data![0].day &&
                                  month == snapshot.data![0].month &&
                                  year == snapshot.data![0].year) &&
                              (index < snapshot.data![1].day &&
                                  month == snapshot.data![1].month &&
                                  year == snapshot.data![1].year))
                          ? LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                  Color(0xff10ACD5).withOpacity(0.2),
                                  Color(0xff10ACD5).withOpacity(0.2)
                                ])
                          : LinearGradient(
                              colors: [Colors.white, Colors.white]),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,


                  children:[ 
                    Text(
                    '$index',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                    color: (index == snapshot.data?[0].day &&
                                month == snapshot.data?[0].month &&
                                year == snapshot.data?[0].year) ||
                            (index == snapshot.data?[1].day &&
                                month == snapshot.data?[1].month &&
                                year == snapshot.data?[1].year)
                        ? Colors.white
                        : Color(0xff151C3D)),
                  ),
                    Padding(
                      padding:  EdgeInsets.only(top: 6.0),
                      child: Container(
                        height: 4, // Mettere un controllo su questo valore quando sarà disponibile l'API
                        width: 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          color: Color(0xFFD40000)
                        ) ,
                      ),
                    )


                  ]
                ),
              ),
            ),
          );
        });
  }
}
