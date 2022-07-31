import 'package:bookingmobile2/Bloc/login_bloc.dart';
import 'package:bookingmobile2/Utils/componenti_riutilizzabili.dart';
import 'package:bookingmobile2/Utils/constants.dart';
import 'package:bookingmobile2/Utils/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/profile_bloc.dart';

class CambioPasswordPage extends StatefulWidget {
  const CambioPasswordPage({Key? key}) : super(key: key);

  @override
  State<CambioPasswordPage> createState() => _CambioPasswordPageState();
}

class _CambioPasswordPageState extends State<CambioPasswordPage> {
TextEditingController controllerOldPassword = TextEditingController();
TextEditingController controllerNewPassword1 = TextEditingController();
TextEditingController controllerNewPassword2 = TextEditingController();

late bool _OldPassVisible ;
late bool _NewPassVisible ;
late bool _NewConfPassVisible ;
late bool _buttonEnabled;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _OldPassVisible = false;
    _NewPassVisible = false;
    _NewConfPassVisible = false;
    _buttonEnabled = false;
  }


  @override
  Widget build(BuildContext context) {
    double heightSize = MediaQuery.of(context).size.height;
    double widthSize = MediaQuery.of(context).size.width;
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
   return Scaffold(
     backgroundColor: backGround2,

     body: BlocListener<ProfileBloc, ProfileState>(
       listener: (context, state){
         final formStatus = state.formStatus;
if(formStatus is SubmissionFailed ){

  Functions.showSnackBar(context, formStatus.message );
}else if(formStatus is SubmissionSuccess){

  Functions.showSuccessSnackBar(context, "Password modificata con successo");

}
       },
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           SafeArea(child: TopBar(color: Color(0xFF1E1E1E))),
           Padding(
             padding: const EdgeInsets.only(left: 18,top: 23),
             child: Text("Cambio Password", style: TextStyle(
               fontSize: unitHeightValue*multiplierBigTitle,
               fontWeight: FontWeight.bold,



             ),),
           ),

           Padding(
             padding: EdgeInsets.only(
                 left: 14, right: widthSize*0.2, top: 30),

             child: TextFormField(
               textAlignVertical: TextAlignVertical.bottom,
               showCursor: true,
               controller: controllerOldPassword,
               obscureText: !_OldPassVisible,
               onChanged: (s){
                 if(s.isNotEmpty)    setState(() {
                  _buttonEnabled=true;
                 });

                else if(s.isEmpty)    setState(() {
                   _buttonEnabled=false;
                 });
               },

               style: TextStyle(
                 color: Color(0xFF757575).withOpacity(0.8),
                 fontWeight: FontWeight.w400,
                 fontSize: multiplierParagraph * MediaQuery.of(context).size.height * 0.012,

               ),

               decoration: InputDecoration(
                   labelText: "Old Password",

                   labelStyle: TextStyle(
                       fontSize: multiplierParagraph *  MediaQuery.of(context).size.height *
                           0.013,
                       fontWeight: FontWeight.w400,
                       color: Color(0xFF757575).withOpacity(0.8)
                   ),

                   suffixIcon: IconButton(
                     icon: Icon(
                       // Based on passwordVisible state choose the icon
                       _OldPassVisible
                           ? Icons.visibility
                           : Icons.visibility_off,
                       color: Colors.white60,
                     ),
                     onPressed: () {
                       // Update the state i.e. toogle the state of passwordVisible variable
                       setState(() {
                         _OldPassVisible =
                         !_OldPassVisible;
                       });
                     },
                   ),
                   floatingLabelBehavior:
                   FloatingLabelBehavior
                       .always,
                   alignLabelWithHint: true,
                   filled: true,
                   fillColor: Color(0x21310FF3),
                   border: OutlineInputBorder(
                       borderRadius:
                       BorderRadius.circular(
                           15),
                       borderSide: BorderSide(
                           width: 0,
                           style:
                           BorderStyle.none)),
                   contentPadding: EdgeInsets.only(
                       top: heightSize * 0.035,
                       left: 19,
                       bottom: heightSize*0.02)








               ),
             ),
           ),
           Padding(
             padding: EdgeInsets.only(
                 left: 14, right: widthSize*0.2, top: 30),

             child: TextFormField(
               textAlignVertical: TextAlignVertical.bottom,
               showCursor: true,
               controller: controllerNewPassword1,
               obscureText: !_NewPassVisible,

               style: TextStyle(
                 color: Color(0xFF757575).withOpacity(0.8),
                 fontWeight: FontWeight.w400,
                 fontSize: multiplierParagraph * MediaQuery.of(context).size.height * 0.012,

               ),

              decoration: InputDecoration(
                  labelText: "New Password",

                  labelStyle: TextStyle(
                      fontSize: multiplierParagraph *  MediaQuery.of(context).size.height *
                          0.013,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF757575).withOpacity(0.8)
                  ),

    suffixIcon: IconButton(
    icon: Icon(
    // Based on passwordVisible state choose the icon
    _NewPassVisible
    ? Icons.visibility
          : Icons.visibility_off,
    color: Colors.white60,
    ),
    onPressed: () {
    // Update the state i.e. toogle the state of passwordVisible variable
    setState(() {
    _NewPassVisible =
    !_NewPassVisible;
    });
    },
    ),
    floatingLabelBehavior:
    FloatingLabelBehavior
          .always,
    alignLabelWithHint: true,
    filled: true,
    fillColor: Color(0x21310FF3),
    border: OutlineInputBorder(
    borderRadius:
    BorderRadius.circular(
    15),
    borderSide: BorderSide(
    width: 0,
    style:
    BorderStyle.none)),
    contentPadding: EdgeInsets.only(
    top: heightSize * 0.035,
    left: 19,
    bottom: heightSize*0.02)








    ),
             ),
           ),
           Padding(
             padding: EdgeInsets.only(
                 left: 14, right: widthSize*0.2, top: 30),

             child: TextFormField(
               textAlignVertical: TextAlignVertical.bottom,
               showCursor: true,
               controller: controllerNewPassword2,
               obscureText: !_NewConfPassVisible,

               style: TextStyle(
                 color: Color(0xFF757575).withOpacity(0.8),
                 fontWeight: FontWeight.w400,
                 fontSize: multiplierParagraph * MediaQuery.of(context).size.height * 0.012,

               ),

               decoration: InputDecoration(
                   labelText: "Confirm Password",

                   labelStyle: TextStyle(
                       fontSize: multiplierParagraph *  MediaQuery.of(context).size.height *
                           0.013,
                       fontWeight: FontWeight.w400,
                       color: Color(0xFF757575).withOpacity(0.8)
                   ),

                   suffixIcon: IconButton(
                     icon: Icon(
                       // Based on passwordVisible state choose the icon
                       _NewConfPassVisible
                           ? Icons.visibility
                           : Icons.visibility_off,
                       color: Colors.white60,
                     ),
                     onPressed: () {
                       // Update the state i.e. toogle the state of passwordVisible variable
                       setState(() {
                         _NewConfPassVisible =
                         !_NewConfPassVisible;
                       });
                     },
                   ),
                   floatingLabelBehavior:
                   FloatingLabelBehavior
                       .always,
                   alignLabelWithHint: true,
                   filled: true,
                   fillColor: Color(0x21310FF3),
                   border: OutlineInputBorder(
                       borderRadius:
                       BorderRadius.circular(
                           15),
                       borderSide: BorderSide(
                           width: 0,
                           style:
                           BorderStyle.none)),
                   contentPadding: EdgeInsets.only(
                       top: heightSize * 0.035,
                       left: 19,
                       bottom: heightSize*0.02)








               ),
             ),
           ),

          _saveChangesButton()

         ],

       ),
     ),






   );
  }



  Widget _saveChangesButton(){
    double heightSize = MediaQuery.of(context).size.height;
    double widthSize = MediaQuery.of(context).size.width;
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;



   return BlocBuilder<ProfileBloc, ProfileState>(
     builder: (context, state) {

  return   state.formStatus is FormSubmitting?   Padding(
    padding:  EdgeInsets.only(top: 35,left: widthSize*0.2),
    child: Loading(),
  ) :  Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding:  EdgeInsets.only(top: 30.0,left: 15),
          child:ElevatedButton(

            style: ButtonStyle(
              shape:  MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),

                  )
              ),
              backgroundColor: MaterialStateProperty.all(_buttonEnabled? purpleFluo: Colors.grey),
              // maximumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width*0.3, 70)),
              fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width*0.5, 47)),

            ),
            onPressed: () {

             if(controllerNewPassword2.text.isNotEmpty && controllerNewPassword1.text.isNotEmpty && controllerOldPassword.text.isNotEmpty) {
               if (controllerNewPassword1.text != controllerNewPassword2.text) {
                 Functions.showSnackBar(
                     context, "Le due password non sono le stesse");
               }else{

               BlocProvider.of<ProfileBloc>(context).add(PasswordChanged(controllerNewPassword2.value.text, controllerOldPassword.value.text));

               }



             }


            },
            child: Text('Save Changes', style: TextStyle(
                color: backGround2
            ),),
          ),
        ),
  );
     }
   );
  }
}
