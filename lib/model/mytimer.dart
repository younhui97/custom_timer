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
  final String imagSrcPath;
  final String name;
  BoxDecoration bd;

  MyTimer({
    required this.imagSrcPath,
    required this.name,
    required this.bd
  });
}