import 'package:custom_timer/ui/colorstyle.dart';
import 'package:flutter/material.dart';

class TextStyles {
  // static const timerTextStyle = TextStyle(height: 2, fontSize: 10,fontWeight: FontWeight.bold,letterSpacing: 0.1);
  static const timerNameTextStyle = TextStyle(height: 2, fontSize: 23,fontWeight: FontWeight.w600,letterSpacing: 0.1);
  static const timerTextStyle = TextStyle(height: 2, fontSize: 35,fontWeight: FontWeight.w600,letterSpacing: 0.1, color: ColorStyles.timeroff);
  static const maintimerStyle = TextStyle(height: 2, fontSize: 22,fontWeight: FontWeight.w600,letterSpacing: 0.1, color: ColorStyles.greytext);
  static const leftStyle = TextStyle(height: 2, fontSize: 18,fontWeight: FontWeight.w600,letterSpacing: 0.1, color: ColorStyles.greytext);
  static const maintimernameStyle = TextStyle(height: 2, fontSize: 20,fontWeight: FontWeight.w600,letterSpacing: 0.1, color: ColorStyles.greytext);


  static const maxmaintimerStyle = TextStyle(height: 2, fontSize: 30,fontWeight: FontWeight.w600,letterSpacing: 0.1, color: ColorStyles.greytext);
  static const maxundertimerStyle = TextStyle(height: 2, fontSize: 22,fontWeight: FontWeight.w600,letterSpacing: 0.1, color: ColorStyles.greyback2);
}