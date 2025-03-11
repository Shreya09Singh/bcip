import 'package:bciapplication/model/TodoModel.dart';
import 'package:bciapplication/services/api/Todo_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class TodoProvider with ChangeNotifier {
  TodoApiService todoapiservices = TodoApiService();
  List<TodoModel> _todotypeList = [];
  List<TodoModel> _todoList = [];
  List<TodoModel> get todoList => _todoList;
  List<TodoModel> get todotypeList => _todotypeList;
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

///////////////////////////////////////////////////
  void toggleTodoState(String id, bool newState) {
    int index = _todotypeList.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todotypeList[index] = TodoModel(
        id: _todotypeList[index].id,
        title: _todotypeList[index].title,
        description: _todotypeList[index].description,
        date: _todotypeList[index].date,
        time: _todotypeList[index].time,
        type: _todotypeList[index].type,
        isCompleted: newState, // ✅ Update state
      );
      notifyListeners(); // ✅ UI rebuilds
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
      _todoList.where((todo) => todo.isCompleted).toList();
  List<TodoModel> get todayTask => _todoList
      .where((todo) => !todo.isCompleted && isToday(parseDate(todo.time)))
      .toList();

  List<TodoModel> get notCompletedTask =>
      _todoList.where((todo) => !todo.isCompleted).toList();

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
    todo.isCompleted = !todo.isCompleted;
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

  bool _isLoading = false;
  String? _error;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchTodostype(String type) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _todotypeList = await TodoApiService.fetchTodosdata(type);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
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
