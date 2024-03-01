import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'colorstyle.dart';

class EtcStyles {
  BoxDecoration offBoxDecoration = BoxDecoration(
      color: ColorStyles.randg.main,
      borderRadius: BorderRadius.circular(50),
      border: Border.all(color: ColorStyles.randg.main, width: 3));

  BoxDecoration onBoxDecoration = BoxDecoration(
      color: ColorStyles.randg.main,
      borderRadius: BorderRadius.circular(50),
      border: Border.all(color: ColorStyles.randg.border, width: 3));
}
