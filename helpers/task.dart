import 'package:flutter/material.dart';

class Task {
  String title;
  bool isComplete = false;
  DateTime day;
  TimeOfDay time;

  Task({required this.title, required this.day, required this.time});

  String toString() => this.title;
}