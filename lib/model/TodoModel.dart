import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class TodoModel {
  static const Uuid uuid = Uuid();

  final String id;
  final String title;
  final String description;
  final String date;
  final String time;
  final String type;
  bool? isCompleted;
  TodoModel({
    String? id,
    required this.title,
    this.description = '',
    required this.date,
    required this.time,
    required this.type,
    this.isCompleted = false,
  }) : id = id ?? uuid.v4();

  // Convert JSON to Todo object
  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      date: json["date"] ?? DateFormat("dd / MM / yyyy").format(DateTime.now()),
      time: json["time"] ?? "",
      type: json["type"] ?? "",
    );
  }

  // Convert Todo object to JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "date": date,
      "time": time,
      "type": type,
    };
  }
}
