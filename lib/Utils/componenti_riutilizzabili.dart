




import 'package:bookingmobile2/Utils/constants.dart';
import 'package:bookingmobile2/Utils/functions.dart';
import 'package:bookingmobile2/Utils/image_caching.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../Bloc/prenotazione_flow_bloc.dart';
import '../Models/Office.dart';
import '../Models/Prenotazione.dart';
import '../Models/Sala.dart';


class SalaCard extends StatelessWidget{


  SalaCard({Key? key, required this.sala}) : super(key: key) ;
  Sala sala;
  @override
  Widget build(BuildContext context) {
    double heightSize = MediaQuery.of(context).size.height;
    double widthSize = MediaQuery.of(context).size.width;
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    return  Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 15,vertical: 8),
      child: Container(
        height: MediaQuery.of(context).size.height*0.13,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.08), offset: Offset(0,3), blurRadius: 16)
            ]

        ),


        child: Row(
          children: [
            FutureBuilder<Widget>(
                future:_getSalaImage(sala.immagine!, context),
                builder: (context, snapshot) {
                  return Padding(
                    padding:  EdgeInsets.only(left:10.0, right: 15, top: heightSize*0.01, bottom: heightSize*0.01),
                    child: snapshot.hasData? snapshot.data : CircularProgressIndicator(),
                  );
                }
            ),
            Padding(
              padding: EdgeInsets.only(left: heightSize*0.008, top: heightSize*0.013,bottom:  heightSize*0.005),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(sala.name!, style: TextStyle(
                      color: Color(0xFF1E1E1E),
                      fontWeight: FontWeight.w700,
                      fontSize: multiplierSubtitle*unitHeightValue
                  ),
                  ),



                  Padding(
                    padding:  EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: [
                        Icon(Icons.person_outline, color: Colors.grey, size: heightSize*0.04,),

                        Text("${sala.capienza.toString()} ", style: TextStyle(
                            color: Color(0xFF1E1E1E),
                            fontWeight: FontWeight.w700,
                            fontSize: multiplierParagraph*unitHeightValue
                        ),
                        ),
                        SizedBox(width: 4,),
                        Icon(Icons.stairs_outlined, color: Colors.grey, size: heightSize*0.04,),
                        Text("${sala.piano.toString()} ", style: TextStyle(
                            color: Color(0xFF1E1E1E),
                            fontWeight: FontWeight.w700,
                            fontSize: multiplierParagraph*unitHeightValue
                        ),
                        ),



                      ],
                    ),
                  )
                ],



              ),

            )



          ],

        ),


      ),
    );
  }

  Future<Widget> _getSalaImage(String path, BuildContext context) async{

    String url = await  ImageUrlCache.instance.getUrl(path);


    try {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Hero(

          tag: this.sala.name!,

          child: CachedNetworkImage(
            imageUrl: url, fit: BoxFit.fill, width: MediaQuery
              .of(context)
              .size
              .width * 0.22, height: double.infinity,),
        ),
      );
    }catch(e){
      print(e);
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          color: Colors.white,
          width: MediaQuery
              .of(context)
              .size
              .width * 0.22, height: double.infinity,

        ),
      );

    }




  }




}
class OfficeCard extends StatelessWidget {


   OfficeCard({Key? key, required this.ufficio,  this.index}) : super(key: key) ;
   Office ufficio;
   int? index;
  @override
  Widget build(BuildContext context) {
    double heightSize = MediaQuery.of(context).size.height;
    double widthSize = MediaQuery.of(context).size.width;
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    return  Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 15,vertical: 8),
      child: Container(
        height: MediaQuery.of(context).size.height*0.13,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.08), offset: Offset(0,3), blurRadius: 16)
            ]

        ),


        child: Row(
          children: [
            FutureBuilder<Widget>(
              future: Functions.getOfficeImage(ufficio.immagine!, context, this.ufficio),
              builder: (context, snapshot) {
                return Padding(
                  padding:  EdgeInsets.only(left:10.0, right: 15, top: heightSize*0.01, bottom: heightSize*0.01),
                  child: snapshot.hasData? snapshot.data : Padding(
                    padding:  EdgeInsets.only(left: 20.0,right: 20),
                    child: Icon(Icons.home_work, size: 30, color: blackLight,),
                  ),
                );
              }
            ),
            Padding(
              padding: EdgeInsets.only(left: heightSize*0.008, top: heightSize*0.013,bottom:  heightSize*0.005),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(ufficio.name, style: TextStyle(
                      color: Color(0xFF1E1E1E),
                      fontWeight: FontWeight.w700,
                      fontSize: multiplierSubtitle*unitHeightValue
                  ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: Text(ufficio.indirizzo, style: TextStyle(
                        color: Color(0xFF1E1E1E),
                        fontWeight: FontWeight.w300,
                        fontSize: multiplierParagraph*unitHeightValue

                    ),
                    ),
                  ),

                  Row(
                    children: [
                      Icon(Icons.person_outline, color: Colors.grey, size: heightSize*0.04,),

                      Text("${ufficio.capienza.toString()} postazioni", style: TextStyle(
                          color: Color(0xFF1E1E1E),
                          fontWeight: FontWeight.w300,
                          fontSize: multiplierParagraph*unitHeightValue
                       ),
                      )


                    ],
                  )
                ],



              ),

            )



          ],

        ),


      ),
    );
  }






}
class PurpleArrowBox extends StatelessWidget {
   PurpleArrowBox({required this.larghezza, required this.lunghezza}) ;
  double larghezza;
  double lunghezza;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: larghezza,
      height: lunghezza,
      decoration: BoxDecoration(
          color: Color(0xFF8645FF),
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
                color: Color(0x808645FF),
                offset: Offset(0,3),

                blurRadius: 18
            )
          ]
      ),
      child: Align(
        alignment: Alignment.center,
        child: Icon(
          Icons.arrow_forward_sharp,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
class PurpleBox extends StatelessWidget {
  PurpleBox({required this.larghezza, required this.lunghezza, this.icon , this.image }) ;
  double larghezza;
  double lunghezza;
  IconData? icon;
  Image? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: larghezza,
      height: lunghezza,
      decoration: BoxDecoration(
          color: Color(0xFF8645FF),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Color(0x808645FF),
                offset: Offset(0,2),

                blurRadius: 1
            )
          ]
      ),
      child: Align(
        alignment: Alignment.center,
        child: icon==null? image : Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
class RoundedBox extends StatelessWidget {
  RoundedBox({required this.larghezza, required this.lunghezza, this.icon , this.image, this.color }) ;
  double larghezza;
  double lunghezza;
  IconData? icon;
  Image? image;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: larghezza,
      height: lunghezza,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color:color?? Colors.white,
                offset: Offset(0,2),

                blurRadius: 1
            )
          ]
      ),
      child: Align(
        alignment: Alignment.center,
        child: icon==null? image : Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
class TopBar extends StatelessWidget {
   TopBar({required this.color, this.function});
   Color color;
   Function()? function;

  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height;
    double heightSize = MediaQuery.of(context).size.height;
    double widthSize = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height*0.039,),
        Row(
        children:[
          Padding(
            padding: EdgeInsets.only(left: 20, top: 15),

            child: GestureDetector(
                onTap: function?? (){
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.arrow_back_rounded, color: this.color,size: MediaQuery.of(context).size.width*0.07,)

            ),
          ),
          Spacer(),




        ],
      ),]
    );
  }

Widget _closeButton(BuildContext context){

    return Padding(
      padding: EdgeInsets.only(top: 15, right: 15),

      child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.close, color: Colors.white,)

      ),
    );
}

}
class WhiteRoundedBox extends StatelessWidget {
   WhiteRoundedBox({required this.text, required this.icon }) ;

  String text;
  IconData icon;
  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    return  Container(
        height: MediaQuery.of(context).size.height*0.05,

        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: Color(0x30AFAFB0),


            )
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 8),
          child: Row(
              children:[
                Icon(
                 icon,
                  color: Color(0xFFAFAFB0),

                ),
                SizedBox(width: 4,),
                Text(text, style: TextStyle(
                    fontSize:unitHeightValue*multiplierParagraph2 , fontWeight: FontWeight.w300, color: Color(0xFF1E1E1E)
                ),)
              ]
          ),
        )


    );
  }
}
class BookingBox extends StatefulWidget {
  BookingBox({required this.larghezza, required this.lunghezza, required this.selected}) ;
  double larghezza;
  double lunghezza;
  bool selected;

  @override
  _BookingBoxState createState() => _BookingBoxState();
}
class _BookingBoxState extends State<BookingBox> {
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width:    widget.larghezza,
      height: widget.lunghezza,
      decoration: BoxDecoration(

          color:widget.selected?  Color(0xFF10ACD5): Color(0x808645FF),
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
                color: widget.selected? Color(0xFF10ACD5): Color(0x808645FF),
                offset: Offset(0,3),

                blurRadius: 18
            )
          ]
      ),
      child: Align(
        alignment: Alignment.center,
        child: Icon(
          Icons.person_outline,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}




typedef void SfRangeValuesCallback(SfRangeValues values);
typedef SfRangeValues SfRangeValuesGet();

class CustomSlider extends StatefulWidget {
  PrenotazioneState pre;
   CustomSlider({required this.pre});



  @override
  _CustomSliderState createState() => _CustomSliderState();
}
class _CustomSliderState extends State<CustomSlider> {


  late Future<ui.Image> _loadImage;
   ui.Image? customImage;
   SfRangeValues _rangeValues= SfRangeValues(9.0, 18.0);

    Future<ui.Image> loadImage(String assetPath) async {
    ByteData data = await rootBundle.load(assetPath);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    ui.FrameInfo fi = await codec.getNextFrame();


    return fi.image;
  }

@override
  void initState() {
super.initState();

  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    _loadImage = loadImage("assets/images/thumb.png");


        return FutureBuilder<ui.Image>(
            future: _loadImage,
            builder: (context, snapshot) {

              double start = _rangeValues.start;
              double end = _rangeValues.end;
              widget.pre.prenotazione!.startTime = start.toInt();
              widget.pre.prenotazione!.endTime = end.toInt();


                      BlocProvider.of<BookBloc>(context).add(
                          PrenotazioneBuilding(widget.pre));

if(snapshot.hasData || snapshot.data!= null) {
  return SfRangeSliderTheme(
    data: SfRangeSliderThemeData(
        activeTrackColor: Color(0xFF10ACD5),
        inactiveTrackColor: Color(0xFFD8D8D8),
        inactiveTrackHeight: 3,
        activeTrackHeight: 3
    ),
    child: SfRangeSlider(
      onChanged: (SfRangeValues value) {
        setState(() {
          _rangeValues = value;
        });
        double start = _rangeValues.start;
        double end = _rangeValues.end;
        widget.pre.prenotazione!.startTime = start.toInt();
        widget.pre.prenotazione!.endTime = end.toInt();
        BlocProvider.of<BookBloc>(context).add(
            PrenotazioneBuilding(widget.pre));
      },
      min: 8,
      max: 20,
      interval: 1,
      stepSize: 1,


      values: _rangeValues,
      thumbShape: SliderThumbImage(
          snapshot.data!, textScaleFactor: MediaQuery
          .of(context)
          .textScaleFactor, values: _rangeValues),


    ),
  );
} else return CircularProgressIndicator();





      }

    );

  }
}
class SliderThumbImage implements SfThumbShape {
  final ui.Image image;
  final double radius=15;
  final _indicatorShape = const PaddleSliderValueIndicatorShape();

  SliderThumbImage(this.image,{required this.textScaleFactor, required this.values})
      : _textSpan = TextSpan(),
        _textPainter = TextPainter();
  final double textScaleFactor;
  final SfRangeValues values;
  TextPainter _textPainter;
  TextSpan _textSpan;
  final double verticalSpacing = 5.0;


  @override
  Size getPreferredSize(SfSliderThemeData themeData) {
    _textSpan = TextSpan(text: values.start.toInt().toString());
    _textPainter
      ..text = _textSpan
      ..textDirection = TextDirection.ltr
      ..textScaleFactor = textScaleFactor
      ..layout();
    // Considered label height along with thumb radius to avoid the
    // label get overlapping with adjacent widget.
    return Size(themeData.thumbRadius * 2,
        (themeData.thumbRadius + _textPainter.height + verticalSpacing) * 2);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required RenderBox parentBox,
        required RenderBox? child,
        required SfSliderThemeData themeData,
        SfRangeValues? currentValues,
        dynamic currentValue,
        required Paint? paint,
        required Animation<double> enableAnimation,
        required TextDirection textDirection,
        required SfThumb? thumb}) {
    // TODO: implement paint


    String text = currentValues!.end.toInt().toString();
    if (thumb != null) {
      text = "h ${(thumb == SfThumb.start ? currentValues.start : currentValues.end)
          .toInt()
          .toString()}:00";
    }
    _textSpan = TextSpan(
      text: text,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 11 ),
    );
    _textPainter
      ..text = _textSpan
      ..textDirection = textDirection
      ..textScaleFactor = textScaleFactor
      ..layout()
      ..paint(
        context.canvas,
        // To show the label below the thumb, we had added it with thumb radius
        // and constant vertical spacing.
        Offset(center.dx - _textPainter.width / 2,
            center.dy + verticalSpacing + themeData.thumbRadius),
      );










    final canvas = context.canvas;
    final imageWidth = image.width;
    final imageHeight = image.height;

    Offset imageOffset = Offset(
      center.dx - (imageWidth / 2),
      center.dy - (imageHeight / 2),
    );


    Paint paint = Paint()..filterQuality = FilterQuality.high;

    canvas.drawImage(image, imageOffset, paint);


  }




}
class DrawCircle extends CustomPainter {

  Color color;
  double radius;
  DrawCircle(this.color, this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = color;
    canvas.drawCircle(Offset(0.0, 0.0), radius, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate)
  {//false : paint call might be optimized away.
    return false;
  }
}
class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  CircularProgressIndicator(color: Colors.white70 , strokeWidth: 2,);
  }
}

class ImageSliver extends StatefulWidget {
 ImageSliver(this.url, this.pre);
final  String url;
final Prenotazione pre;


  @override
  _ImageSliverState createState() => _ImageSliverState();
}
class _ImageSliverState extends State<ImageSliver>
    with AutomaticKeepAliveClientMixin<ImageSliver> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CachedNetworkImage(imageUrl: widget.url, fit: BoxFit.cover,  errorWidget:(context,url,error)=> Padding(
        padding: EdgeInsets
            .symmetric(
            vertical: 6),
        child: GestureDetector
          (
          onTap: () {

          },
          child: Container(


              decoration: BoxDecoration(
                borderRadius: BorderRadius
                    .circular(
                    20),



              ),
              child:


              Align(
                alignment: Alignment.center,
                child: Text(
                  "${widget.pre

                      .name![0]
                      .toUpperCase()}${widget.pre

                      .surname![0]
                      .toUpperCase()}",
                  style: TextStyle(
                      fontWeight: FontWeight
                          .bold,
                      color: Colors
                          .white,
                    fontSize: MediaQuery.of(context).size.width*0.08


                  ),),
              )


          ),
        )) ,);
  }
}

