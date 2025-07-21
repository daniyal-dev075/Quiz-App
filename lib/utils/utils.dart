import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiz_app/res/app_colors.dart';

class Utils {
  void toastMessage(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.orange.shade500,
        timeInSecForIosWeb: 2,
        fontSize: 16.sp
    );
  }
}