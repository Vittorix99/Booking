

import 'dart:io';

import 'package:bookingmobile2/Utils/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../Bloc/login_bloc.dart';
import '../Bloc/profile_bloc.dart';
import '../Cubit/session_cubit.dart';
import '../Cubit/session_state.dart';
import '../Models/User.dart';
import '../Utils/componenti_riutilizzabili.dart';

class AccountDetailsPage extends StatefulWidget {
  const AccountDetailsPage({Key? key}) : super(key: key);

  @override
  State<AccountDetailsPage> createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {

  final controllerName = TextEditingController();
  final controllerSurname = TextEditingController();
  final controllerMail = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProfileState state = context.read<ProfileBloc>().state;
    controllerName.text = state.user!.name!;
    controllerSurname.text = state.user!.surname!;
    controllerMail.text = state.user!.mail!;

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double heightSize = MediaQuery
        .of(context)
        .size
        .height;
    double widthSize = MediaQuery
        .of(context)
        .size
        .width;
    double unitHeightValue = MediaQuery
        .of(context)
        .size
        .height * 0.01;

    return BlocBuilder<SessionCubit, SessionState>(
        builder: (context, state) {
          return BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state.imageSourceActionSheetIsVisible != null)
                if (state.imageSourceActionSheetIsVisible!) {
                  _showImageSourceActionSheet(context);
                }
              if(state.formStatus!= null)
               if(state.formStatus is SubmissionSuccess){
                 _showSuccessSnackBar(context, "Dati modificati con successo");
                     BlocProvider.of<ProfileBloc>(context).emit(state.copyWith(formStatus: InitialFormStatus()));

               }else if(state.formStatus is SubmissionFailed){

                 _showErrorSnackBar(context, "Non è stato possibile inserire i dati");
               }

            },
            child: GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus() ,
              child: Scaffold(

                backgroundColor: Color(0xFFE5E5E5),

                body: BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, profilestate) {
                      return Stack(

                          children:
                          [
                            SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TopBar(color: Color(0xFF1E1E1E),
                                      function: () => Navigator.of(
                                          context, rootNavigator: true)
                                          .pop()),
                                  //BlocProvider.of<SessionCubit>(context).emit(Authenticated(profilestate.user!)),),
                                  Padding(
                                    padding: EdgeInsets.only(top: 0,),
                                    child:

                                    Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white70

                                        ),
                                        width: heightSize * 0.085 * 2,
                                        height: heightSize * 0.085 * 2,
                                        child: profilestate.avatarPath == null
                                            ? Icon(Icons.person, size: 50,)
                                            :
                                        Builder(
                                            builder: (context) {
                                              try {
                                                return ClipRRect(
                                                  borderRadius: BorderRadius
                                                      .circular(50),
                                                  child: CachedNetworkImage(
                                                    imageUrl: profilestate
                                                        .avatarPath!,
                                                    fit: BoxFit.cover,
                                                    errorWidget: (context, url, error){
                                                      return Icon(Icons.person,size: 50,);

                                                    },
                                                  ),
                                                );
                                              } catch (e) {
                                                return Icon(
                                                  Icons.person, size: 50,);
                                              }
                                            }
                                        )


                                    ),
                                  ),
                                  TextButton(onPressed: () {
                                    BlocProvider.of<ProfileBloc>(context).add(
                                        ChangeAvatarRequest());
                                  },
                                      child: Text("Change Avatar",
                                        style: TextStyle(
                                            fontFamily: "Montserrat"),)),

                                  SizedBox(height: heightSize * 0.003,),

                                  _nameTile(),
                                  _surnameTile(),
                                  _emailTile(),

                                  _saveProfileChangesButton(),


                                ],


                              ),
                            ),
                            Positioned(
                              left: widthSize * 0.23,
                              top: heightSize * 0.2,

                              child: CustomPaint(
                                painter: DrawCircle(Color(0xFF151C3D).withOpacity(
                                    0.32), 18),
                              ),
                            ),
                            Positioned(
                              left: widthSize * 0.3,
                              top: heightSize * 0.25,

                              child: CustomPaint(
                                painter: DrawCircle(Color(0xFF8645FF).withOpacity(
                                    0.14), 30),
                              ),
                            ),
                            Positioned(
                              right: widthSize * 0.26,
                              top: heightSize * 0.24,

                              child: CustomPaint(
                                painter: DrawCircle(Color(0xFF10ACD5).withOpacity(
                                    0.14), 27),
                              ),
                            ),
                            Positioned(
                              right: widthSize * 0.2,
                              top: heightSize * 0.22,

                              child: CustomPaint(
                                painter: DrawCircle(Color(0xFF8645FF).withOpacity(
                                    0.3), 15),
                              ),
                            ),


                          ]
                      );
                    }
                ),


              ),
            ),
          );
        }
    );
  }


  void _showImageSourceActionSheet(BuildContext context) {
    Function(ImageSource) selectImageSource = (imageSource) {
      context.read<ProfileBloc>().add(OpenImagePicker(imageSource));
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

  Widget _nameTile() {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
     return Padding(
        padding: EdgeInsets.only(
            left: 14, right: 14, top: 10),

        child: TextFormField(
          textAlignVertical: TextAlignVertical.bottom,
          showCursor: true,
          controller: controllerName,

          style: TextStyle(
            color: Color(0xFF757575).withOpacity(0.8),
            fontWeight: FontWeight.w400,
            fontSize: multiplierParagraph * MediaQuery.of(context).size.height * 0.012,

          ),

          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            alignLabelWithHint: true,
            labelText: "Name",
            labelStyle: TextStyle(
                fontSize: multiplierParagraph * MediaQuery.of(context).size.height  *
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
                top: MediaQuery.of(context).size.height  * 0.033,
                left: 19,
                bottom: MediaQuery.of(context).size.height  * 0.025),
          ),
        ),
      );
    });
  }

  Widget _surnameTile() {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return    Padding(
        padding: EdgeInsets.only(
            left: 14, right: 14, top: 20),

        child: TextFormField(
          textAlignVertical: TextAlignVertical.bottom,
          showCursor: true,
          controller: controllerSurname ,

          style: TextStyle(
            color: Color(0xFF757575).withOpacity(0.8),
            fontWeight: FontWeight.w400,
            fontSize: multiplierParagraph * MediaQuery.of(context).size.height * 0.012,

          ),

          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            alignLabelWithHint: false,
            labelText: "Cognome",
            labelStyle: TextStyle(
                fontSize: multiplierParagraph * MediaQuery.of(context).size.height  *
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
                top: MediaQuery.of(context).size.height  * 0.033,
                left: 19,
                bottom: MediaQuery.of(context).size.height  * 0.025),
          ),
        ),
      );
    });
  }

  Widget _emailTile() {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
     return Padding(
        padding: EdgeInsets.only(
            left: 14, right: 14, top:  20),

        child: TextFormField(
          textAlignVertical: TextAlignVertical.bottom,
          showCursor: false,
          controller: controllerMail,
          readOnly: true,

          style: TextStyle(
            color: Color(0xFF757575).withOpacity(0.8),
            fontWeight: FontWeight.w400,
            fontSize: multiplierParagraph *  MediaQuery.of(context).size.height * 0.012,

          ),

          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            alignLabelWithHint: false,
            labelText: "Email",

            labelStyle: TextStyle(
                fontSize: multiplierParagraph *  MediaQuery.of(context).size.height *
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
                top:  MediaQuery.of(context).size.height * 0.033,
                left: 19,
                bottom:  MediaQuery.of(context).size.height * 0.025),
          ),
        ),
      );
    });
  }


  Widget _saveProfileChangesButton() {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return (state.formStatus is FormSubmitting)
          ? CircularProgressIndicator()
          : Padding(
            padding:  EdgeInsets.only(top: 8.0),
            child: ElevatedButton(
              style: ButtonStyle(
                shape:  MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),

                    )
                ),
                backgroundColor: MaterialStateProperty.all(purpleFluo),
               // maximumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width*0.3, 70)),
                fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width*0.5, 40)),

              ),
        onPressed: () {
         User user = state.user!.copyWith(name: controllerName.value.text, surname: controllerSurname.value.text, mail: controllerMail.value.text);

         BlocProvider.of<ProfileBloc>(context).add(SaveProfileChanges(user));

        },
        child: Text('Save Changes', style: TextStyle(
          color: backGround2
        ),),
      ),
          );
    });

  }


  void _showSuccessSnackBar(BuildContext context ,
      String message){
    final snackBar = SnackBar(content: Text(message),backgroundColor:Colors.green,elevation: 3,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);


  }
  void _showErrorSnackBar(BuildContext context ,
      String message){
    final snackBar = SnackBar(content: Text(message),backgroundColor:Colors.redAccent,elevation: 3,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);


  }

}
