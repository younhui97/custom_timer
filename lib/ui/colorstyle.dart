import 'dart:math';

import 'package:flutter/material.dart';

class ColorStyleFactory {
  final Color main;
  final Color border;

  const ColorStyleFactory({required this.main, required this.border });
}

class ColorStyles {
  static List<ColorStyleFactory> randomcolorlist = const [
    ColorStyleFactory(main: lightyellow, border: denseyellow),
    ColorStyleFactory(main: lightpink, border: densepink),
    ColorStyleFactory(main: lightblue, border: denseblue),
    ColorStyleFactory(main: lightpurple, border: densepurple),
    ColorStyleFactory(main: lightorange, border: denseorange)
  ];

  static ColorStyleFactory randf = randomcolorlist[Random().nextInt(5)];
  static ColorStyleFactory get randomFromMain => randomcolorlist[Random().nextInt(5)];

  static const Color lighterpink = Color(0xfff5dddd);
  static const Color lightyellow = Color(0xfffdf1df);
  static const Color lightpink = Color(0xffe6b6b6);
  static const Color lightlime = Color(0xffcce48e);
  static const Color lightblue = Color(0xffb5e6f8);
  static const Color lightpurple = Color(0xffb7b8e7);
  static const Color lightorange = Color(0xffdea78f);
  static const Color denseyellow = Color(0xffe3a33d);
  static const Color densepink = Color(0xff803a3a);
  static const Color denselime = Color(0xff607536);
  static const Color denseblue = Color(0xff325b6b);
  static const Color densepurple = Color(0xff27296e);
  static const Color denseorange = Color(0xff753a23);


  static const Color darkGray = Color(0xff5d5867);
  static const Color circle = Color(0xFF26426e);
  static const Color timeroff = Color(0xFF898989);
  static const Color timeron = Color(0xff23406d);
  static const Color timerback = Color(0xffC8C0F2);
  static const Color addtimerback = Color(0xcdc8d7ea);
  static const Color timerfront = Color(0xff3A20A4);
  static const Color linebarback = Color(0xffd9d9d9);
  static const Color addtimerborder = Color(0xfff2f1f3);
  static const Color backgrad = Color(0xffeae5ff);
  static const Color newtimer = Color(0xffA69AE6);
  static const Color greytext = Color(0xff3E3E4B);

  // 3E3E4B
}