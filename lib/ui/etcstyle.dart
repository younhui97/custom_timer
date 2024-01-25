import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'colorstyle.dart';

class EtcStyles {
  BoxDecoration offBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(new Radius.circular(50)),
    border: const GradientBoxBorder(
      gradient:
      LinearGradient(colors: [ColorStyles.timeroff, ColorStyles.timeroff ]),
      width: 3,
    )
  );
  BoxDecoration onBoxDecoration = BoxDecoration(
      borderRadius: BorderRadius.all(new Radius.circular(50)),
      border: const GradientBoxBorder(
        gradient:
        LinearGradient(colors: [ColorStyles.timeron, ColorStyles.timeron ]),
        width: 3,
      )
  );
}