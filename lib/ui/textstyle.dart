import 'package:custom_timer/ui/colorstyle.dart';
import 'package:flutter/material.dart';

class TextStyles {
  // static const timerTextStyle = TextStyle(height: 2, fontSize: 10,fontWeight: FontWeight.bold,letterSpacing: 0.1);
  static const timerNameTextStyle = TextStyle(height: 2, fontSize: 27,fontWeight: FontWeight.w600,letterSpacing: 0.1);
  static const timerTextStyle = TextStyle(height: 2, fontSize: 35,fontWeight: FontWeight.w600,letterSpacing: 0.1, color: ColorStyles.timeroff);
  static const maintimerStyle = TextStyle(height: 2, fontSize: 35,fontWeight: FontWeight.w600,letterSpacing: 0.1, color: ColorStyles.greytext);
  static const maintimernameStyle = TextStyle(height: 2, fontSize: 20,fontWeight: FontWeight.w600,letterSpacing: 0.1, color: ColorStyles.greytext);
}