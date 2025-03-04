import 'package:bciapplication/model/TaskModel.dart';
import 'package:bciapplication/provider/taskProvider2.dart';
import 'package:bciapplication/utils/constants.dart';
import 'package:bciapplication/widget/TaskItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowtasksCategory extends StatelessWidget {
  final String category; // Accept category from previous screen

  ShowtasksCategory({required this.category});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider2>(context);

    // Filter tasks by category
    final List<Task> filteredTasks = provider.tasks
        .where((task) => task.category == category) // Filter by category
        .toList();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: textPrimaryColor,
            )),
        centerTitle: true,
        title: Text(
          category,
          style: TextStyle(
              color: brandPrimaryColor,
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ), // Show category name in the title
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: filteredTasks.isEmpty
          ? Center(
              child: Text(
                'No tasks for this category',
                style: TextStyle(color: textSecondaryColor, fontSize: 15),
              ),
            )
          : ListView.builder(
              itemCount: filteredTasks.length,
              itemBuilder: (context, index) {
                final task = filteredTasks[index];
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                    bottom: 20,
                  ),
                  child: TaskItemWidget(
                    title: task.title,
                    displayDate: task.dateTime,
                    timeOfDay: task.timeOfDay,
                    isCompleted: task.isCompleted,
                    onCheckboxChanged: (bool? value) {
                      provider.toggleTaskCompletion(task);
                    },
                    category: task.category,
                    // icon: task.icons!,
                  ),
                );
              },
            ),
    );
  }
}
