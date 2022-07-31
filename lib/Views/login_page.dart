import 'package:bookingmobile2/Bloc/login_bloc.dart';
import 'package:bookingmobile2/Bloc/profile_bloc.dart';
import 'package:bookingmobile2/Cubit/auth_cubit.dart';
import 'package:bookingmobile2/Cubit/session_cubit.dart';
import 'package:bookingmobile2/Repos/login_repo.dart';
import 'package:bookingmobile2/Utils/componenti_riutilizzabili.dart';
import 'package:bookingmobile2/Utils/exceptions.dart';
import 'package:bookingmobile2/Views/home_page.dart';
import 'package:bookingmobile2/Cubit/session_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Utils/constants.dart';
import '../Utils/google_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController? emailController = TextEditingController(text: "");
  TextEditingController? passwordController = TextEditingController(text: "");


@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    _passwordVisible = false;

  //Logica di autofill dei campi.
    emailController?.text= "vittorio.digiorgio@hotmail.it";
    passwordController?.text="Digiorgio1";
    BlocProvider.of<LoginBloc>(context).add(LoginUsernameChanged(emailController!.text));
    BlocProvider.of<LoginBloc>(context).add(LoginPasswordChanged(passwordController!.text));

  }

  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double heightSize = MediaQuery.of(context).size.height;
    double widthSize = MediaQuery.of(context).size.width;

    double multiplierBigTitle = 3;
    double multiplierParagraph = 1.8;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFE5E5E5),
      body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            final formStatus = state.formStatus;
            if(formStatus is SubmissionFailed){

              _showSnackBar(context, formStatus.message);
              BlocProvider.of<LoginBloc>(context).emit(LoginState(username: state.username, password:state.password,formStatus: InitialFormStatus()));

            }


          },

          child: BlocListener<SessionCubit, SessionState>(
            listener: (context, sessionstate){
              if (sessionstate is InvalidProfile){
                _showSnackBar(context, sessionstate.message);

                
              }
              
            },
            child: Column(
                children: [
                  Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                            height: MediaQuery.of(context).size.height * 0.70,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Color(0xFF151C3D),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30))),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: heightSize * 0.08,
                                ),
                                Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 18, top: 10),
                                      child: GestureDetector(
                                          onTap: () {
                                          BlocProvider.of<SessionCubit>(context).emit(UnknownSessionState());
                                          },
                                          child: Icon(
                                            Icons.arrow_back_rounded,
                                            color: Colors.white,
                                            size: heightSize * 0.05,
                                          )),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Image(
                                        image: AssetImage(
                                          "assets/images/orbyta.png",
                                        ),
                                        width: heightSize * 0.09,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: heightSize * 0.02,
                                ),

                                _formFields()




                              ],
                            )),
                        _loginButton()
                      ]),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: heightSize * 0.015),
                          child: Text("● O continua con ●",
                              style: TextStyle(
                                  color: Color(0xFF757575),
                                  fontSize: multiplierParagraph * unitHeightValue)),
                        ),
                        GestureDetector(
                          onTap: () {

                            onGoogleSignIn();


                          },
                          child: Container(
                            height: heightSize * 0.09,
                            width: heightSize * 0.09,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16)),
                            child: Align(
                              alignment: Alignment.center,
                              child: Image.asset("assets/images/Google.png"),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text:
                                    "By continuing your confirm that you agree with our ",
                                style: TextStyle(
                                    color: Color(0xFF757575),
                                    fontFamily: "Poppins",
                                    fontSize:
                                        multiplierParagraph * unitHeightValue),
                                children: [
                                  TextSpan(
                                    recognizer: new TapGestureRecognizer()
                                      ..onTap = () => print('Ciao'),
                                    text: "Term and Condition",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Poppins",
                                        fontSize:
                                            multiplierParagraph * unitHeightValue,
                                        fontWeight: FontWeight.w600),
                                  )
                                ]),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
          ),
        )

      );

  }

  Widget _formFields() {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double heightSize = MediaQuery.of(context).size.height;
    double widthSize = MediaQuery.of(context).size.width;

    return BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 18, vertical: 10),
                        child: Text(
                          "Benvenuto!",
                          style: TextStyle(
                              fontSize: multiplierBigTitle *
                                  unitHeightValue,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      );
                    }
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18, right: 65, bottom: 8),
                    child: Text(
                      "Effettua il login con la tua email e password o con il tuo account Gmail per procedere",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: unitHeightValue *
                              multiplierParagraph,
                          color: Colors.white),
                    ),
                  ),
                  Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 13, vertical: 3),
                          child: TextFormField(
                            controller: emailController,

                            textAlignVertical:
                            TextAlignVertical.bottom,
                            validator: (value) => state
                                .isValidEmail
                                ? null
                                : "Formato errato per la mail",
                            onChanged: (value) =>
                              BlocProvider.of<LoginBloc>(context)
                                .add(LoginUsernameChanged(
                                value)),
                            style: TextStyle(
                                color: Colors.white),
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                              FloatingLabelBehavior
                                  .always,
                              alignLabelWithHint: true,
                              filled: true,
                              fillColor: Color(0x1AFFFFFF),
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(
                                      15),
                                  borderSide: BorderSide(
                                      width: 0,
                                      style:
                                      BorderStyle.none)),
                              contentPadding: EdgeInsets.only(
                                  top: heightSize * 0.038,
                                  left: 19,
                                  bottom: heightSize*0.02),
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 33, top: heightSize*0.009),
                            child: Text(
                              "Email",
                              style: TextStyle(
                                  fontSize:
                                  multiplierParagraph *
                                      unitHeightValue,
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xFFF5F5F9)),
                            ))
                      ]),
                  Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 13,
                              right: 13,
                              top: 10,
                              bottom: 0),
                          child: TextFormField(
                            controller: passwordController,
                            textAlignVertical:
                            TextAlignVertical.bottom,
                            validator: (value) => state.isPasswordValid
                                ? null
                                : "Formato password errato",
                            onChanged: (value) => BlocProvider.of<LoginBloc>(context)
                                .add(LoginPasswordChanged(
                                value)),
                            style: TextStyle(
                                color: Colors.white),
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white60,
                                  ),
                                  onPressed: () {
                                    // Update the state i.e. toogle the state of passwordVisible variable
                                    setState(() {
                                      _passwordVisible =
                                      !_passwordVisible;
                                    });
                                  },
                                ),
                                floatingLabelBehavior:
                                FloatingLabelBehavior
                                    .always,
                                alignLabelWithHint: true,
                                filled: true,
                                fillColor: Color(0x1AFFFFFF),
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(
                                        15),
                                    borderSide: BorderSide(
                                        width: 0,
                                        style:
                                        BorderStyle.none)),
                                contentPadding: EdgeInsets.only(
                                    top: heightSize * 0.038,
                                    left: 19,
                                    bottom: heightSize*0.02)








                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 33, top: heightSize*0.02),
                            child: Text(
                              "Password",
                              style: TextStyle(
                                  fontSize: unitHeightValue *
                                      multiplierParagraph,
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xFFF5F5F9)),
                            ))
                      ]),
                  SizedBox(
                    height: heightSize * 0.01,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 13, vertical: 0),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Hai dimenticato la password?",
                        style: TextStyle(
                            fontSize: multiplierParagraph *
                                unitHeightValue,
                            fontWeight: FontWeight.w300,
                            color: Color(0xFFFDCA00)),
                      ),
                    ),
                  )
                ]),
          );
        }
    );
  }

  Widget _loginButton()  {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double heightSize = MediaQuery.of(context).size.height;
    double widthSize = MediaQuery.of(context).size.width;

    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      if (state.formStatus is FormSubmitting){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircularProgressIndicator(color: Colors.white70 , strokeWidth: 2,),
        );
      }

      else{
       return Positioned(
            top: MediaQuery.of(context).size.height * 0.659,
            child: GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                  setState(() {
                    _formKey.currentState!.reset();
                    this.emailController?.text=state.username;
                    this.passwordController?.text= state.password;

                  });



                    BlocProvider.of<LoginBloc>(context).add(LoginSubmitted());



                }

                },
                child: PurpleArrowBox(
                  larghezza: heightSize * 0.09,
                  lunghezza: heightSize * 0.09,
                )));

      }







    });
  }


  void _showSnackBar(BuildContext context ,
      String message){
    final snackBar = SnackBar(content: Text(message),backgroundColor:Colors.redAccent,elevation: 3,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);


  }

  void onGoogleSignIn() async {

   BlocProvider.of<LoginBloc>(context).add(GoogleLogin());

  }


}

