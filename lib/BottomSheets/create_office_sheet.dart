
import 'dart:io';

import 'package:bookingmobile2/Models/ModelProvider.dart';
import 'package:bookingmobile2/Repos/data_repo.dart';
import 'package:bookingmobile2/Repos/storage_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../Bloc/profile_bloc.dart';
import '../Utils/constants.dart';
import '../Utils/functions.dart';





class CreateOffice extends StatefulWidget {
  const CreateOffice({Key? key}) : super(key: key);

  @override
  State<CreateOffice> createState() => _CreateOfficeState();
}

class _CreateOfficeState extends State<CreateOffice> {
  bool selectFile = false;

  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();
  ImageSource? imageSource ;
  XFile? file;


  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerAddress = TextEditingController();
  TextEditingController controllerCity = TextEditingController();
  TextEditingController controllerCapienza = TextEditingController();

  bool isFormValid = false;




  late double heightSize = MediaQuery.of(context).size.height;
  late double widthSize = MediaQuery.of(context).size.width;
  late double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
  @override
  Widget build(BuildContext context) {




    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        height: MediaQuery
            .of(context).viewInsets.bottom==0 ? MediaQuery.of(context).size.height *0.82 : MediaQuery
            .of(context)
            .size
            .height *0.92,
        decoration: BoxDecoration(

            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18))),
        child:



        Stack(
   children:  [
     Form(
       key: _formKey,

     child: Column(
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

              Padding(
                padding:  EdgeInsets.only(left: 18,top: heightSize*0.01),
                child: Text("Crea un nuovo ufficio", style: TextStyle(
                  fontSize: unitHeightValue*multiplierBigTitle,
                  fontWeight: FontWeight.bold,

                 ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.all(15.0),
                child: TextFormField(


                textAlignVertical: TextAlignVertical.bottom,
                showCursor: true,
                controller: controllerName ,
                validator: (value)=>value!.isNotEmpty? null: "Campo vuoto",

                style: TextStyle(
                color: Color(0xFF757575).withOpacity(0.8),
                fontWeight: FontWeight.w400,
                fontSize: multiplierParagraph * heightSize * 0.012,

                ),

                decoration: InputDecoration(

                  floatingLabelBehavior: FloatingLabelBehavior.always,
                alignLabelWithHint: true,
                filled: true,
                fillColor: backGround2.withOpacity(0.8),

                labelText: "Nome",
                labelStyle: TextStyle(
                fontSize: multiplierParagraph * heightSize *
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
        top: heightSize * 0.033,
        left: 19,
        bottom: heightSize * 0.025),
        ),
        ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: 15.0, right: 15, top: 5, bottom: 15),
                child: TextFormField(
                  validator: (value)=>value!.isNotEmpty? null: "Campo vuoto",


                  textAlignVertical: TextAlignVertical.bottom,
                  showCursor: true,
                  controller: controllerAddress ,

                  style: TextStyle(
                    color: Color(0xFF757575).withOpacity(0.8),
                    fontWeight: FontWeight.w400,
                    fontSize: multiplierParagraph * heightSize * 0.012,

                  ),

                  decoration: InputDecoration(

                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    alignLabelWithHint: true,
                    filled: true,
                    fillColor: backGround2.withOpacity(0.8),

                    labelText: "Indirizzo",
                    labelStyle: TextStyle(
                        fontSize: multiplierParagraph * heightSize *
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
                        top: heightSize * 0.033,
                        left: 19,
                        bottom: heightSize * 0.025),
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: 15.0, right: 15, top: 5),
                child: TextFormField(
                  validator: (value)=>value!.isNotEmpty? null: "Campo vuoto",


                  textAlignVertical: TextAlignVertical.bottom,
                  showCursor: true,
                  controller: controllerCity ,

                  style: TextStyle(
                    color: Color(0xFF757575).withOpacity(0.8),
                    fontWeight: FontWeight.w400,
                    fontSize: multiplierParagraph * heightSize * 0.012,

                  ),

                  decoration: InputDecoration(

                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    alignLabelWithHint: true,
                    filled: true,
                    fillColor: backGround2.withOpacity(0.8),

                    labelText: "Città",
                    labelStyle: TextStyle(
                        fontSize: multiplierParagraph * heightSize *
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
                        top: heightSize * 0.033,
                        left: 19,
                        bottom: heightSize * 0.025),
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: 15.0, top: 15, right: 15),
                child: Row(

                  children: [
                    SizedBox(
                      width: widthSize/2,
                      child: TextFormField(
                        validator: (value)=>(value!.isNotEmpty && isNumeric(value))?null: "Input non valido",



                        textAlignVertical: TextAlignVertical.bottom,
                        showCursor: true,
                        controller: controllerCapienza  ,
                        keyboardType: TextInputType.number,

                        style: TextStyle(
                          color: Color(0xFF757575).withOpacity(0.8),
                          fontWeight: FontWeight.w400,
                          fontSize: multiplierParagraph * heightSize * 0.012,

                        ),

                        decoration: InputDecoration(



                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          alignLabelWithHint: true,
                          filled: true,
                          fillColor: backGround2.withOpacity(0.8),

                          labelText: "Capienza",
                          labelStyle: TextStyle(
                              fontSize: multiplierParagraph * heightSize *
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
                              top: heightSize * 0.033,
                              left: 19,
                              bottom: heightSize * 0.025),
                        ),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: heightSize*0.07),
                      child: IconButton(onPressed: () async{
                        _showImageSourceActionSheet(context);


                        }, icon: Icon(Icons.photo,size: 28,color: this.file==null? Colors.black:purpleFluo,), ),
                    ),




                  ],
                ),


              ),
      ],

            ),
   ),
     Align(
       alignment: Alignment.bottomCenter,
       child: GestureDetector(
         onTap: (){
           if(_formKey.currentState!.validate()){

             _submitOffice(context);





             }

           },
         child: Padding(
           padding: EdgeInsets.only(
               left: heightSize*0.02, right: heightSize*0.02, bottom: heightSize>700? heightSize*0.03:10, top:  heightSize>700? heightSize*0.08:heightSize*0.05),
           child: Container(
             width: widthSize,
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
                 "AGGIUNGI UFFICIO", style: TextStyle(
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

        )


      ),
    );
  }

  void _showImageSourceActionSheet(BuildContext context) async {
    Function(ImageSource) selectImageSource = (imageSource)  async{
      this.imageSource = imageSource;
      if(imageSource!= null)
        this.file  = await _picker.pickImage(source: this.imageSource!);



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


  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }


  Future<void> _submitOffice(context1) async {
    Office of = Office(name: controllerName.value.text, indirizzo: controllerAddress.value.text, city: controllerCity.value.text, capienza: int.parse(controllerCapienza.value.text));
String key= "";

  if(imageSource!= null) {
    try {

      if (this.file != null)
        key = await context.read<StorageRepository>().uploadOfficeFile(
            File(this.file!.path), of);



    } catch (e) {
      print("Impossibile caricare la foto");
      Functions.showSnackBar(context1, "Impossibile caricare la foto");
    }
  }

    of.immagine = key;

  try{
    
    context.read<DataRepository>().saveOffice(of);
    listOfficeKey.currentState?.insertItem(0);
    setState(() {

      refreshPage.value == 0
          ? refreshPage.value = 1
          : refreshPage.value = 0;


    });


    Functions.showSuccessSnackBar(context, "Ufficio caricato con successo");
    Navigator.of(context).pop();

  }catch(c){


    Functions.showSnackBar(context, "Impossibile caricare l'ufficio");

   }

  }

}

