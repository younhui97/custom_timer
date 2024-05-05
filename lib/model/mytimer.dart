import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';
import '../ui/colorstyle.dart';

FirebaseDatabase database = FirebaseDatabase.instance;
void readData() {
  final userReference = database.ref().child("timerlist");
  userReference.onValue.listen((DatabaseEvent event) {
    final data = event.snapshot.value;
    print("data $data");
  });
}

class MyTimer {
  String ticon;
  String name;
  bool timerstate;
  List tnamelist;
  List tlengthlist;
  ColorStyleFactory colors;
  int counter;
  late ValueNotifier<int> counterNotifier;
  DateTime? lastTime;

  MyTimer({
    required this.ticon,
    required this.name,
    required this.timerstate,
    required this.tnamelist,
    required this.tlengthlist,
    required this.colors,
    required this.counter,
  }) {
    counterNotifier = ValueNotifier(0);
  }

  void addCount() {
    counterNotifier.value++;
    lastTime = DateTime.now();
  }
  void resetCounter() {
    lastTime = null;
    counterNotifier = ValueNotifier(0);
  }
  void loadCountCheckpoint() {
    int checkpoint = lastTime?.difference(DateTime.now()).inSeconds ?? 0;
    counterNotifier.value += checkpoint.abs();
  }
}