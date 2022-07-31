import 'dart:io';

import 'package:bookingmobile2/BottomSheets/create_office_sheet.dart';
import 'package:bookingmobile2/Repos/data_repo.dart';
import 'package:bookingmobile2/Utils/componenti_riutilizzabili.dart';
import 'package:bookingmobile2/Utils/constants.dart';
import 'package:bookingmobile2/Utils/functions.dart';
import 'package:bookingmobile2/Views/prenotazioni_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../Bloc/profile_bloc.dart';
import '../Models/Office.dart';
import '../Repos/storage_repo.dart';
import '../Utils/image_caching.dart';

class GestisciUffici extends StatefulWidget {


  @override
  State<GestisciUffici> createState() => _GestisciUfficiState();
}

class _GestisciUfficiState extends State<GestisciUffici> {
  late double heightSize = MediaQuery.of(context).size.height;
  late double widthSize = MediaQuery.of(context).size.width;
  late double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
  final _formKey = GlobalKey<FormState>();
  XFile? file;
  final _picker = ImagePicker();
  ImageSource? imageSource ;

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerAddress = TextEditingController();
  TextEditingController controllerCity = TextEditingController();
  TextEditingController controllerCapienza = TextEditingController();




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: backGround2,
      floatingActionButton: FloatingActionButton(
        backgroundColor: purpleFluo,

        onPressed: () {  },
        child: IconButton(onPressed: () {

          showModalBottomSheet(shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(40),
                topLeft: Radius.circular(40)),
          ),

              isScrollControlled: true,
              context: context,
              builder: (context) {
                return CreateOffice();
              });


        },
          icon: Icon(Icons.add),

          
          
        ),

      ),

      body: ValueListenableBuilder(
        valueListenable: refreshPage,
        builder: (context,value,child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding:  EdgeInsets.only(top:20),
                child: TopBar(color: blackLight),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18,top: 23),
                child: Text("I tuoi uffici", style: TextStyle(
                  fontSize: unitHeightValue*multiplierBigTitle,
                  fontWeight: FontWeight.bold,



                ),),
              ),
    Flexible(
    child: FutureBuilder<List<Office>>(
    future: context.read<DataRepository>().getAllOffices(),

    builder: (context, uffici) {

          if(uffici.hasData) {
            return AnimatedList(
              key:listOfficeKey,
            padding: EdgeInsets.symmetric(
            vertical: heightSize * 0.004),
            initialItemCount: uffici.data!.length,
            itemBuilder: (BuildContext context,
            int index, animation) {


            return SlideTransition(
              position: animation.drive(
                  Tween<Offset>(begin: Offset(0, 3), end: Offset(0, 0))
                      .chain(CurveTween(curve: Curves.ease)))
              ,
              child:  Stack(
                alignment: Alignment.topRight,
                children: [
                  OfficeCard(
                ufficio: uffici.data!
                    .elementAt(
                index), index: index,),
                   Padding(
                     padding:  EdgeInsets.only(right: heightSize*0.02),
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

                                try {
                                  _removeItem(index, context,
                                      uffici.data!.elementAt(index));
                                  BlocProvider.of<ProfileBloc>(
                                      context).add(DeleteUfficio(
                                      uffici.data!.elementAt(index)));


                                  Functions.showSuccessSnackBar(context, "Ufficio eliminato con successo");

                                }catch(e){
                                  Functions.showSnackBar(context, "Impossibile eliminare l'ufficio");


                                }






                              })

                      ),
                       PopupMenuItem(

                           child:
                           ListTile(

                               leading: Icon(
                                 Icons.mode_comment, color: blackLight,
                                 size: 22,),
                               title: Text(
                                 "Modifica", style: TextStyle(
                                   fontSize: multiplierSubtitle2 *
                                       unitHeightValue
                               ),),
                               onTap: () {
                                 Navigator.pop(context);
                                 _showEditUfficio(context, uffici.data!.elementAt(index));


                               })

                       )
                  ],
                      icon: Icon(
                        Icons.more_horiz, color: purpleFluo,
                        size: 22,),
                  ),
                   )


              ]
              )
               );


            });
          } else return Center(child: CircularProgressIndicator(),);
          }
    ),
    )



            ],
          );
        }
      ) ,

    );
  }

  void _removeItem(int index, BuildContext context, Office office) {

    listOfficeKey.currentState!.removeItem(index, (context, animation){

      return SlideTransition(
          position:animation.drive(Tween<Offset>(begin: Offset(3,0), end: Offset(0,0)).chain(CurveTween(curve: Curves.ease)))
          ,child: OfficeCard( ufficio: office, index:index ));
    });


  }

  void _showEditUfficio(BuildContext context, Office office) {
    controllerCapienza.text = office.capienza.toString();
    controllerCity.text = office.city;
    controllerAddress.text = office.indirizzo;
    controllerName.text = office.name;

    showDialog(context: context, builder: (_) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            side: BorderSide.none, borderRadius: BorderRadius.circular(30)),
        elevation: 20,
        scrollable: true,
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () async {
                try {
                  await _submitModifica(context, office);
                  Functions.showSuccessSnackBar(context, "Ufficio aggiornato con successo");
                  setState(() {

                    refreshPage.value == 0
                        ? refreshPage.value = 1
                        : refreshPage.value = 0;


                  });
                  Navigator.of(context).pop();
                } catch (e) {
                  Functions.showSnackBar(context, "Impossibile aggiornare l'ufficio");

                }
              },
              child: Container(
                width: widthSize * 0.9,
                height: heightSize * 0.07,

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
                    "MODIFICA UFFICIO", style: TextStyle(
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


        ],
        content: Builder(
            builder: (context) {
              return Container(
                height: heightSize * 0.7,
                width: widthSize * 0.9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10, top: heightSize * 0.01),
                      child: Text("Modifica ufficio", style: TextStyle(
                        fontSize: unitHeightValue * multiplierBigTitle,
                        fontWeight: FontWeight.bold,

                      ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: heightSize*0.01, bottom: heightSize*0.01),
                      child: FutureBuilder<String?>(
                          future: ImageUrlCache.instance.getUrl(office
                              .immagine),
                          builder: (context, url) {
                            return Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius
                                          .circular(
                                          30),
                                      child: Container(
                                        height: heightSize*0.3,
                                        width : widthSize,


                                        child: CachedNetworkImage(
                                          imageUrl: url
                                              .data!,
                                          errorWidget: (context,url,error)=> Icon(Icons.home_work_outlined, size: 30, color: blackLight,),
                                          fit: BoxFit
                                              .cover,),
                                      )
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: heightSize * 0.07),
                                    child: IconButton(onPressed: () async {

                                      _showImageSourceActionSheet(context, office);


                                    },
                                      icon: Icon(Icons.photo, size: 28,
                                        color: (office.immagine==null|| office.immagine == "")?Colors.black: Colors.white,),),
                                  ),

                                ]
                            );
                          }

                      ),
                    ),
                    Form(
                      key: _formKey,

                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          Padding(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: heightSize*0.02, bottom: 15),
                            child: Container(
                              width: widthSize * 0.8,
                              height: 40,

                              child: TextFormField(

                                controller: controllerName,
                                textAlignVertical: TextAlignVertical.bottom,
                                showCursor: true,

                                validator: (value) =>
                                value!.isNotEmpty
                                    ? null
                                    : "Campo vuoto",

                                style: TextStyle(
                                  color: Color(0xFF757575).withOpacity(0.8),
                                  fontWeight: FontWeight.w400,
                                  fontSize: multiplierParagraph * heightSize *
                                      0.012,

                                ),

                                decoration: InputDecoration(

                                  floatingLabelBehavior: FloatingLabelBehavior
                                      .always,
                                  alignLabelWithHint: true,
                                  filled: true,
                                  fillColor: backGround2.withOpacity(0.8),

                                  labelText: "Nome",
                                  labelStyle: TextStyle(
                                      fontSize: multiplierParagraph *
                                          heightSize *
                                          0.013,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF757575).withOpacity(0.8)
                                  ),


                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none
                                      )
                                  ),
                                  contentPadding: EdgeInsets.only(
                                      top: heightSize * 0.01,
                                      left: 19,
                                      bottom: heightSize * 0.02),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 10.0, right: 10, top: 5, bottom: 15),
                            child: Container(
                              width: widthSize * 0.8,
                              height: 40,
                              child: TextFormField(
                                validator: (value) =>
                                value!.isNotEmpty
                                    ? null
                                    : "Campo vuoto",


                                textAlignVertical: TextAlignVertical.bottom,
                                showCursor: true,
                                controller: controllerAddress,

                                style: TextStyle(
                                  color: Color(0xFF757575).withOpacity(0.8),
                                  fontWeight: FontWeight.w400,
                                  fontSize: multiplierParagraph * heightSize *
                                      0.012,

                                ),

                                decoration: InputDecoration(

                                  floatingLabelBehavior: FloatingLabelBehavior
                                      .always,
                                  alignLabelWithHint: true,
                                  filled: true,
                                  fillColor: backGround2.withOpacity(0.8),

                                  labelText: "Indirizzo",
                                  labelStyle: TextStyle(
                                      fontSize: multiplierParagraph *
                                          heightSize *
                                          0.013,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF757575).withOpacity(0.8)
                                  ),


                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none
                                      )
                                  ),
                                  contentPadding: EdgeInsets.only(
                                      top: heightSize * 0.01,
                                      left: 19,
                                      bottom: heightSize * 0.02),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 10.0, right: 10, top: 5),
                            child: Container(
                              height: 40,
                              width: widthSize * 0.8,
                              child: TextFormField(
                                validator: (value) =>
                                value!.isNotEmpty
                                    ? null
                                    : "Campo vuoto",


                                textAlignVertical: TextAlignVertical.bottom,
                                showCursor: true,
                                controller: controllerCity,

                                style: TextStyle(
                                  color: Color(0xFF757575).withOpacity(0.8),
                                  fontWeight: FontWeight.w400,
                                  fontSize: multiplierParagraph * heightSize *
                                      0.012,

                                ),

                                decoration: InputDecoration(

                                  floatingLabelBehavior: FloatingLabelBehavior
                                      .always,
                                  alignLabelWithHint: true,
                                  filled: true,
                                  fillColor: backGround2.withOpacity(0.8),

                                  labelText: "Città",
                                  labelStyle: TextStyle(
                                      fontSize: multiplierParagraph *
                                          heightSize *
                                          0.013,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF757575).withOpacity(0.8)
                                  ),


                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none
                                      )
                                  ),
                                  contentPadding: EdgeInsets.only(
                                      top: heightSize * 0.01,
                                      left: 19,
                                      bottom: heightSize * 0.02),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 10.0, top: 20, right: 10),
                            child: Row(

                              children: [
                                SizedBox(
                                  width: widthSize / 2,
                                  height: 40,
                                  child: TextFormField(
                                    validator: (value) =>
                                    (value!.isNotEmpty &&
                                        Functions.isNumeric(value))
                                        ? null
                                        : "Input non valido",


                                    textAlignVertical: TextAlignVertical.bottom,
                                    showCursor: true,
                                    controller: controllerCapienza,
                                    keyboardType: TextInputType.number,

                                    style: TextStyle(
                                      color: Color(0xFF757575).withOpacity(0.8),
                                      fontWeight: FontWeight.w400,
                                      fontSize: multiplierParagraph *
                                          heightSize * 0.012,

                                    ),

                                    decoration: InputDecoration(


                                      floatingLabelBehavior: FloatingLabelBehavior
                                          .always,
                                      alignLabelWithHint: true,
                                      filled: true,
                                      fillColor: backGround2.withOpacity(0.8),

                                      labelText: "Capienza",
                                      labelStyle: TextStyle(
                                          fontSize: multiplierParagraph *
                                              heightSize *
                                              0.013,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF757575).withOpacity(
                                              0.8)
                                      ),


                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              15),
                                          borderSide: BorderSide(
                                              width: 0,
                                              style: BorderStyle.none
                                          )
                                      ),
                                      contentPadding: EdgeInsets.only(
                                          top: heightSize * 0.01,
                                          left: 19,
                                          bottom: heightSize * 0.02),
                                    ),
                                  ),
                                ),


                              ],
                            ),


                          ),
                        ],

                      ),
                    ),


                  ],


                ),
              );
            }
        ),

      );
    });
  }

    Future<void> _submitModifica(BuildContext context , Office office)async {

      Office newOffice = office;

      newOffice.name = controllerName.text;
      newOffice.city = controllerCity.text;
      newOffice.indirizzo = controllerAddress.text;
      newOffice.capienza = int.tryParse(controllerCapienza.text);


      try{

         await context.read<DataRepository>().updateOffice(newOffice);


      }catch(e){
        throw e;

    }

    }


  void _showImageSourceActionSheet(BuildContext context1,Office of) async {
    Function(ImageSource) selectImageSource = (imageSource)  async{
      this.imageSource = imageSource;
      if(imageSource!= null)
        this.file  = await _picker.pickImage(source: this.imageSource!);

      if(imageSource!= null) {
        try {

          if (this.file != null) {
            String key = await context.read<StorageRepository>()
                .uploadOfficeFile(
                File(this.file!.path), of);
            of.immagine = key;
            await context.read<DataRepository>().updateOffice(of);
            Functions.showSuccessSnackBar(context1, "Immagine caricata con successo");

          }



        } catch (e) {
          print("Impossibile caricare la foto");
          Functions.showSnackBar(context1, "Impossibile caricare la foto");
        }
      }




    };

    if (Platform.isIOS) {
      showCupertinoModalPopup(
          context: context,
          builder: (context) =>
              CupertinoActionSheet(
                actions: [
                  CupertinoActionSheetAction(onPressed: () {
                    Navigator.pop(context);
                    selectImageSource(ImageSource.camera);
                  }, child: Text("Camera")),
                  CupertinoActionSheetAction(onPressed: () {
                    Navigator.pop(context);
                    selectImageSource(ImageSource.gallery);
                  }, child: Text("Galleria"))

                ],

              ));
    } else {
      showModalBottomSheet(
          isScrollControlled: true, context: context, builder: (context) =>
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListView(
                shrinkWrap: true,
                children: [
                  ListTile(leading: Icon(Icons.camera),
                    title: Text("Camera"),
                    onTap: () {
                      Navigator.pop(context);
                      selectImageSource(ImageSource.camera);
                    }

                    ,),


                  ListTile(leading: Icon(Icons.photo_album),

                    title: Text("Gallery"),

                    onTap: () {
                      Navigator.pop(context);

                      selectImageSource(ImageSource.gallery);
                    }

                    ,)


                ],),
            ],
          ));
    }


  }



  }





