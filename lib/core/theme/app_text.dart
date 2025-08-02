import 'package:flutter/material.dart';

class AppText {
  static const String fontFamily = 'IBM';

  static TextStyle get header => TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    fontFamily: fontFamily,
  );

  static TextStyle get subtitle => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    fontFamily: fontFamily,
  );

  static TextStyle get body => TextStyle(
    fontSize: 19,
    fontWeight: FontWeight.w400,
    color: Colors.black87,
    fontFamily: fontFamily,
  );
}
