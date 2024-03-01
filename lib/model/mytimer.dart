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
  bool ison;
  List tnamelist;
  List tlengthlist;
  ColorStyleFactory colors;

  MyTimer({
    required this.ticon,
    required this.name,
    required this.ison,
    required this.tnamelist,
    required this.tlengthlist,
    required this.colors
  });
}