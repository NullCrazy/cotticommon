// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter/material.dart';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  static Future<bool?> show(String msgStr) {
    return Fluttertoast.showToast(
        msg: msgStr,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color(0xff4B4B4B),
        textColor: Colors.white,
        fontSize: 14.sp);
  }
}
