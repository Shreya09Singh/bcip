import 'package:bciapplication/Screens/note_module/Calender_screen.dart';
import 'package:bciapplication/Screens/note_module/CatagoryScreen.dart';
import 'package:bciapplication/model/TodoModel.dart';
import 'package:bciapplication/provider/Todo_provider.dart';
//

import 'package:bciapplication/provider/taskProvider2.dart';

import 'package:bciapplication/Screens/registration/basic_information_screen.dart';

import 'package:bciapplication/provider/connection_provider.dart';
import 'package:bciapplication/utils/constants.dart';

import 'package:bciapplication/widget/custom_button.dart';
import 'package:bciapplication/widget/custom_date_picker.dart';
import 'package:bciapplication/widget/custom_time_picker.dart';
import 'package:bciapplication/widget/dropdown_widget.dart';
import 'package:bciapplication/widget/onboarding_button.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  final TextEditingController dateeController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController catagoryController = TextEditingController();

  final TextEditingController timeController = TextEditingController();
  String? selectedcatagory;
  bool isaddingTask = false;
  IconData? selectedicon;

  final List<String> categories = ["University", "Health", "Music", "Work"];
  Widget build(BuildContext context) {
    final provider = Provider.of<ConnectionProvider>(context);
    // final taskProvider = Provider.of<TaskProvider2>(context);
    final todoprovider = Provider.of<TodoProvider>(context);

    List<IconData> iconData = [
      Icons.school,
      Icons.health_and_safety,
      Icons.queue_music,
      Icons.work
    ];

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          elevation: 0,
          title: Row(
            children: [
              Text(
                'headset Status : ',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                provider.connectionStatus,
                style: TextStyle(
                    color: provider.buttonColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                provider.statusIcon,
                color: provider.iconColor,
                size: 18,
              ),
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  // Control Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton2(
                        text: 'CONNECTED',
                        backgroundColor: provider.connectionStatus ==
                                'connected'
                            ? provider.buttonColor
                            : backgroundWhiteColor, // Highlight only when active
                        textColor: provider.buttonColor == Colors.green
                            ? textPrimaryColor
                            : textcolor,
                        onPressed: () {
                          provider.setConnectionStatus(
                              'connected'); // Directly set to 'connected'
                        },
                      ),
                      CustomButton2(
                        text: 'PAUSE',
                        backgroundColor: provider.connectionStatus == 'pause'
                            ? provider.buttonColor
                            : backgroundWhiteColor, // Highlight only when active
                        textColor: provider.buttonColor == Colors.blue
                            ? textPrimaryColor
                            : textcolor,
                        onPressed: () {
                          provider.setConnectionStatus(
                              'pause'); // Directly set to 'pause'
                        },
                      ),
                      CustomButton2(
                        text: 'STOP',
                        backgroundColor: provider.connectionStatus == 'stop'
                            ? provider.buttonColor
                            : backgroundWhiteColor, // Highlight only when active
                        textColor: provider.buttonColor == Colors.red
                            ? textPrimaryColor
                            : textcolor,
                        onPressed: () {
                          provider.setConnectionStatus(
                              'stop'); // Directly set to 'stop'
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'To Do',
                    style: TextStyle(
                        fontSize: 25,
                        color: brandPrimaryColor,
                        fontWeight: FontWeight.bold),
                  ),

                  Stack(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: SizedBox(
                        height: 320, // Adjust height
                        child: GridView.builder(
                          itemCount: categories.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: GestureDetector(
                                onTap: () {
                                  print("here is cat");
                                  print(catagoryController.text);

                                  todoprovider
                                      .fetchTodostype(categories[index]);
                                  // taskProvider
                                  //     .selectCategory(categories[index]);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ShowtasksCategory(
                                                  category:
                                                      categories[index])));
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFF334155),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Color(0xFF334155),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          size: 35,
                                          iconData[index],
                                          color: backgroundLightBlueColor,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          categories[index],
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: textPrimaryColor,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Positioned(
                        left: 0,
                        right: 30,
                        bottom: 5,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: FloatingActionButton(
                            backgroundColor: brandPrimaryColor,
                            shape: CircleBorder(
                              side: BorderSide(
                                  color: backgroundBlackColor, width: 4),
                            ),
                            onPressed: () {
                              setState(() {
                                isaddingTask = !isaddingTask;
                              });
                            },
                            child: Icon(
                              Icons.add,
                              size: 30,
                              color: textPrimaryColor,
                            ),
                          ),
                        ))
                  ]),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: SizedBox(
                      width: 230,
                      child: OnboardingButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CalendarScreen(),
                                ));
                          },
                          buttonText: 'View Calender'),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height:
                          isaddingTask ? 310 : 0, // Control height dynamically
                      child: isaddingTask
                          ? SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "New Task",
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: brandPrimaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 12),
                                  SizedBox(
                                    height: 52,
                                    child: buildTextField(
                                      txtcontroller: titleController,
                                      isicon: false,
                                      hintText: 'Enter Task title',
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  SizedBox(
                                    height: 52,
                                    child: CustomDropdown(
                                        selectedValue: selectedcatagory,
                                        categories: categories,
                                        onChanged: (String? newval) {
                                          setState(() {
                                            selectedcatagory = newval;
                                          });
                                        },
                                        controller: catagoryController),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              'Date',
                                              style: TextStyle(
                                                  color: textPrimaryColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            CustomDatePicker(
                                                controller: dateeController),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                          width:
                                              15), // Add spacing between Date and Time picker
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              'Time',
                                              style: TextStyle(
                                                  color: textPrimaryColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            CustomTimePicker(
                                                controller: timeController),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 50),
                                  Align(
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                        width: 300,
                                        child: OnboardingButton(
                                            onPressed: () {
                                              if (titleController.text.isNotEmpty ||
                                                  dateeController
                                                      .text.isNotEmpty ||
                                                  timeController
                                                      .text.isNotEmpty ||
                                                  catagoryController
                                                      .text.isNotEmpty) {
                                                TodoModel newtodo = TodoModel(
                                                    isCompleted: todoprovider
                                                        .isCompleted,
                                                    title: titleController.text,
                                                    date: dateeController.text,
                                                    time: timeController.text,
                                                    type: catagoryController
                                                        .text);
                                                todoprovider.addTodo(newtodo);

                                                titleController.clear();
                                                dateeController.clear();
                                                timeController.clear();
                                                catagoryController.clear();
                                              }
                                            },
                                            buttonText: 'Create Task')),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ),
                  ),
                ]))));
  }
}
