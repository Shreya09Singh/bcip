import 'package:bciapplication/model/TaskModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskProvider2 with ChangeNotifier {
  final List<Task> _tasks = [];
  bool _isToggle = false;
  bool _isToday = true;
  bool _isCompleted = false;

  bool get istoday => _isToday;
  bool get isToggle => _isToggle;
  bool get isCompleted => _isCompleted;

  List<Task> get tasks => _tasks;
  List<Task> get completedTasks =>
      _tasks.where((task) => task.isCompleted).toList();
  List<Task> get notCompletedTasks =>
      _tasks.where((task) => !task.isCompleted).toList();
  List<Task> get todayTasks => _tasks
      .where((task) => !task.isCompleted && isToday(parseDate(task.dateTime)))
      .toList();

  List<Task> getTasksByCategory(String category) {
    return _tasks.where((task) => task.category == category).toList();
  }

  int get completedTaskCount => _tasks.where((task) => task.isCompleted).length;

  int get incompletedTaskCount =>
      _tasks.where((task) => !task.isCompleted).length;

  String _selectedCategory = "University"; // Default category

  String get selectedCategory => _selectedCategory;

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners(); // Notify UI to rebuild
  }

  // Category to Icon mapping
  // static Map<String, IconData> categoryIcons = {
  //   "University": Icons.school,
  //   "Health": Icons.favorite,
  //   "Music": Icons.music_note,
  //   "Work": Icons.work,
  // };

  void setToday() {
    _isToday = true;
    _isToggle = false;
    _isCompleted = false;
    notifyListeners();
  }

  void setCompleted() {
    _isCompleted = true;
    _isToggle = true;
    _isToday = false;
    notifyListeners();
  }

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void toggleTaskCompletion(Task task) {
    task.isCompleted = !task.isCompleted;
    notifyListeners();
  }

  // ✅ Unified Date Parsing Function
  DateTime parseDate(String dateString) {
    try {
      return DateFormat("dd / MM / yyyy").parse(dateString);
    } catch (e) {
      print("Error parsing date: $e");
      return DateTime.now(); // Return today's date as fallback
    }
  }

  // ✅ Function to Check if Date is Today
  bool isToday(DateTime date) {
    DateTime now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }
}
