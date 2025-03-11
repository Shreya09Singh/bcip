import 'dart:convert';
import 'package:bciapplication/model/TodoModel.dart';
import 'package:http/http.dart' as http;

class TodoApiService {
  static final String baseUrl = "https://bci-backend-qzzf.onrender.com/todo";

  static Future<bool> changeTodoState(String todoId, bool isActive) async {
    final url =
        Uri.parse("$baseUrl/changeTodoState?todoId=$todoId&isActive=$isActive");

    try {
      final response = await http.post(url);

      if (response.statusCode == 200) {
        return true; // Successfully updated
      } else {
        return false; // Failed update
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  // Create Todo
  Future<bool> createTodo(TodoModel todoData) async {
    final url = Uri.parse("$baseUrl/createTodo");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(todoData),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        print('save');
        return true;
      } else {
        throw Exception("Failed to create todo: ${response.body}");
      }
    } catch (error) {
      print("Error creating todo: $error");
      return false;
    }
  }

  Future<List<TodoModel>> fetchTodos() async {
    final url = Uri.parse("$baseUrl/getTodos");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);

        // ✅ Correctly mapping JSON to List<TodoModel>
        return jsonResponse.map((json) => TodoModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to fetch todos");
      }
    } catch (error) {
      print("Error fetching todos: $error");
      return [];
    }
  }

  static Future<List<TodoModel>> fetchTodosdata(String type) async {
    final url =
        Uri.parse("https://bci-backend-qzzf.onrender.com/todo/getTodos/$type");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        print(jsonData);
        return jsonData.map((data) => TodoModel.fromJson(data)).toList();
      } else {
        throw Exception("Failed to load TODOs");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
