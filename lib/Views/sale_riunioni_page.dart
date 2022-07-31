
import 'package:bookingmobile2/Models/ModelProvider.dart';
import 'package:bookingmobile2/Repos/data_repo.dart';
import 'package:bookingmobile2/Utils/componenti_riutilizzabili.dart';
import 'package:bookingmobile2/Utils/constants.dart';
import 'package:bookingmobile2/Views/reservation_page.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/prenotazione_flow_bloc.dart';
import '../Models/Prenotazione.dart';

class SelectSalaPage extends StatefulWidget {
  SelectSalaPage({required this.city, required this.office});
  final Office office;
  final String city;
  @override
  _SelectSalaPageState createState() => _SelectSalaPageState();
}

class _SelectSalaPageState extends State<SelectSalaPage> {


  @override
  void dispose(){
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final bookBloc = BlocProvider.of<BookBloc>(context);
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double heightSize = MediaQuery.of(context).size.height;
    double widthSize = MediaQuery.of(context).size.width;



    // var offices = mockedOffices.where((element) => element.city.toLowerCase() == widget.city.toLowerCase());

        return BlocBuilder<BookBloc, PrenotazioneState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Color(0xFF151C3D),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopBar(color: Colors.white),
                  Padding(padding: EdgeInsets.only(left: 18, top: 15, bottom: 4),
                    child: Image.asset("assets/images/${widget.city.toLowerCase()}.png", width: heightSize*0.25,) ,
                  ),
                  Flexible(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color(0xFFF7F9FB),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))

                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(top: 35, left: 28, right: 28),
                            child: RichText(
                              textAlign: TextAlign.center ,

                              text: TextSpan(

                                  text: "Scegli dove prenotare la tua ",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: multiplierBigTitle2*unitHeightValue,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF1E1E1E)


                                  ),
                                  children: [
                                    TextSpan(text: "Sala",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: multiplierBigTitle2*unitHeightValue,
                                            fontWeight: FontWeight
                                                .w700,
                                            color: Color(0xFF10ACD5)

                                        )
                                    ),


                                  ]


                              ),


                            ),
                          ),
                          Flexible(
                            child: FutureBuilder<List<Sala>>(
                                future: context.read<DataRepository>().getSaleByOffice(widget.office.id),
                                builder: (context, snapshot) {


                                  if(snapshot.hasData) {

                                    if(snapshot.data!.length!=0) {
                                      return ListView.builder(


                                          itemCount: snapshot.data!.length,
                                          itemBuilder: (BuildContext context, int index) {

                                            return Stack(
                                              alignment: Alignment.centerRight,
                                              children: [

                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: heightSize * 0.02),
                                                  child: SalaCard(
                                                    sala: snapshot.data!.elementAt(
                                                        index),),
                                                ),


                                                Positioned(

                                                  right: heightSize * 0.012,
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        Prenotazione pre = state.prenotazione!;
                                                        pre.salaID = snapshot.data!.elementAt(index).id;
                                                        BlocProvider.of<BookBloc>(context)
                                                            .add(PrenotazioneBuilding(
                                                            PrenotazioneState(
                                                                prenotazione: pre)));


                                                        Navigator.pushNamed(
                                                            context,
                                                            '/reservation_sala',
                                                            arguments: {
                                                             'sala': snapshot.data!
                                                                  .elementAt(
                                                                  index),
                                                              'office':widget.office
                                                            }


                                                        );
                                                      },
                                                      child: PurpleArrowBox(
                                                        lunghezza: heightSize * 0.06,
                                                        larghezza: heightSize * 0.06,
                                                      )
                                                  ),
                                                )

                                              ],
                                            );
                                          }
                                      );
                                    }
                                    else{
                                      return Padding(
                                        padding:  EdgeInsets.only(top:heightSize*0.15,left: 25,right: 25),
                                        child: Container(
                                          height: heightSize*0.2,
                                          width: widthSize,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(30),
                                              boxShadow: [
                                                BoxShadow(color: Colors.grey, offset: Offset(0,3), blurRadius: 20)
                                              ]
                                          ),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(

                                              "Non sono ancora presenti sale in questo ufficio",textAlign: TextAlign.center,  style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: heightSize*0.025,
                                                fontFamily: "Monteserrat",
                                                color:   Color(0xFF151C3D)


                                            ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  }else {
                                    return Center(child:  CircularProgressIndicator(color: purpleFluo , strokeWidth: 2,),);



                                  }
                                }
                            ),
                          )

                        ],




                      ),

                    ),
                  )

                ],
              ),


            );
          }
        );


  }
}

