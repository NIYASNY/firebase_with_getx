import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_with_getx_todo/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

const PrimaryColor = Colors.teal;

final firestore = FirebaseFirestore.instance;
final homecontroller = HomeController.instance;

const labelColors = [
  Colors.red,
  Colors.brown,
  Colors.cyan,
  Colors.green,
  Colors.indigo,
  Colors.orange,
  Colors.yellow,
];
