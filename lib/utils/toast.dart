import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
   //create this function, so that, you needn't to configure toast every time
  void showToastMessage(String message){
     Fluttertoast.showToast(
        msg: message, //message to show toast
        toastLength: Toast.LENGTH_SHORT, //duration for message to show
        gravity: ToastGravity.BOTTOM, 
        timeInSecForIosWeb: 1, //for iOS only
        backgroundColor: Colors.black.withOpacity(.5), 
        textColor: Colors.white, //message text color
        fontSize: 16.0 //message font size
    );
  }
