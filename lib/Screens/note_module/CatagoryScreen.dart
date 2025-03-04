import 'package:bciapplication/provider/taskProvider2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryTasksScreen extends StatelessWidget {
  final String category;
  CategoryTasksScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    print("here is category=== $category");
    final taskProvider = Provider.of<TaskProvider2>(context);
    final categoryTasks = taskProvider.getTasksByCategory(category);

    return Scaffold(
      appBar: AppBar(title: Text("$category Task5")),
      body: categoryTasks.isEmpty
          ? Center(child: Text("No tasks available"))
          : ListView.builder(
              itemCount: categoryTasks.length,
              itemBuilder: (context, index) {
                final task = categoryTasks[index];
                return ListTile(
                  title: Text(task.title),
                  subtitle: Text(task.dateTime),
                  trailing: Checkbox(
                    value: task.isCompleted,
                    onChanged: (bool? value) {
                      taskProvider.toggleTaskCompletion(task);
                    },
                  ),
                );
              },
            ),
    );
  }
}
