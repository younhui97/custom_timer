import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'colorstyle.dart';

class EtcStyles {
  BoxDecoration offBoxDecoration = BoxDecoration(
      color: ColorStyles.randomFromMain.main,
      borderRadius: BorderRadius.circular(50),);

  BoxDecoration onBoxDecoration = BoxDecoration(
      color: ColorStyles.randf.main,
      borderRadius: BorderRadius.circular(50),
      border: Border.all(color: ColorStyles.randf.border, width: 3));
}
