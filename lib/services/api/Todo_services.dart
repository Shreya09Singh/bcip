import 'dart:convert';
import 'package:bciapplication/model/TodoModel.dart';
import 'package:http/http.dart' as http;

class TodoApiService {
  final String baseUrl = "https://bci-backend-qzzf.onrender.com/todo";

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
}
