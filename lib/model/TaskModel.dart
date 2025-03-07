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

// class Task {
//   final String id;
//   final String title;
//   final String description;
//   final String date;
//   final String time;
//   final String type;
//   bool isCompleted;

//   Task({
//     this.id = '0',
//     required this.title,
//     required this.description,
//     required this.date,
//     required this.time,
//     required this.type,
//     this.isCompleted = false,
//   });

//   // Convert JSON to Todo Object
//   factory Task.fromJson(Map<String, dynamic> json) {
//     return Task(
//       id: json['id'],
//       title: json['title'],
//       description: json['description'],
//       date: json['date'],
//       time: json['time'],
//       type: json['type'],
//     );
//   }
// }
