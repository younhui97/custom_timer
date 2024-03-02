import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'colorstyle.dart';

class EtcStyles {
  BoxDecoration offBoxDecoration = BoxDecoration(
      color: Colors.yellow,
      borderRadius: BorderRadius.circular(50),
      border: Border.all(color: Colors.yellow, width: 3));

  BoxDecoration onBoxDecoration = BoxDecoration(
      color: Colors.yellow,
      borderRadius: BorderRadius.circular(50),
      border: Border.all(color: Colors.red, width: 3));
}
