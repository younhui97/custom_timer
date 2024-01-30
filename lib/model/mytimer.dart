import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';

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
  BoxDecoration bd;
  List tnamelist;
  List tlengthlist;

  MyTimer({
    required this.ticon,
    required this.name,
    required this.ison,
    required this.bd,
    required this.tnamelist,
    required this.tlengthlist
  });
}