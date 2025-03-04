import 'package:flutter/material.dart';

class Task {
  String title;
  String category;
  String dateTime;
  String timeOfDay;

  bool isCompleted;

  Task(
      {required this.title,
      required this.category,
      required this.dateTime,
      required this.timeOfDay,
      this.isCompleted = false});
}
