import 'dart:math';

import 'package:flutter/material.dart';

class ColorStyleFactory {
  final Color main;
  final Color border;

  const ColorStyleFactory({required this.main, required this.border });
}

class ColorStyles {
  // static ColorStyleFactory randf = randomcolorlist[Random().nextInt(5)];
  // static ColorStyleFactory get randg => randomcolorlist[Random().nextInt(5)];

  static const Color lighterpink = Color(0xfff5dddd);
  static const Color lightyellow = Color(0xfffdf1df);
  static const Color lightyellow2 = Color(0xfffff0be);
  static const Color lightpink = Color(0xffe6b6c4);
  static const Color lightlime = Color(0xffcce48e);
  static const Color lightblue = Color(0xffb5e6f8);
  static const Color lightpurple = Color(0xffb7b8e7);
  static const Color lightorange = Color(0xffeaaca6);
  static const Color denseyellow = Color(0xffe3a33d);
  static const Color densepink = Color(0xff803a4f);
  static const Color denselime = Color(0xff607536);
  static const Color denseblue = Color(0xff325b6b);
  static const Color densepurple = Color(0xff27296e);
  static const Color denseorange = Color(0xff8f2a01);

  static const Color g2 = Color(0xffe89191);
  static const Color g1 = Color(0xffe3b7b7);



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

  static List<ColorStyleFactory> randomcolorlist = const [
    ColorStyleFactory(main: mb, border: bb),
    ColorStyleFactory(main: mp, border: bp),
    ColorStyleFactory(main: my, border: by),
    ColorStyleFactory(main: mr, border: br),
    ColorStyleFactory(main: mpi, border: bpi),
    ColorStyleFactory(main: mi, border: bi),
    ColorStyleFactory(main: mg, border: bg),
    ColorStyleFactory(main: mm, border: bm),
  ];
  static const Color my = Color(0xffffe9b9);
  static const Color by = Color(0xffFFC547);
  static const Color mr = Color(0xffFFCAB9);
  static const Color br = Color(0xffF88B67);
  static const Color mg = Color(0xffD2EBB1);
  static const Color bg = Color(0xffA8D174);
  static const Color mm = Color(0xffB7E6E0);
  static const Color bm = Color(0xff47DAC7);
  static const Color mb = Color(0xffB9EAFF);
  static const Color bb = Color(0xff47D3FF);
  static const Color mi = Color(0xffBED0F3);
  static const Color bi = Color(0xff5078C5);
  static const Color mp = Color(0xffD4CDFF);
  static const Color bp = Color(0xff7763B2);
  static const Color mpi = Color(0xffF1C2E7);
  static const Color bpi = Color(0xff812F6F);

  // 3E3E4B
}
