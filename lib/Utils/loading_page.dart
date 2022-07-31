import 'package:bookingmobile2/Utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGround,
      body: Center(
        child:  CircularProgressIndicator(color: Colors.white70 , strokeWidth: 2,),
      ),
    );
  }
}
