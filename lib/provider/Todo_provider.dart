import 'package:bciapplication/model/TodoModel.dart';
import 'package:bciapplication/services/api/Todo_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoProvider with ChangeNotifier {
  TodoApiService todoapiservices = TodoApiService();

  List<TodoModel> _todoList = [];
  List<TodoModel> get todoList => _todoList;
  bool _isToggle = false;
  bool _isToday = true;
  bool _isCompleted = false;

  bool get istoday => _isToday;
  bool get isToggle => _isToggle;
  bool get isCompleted => _isCompleted;

  Future<void> fetchTodos() async {
    try {
      final todos = await todoapiservices.fetchTodos();
      _todoList = todos;
      print(todos);
      notifyListeners(); // ✅ Update UI
    } catch (e) {
      print("Error fetching todos: $e");
    }
  }

  //create Todo
  Future<bool> addTodo(TodoModel todo) async {
    bool success = await todoapiservices.createTodo(todo);
    if (success) {
      _todoList.add(todo);
      notifyListeners();
      print('save');
    }
    return success;
  }

  List<TodoModel> get completedTask =>
      _todoList.where((todo) => todo.isCompleted!).toList();
  List<TodoModel> get todayTask => _todoList
      .where((todo) => !todo.isCompleted! && isToday(parseDate(todo.time)))
      .toList();

  List<TodoModel> get notCompletedTask =>
      _todoList.where((todo) => !todo.isCompleted!).toList();

  int get completedTaskCount => completedTask.length;
  int get notcompletedTaskCount => notCompletedTask.length;

  List<TodoModel> getTasksByCategory(String category) {
    return _todoList.where((todo) => todo.type == category).toList();
  }

  String _selectedCategory = "University";

  String get selectedCategory => _selectedCategory;

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

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

  void toggleTaskCompletion(TodoModel todo) {
    todo.isCompleted = !todo.isCompleted!;
    notifyListeners();
  }

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
