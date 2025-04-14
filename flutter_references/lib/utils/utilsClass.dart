import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UtilsClass{

  String ip = "192.168.110.202";

  void newToast(String toastText){
    Fluttertoast.showToast(
        msg: toastText,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade600,
        textColor: Colors.white,
        fontSize: 16
    );

  }

}