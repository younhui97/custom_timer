import 'package:flutter/material.dart';
import 'etcstyle.dart';

class TimeStore extends ChangeNotifier{
  String str = "Store입니다.";
  List<String> arr = ["Store1", "Store2"];

  List<String> imagePaths = [
    'assets/icons/book.svg',
    'assets/icons/fitness.svg',
    'assets/icons/yoga.svg',
    'assets/icons/study.svg',
    'assets/icons/cross.svg',
    // Add more image paths as needed
  ];

  List<String> timerNames = [
    'book',
    'swim',
    'yoga',
    'books',
    'crossfit'
  ];
  // List<String> timerNames = [
  //   'Toeic',
  //   'Workout-abs',
  //   'Yoga',
  //   'NewsStudy',
  //   'Crossfit'
  // ];
  List<BoxDecoration> timerStates = [
    EtcStyles().offBoxDecoration,
    EtcStyles().offBoxDecoration,
    EtcStyles().offBoxDecoration,
    EtcStyles().offBoxDecoration,
    EtcStyles().offBoxDecoration
  ];
  int index=1;



}