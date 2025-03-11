import 'package:bciapplication/model/TodoModel.dart';
import 'package:bciapplication/provider/Todo_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bciapplication/Screens/note_module/Calender_screen.dart';

import 'package:bciapplication/Screens/note_module/todo_List_screen.dart';
import 'package:bciapplication/utils/constants.dart';
import 'package:bciapplication/widget/TaskItemCard2.dart';

import 'package:bciapplication/widget/onboarding_button.dart';

class ShowtaskScreen extends StatelessWidget {
  const ShowtaskScreen({
    Key? key,
    required this.filter,
  }) : super(key: key);

  final bool istoggle = false;
  final String filter;

  @override
  Widget build(BuildContext context) {
    final todoprovider = Provider.of<TodoProvider>(context, listen: false);

    List<TodoModel> tasks = [];
    if (filter == "All") {
      tasks = todoprovider.todoList;
    } else if (filter == "Completed") {
      tasks = todoprovider.completedTask;
    } else if (filter == "Ongoing") {
      tasks = todoprovider.notCompletedTask;
    }

    return Scaffold(
      backgroundColor: backgroundBlackColor,
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];

                  return TaskItemWidget2(
                      title: task.title,
                      displayDate: task.date,
                      timeOfDay: task.time,
                      isCompleted: task.isCompleted,
                      category: task.type,
                      // icon: task.icons!,
                      ongoing: !task.isCompleted);
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OnboardingButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TodoListScreen()));
                  },
                  buttonText: 'todo'),
              OnboardingButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CalendarScreen()));
                  },
                  buttonText: 'calender'),
            ],
          )
        ],
      ),
    );
  }
}
