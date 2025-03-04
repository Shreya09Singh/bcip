import 'package:bciapplication/provider/taskProvider2.dart';
import 'package:bciapplication/utils/constants.dart';
import 'package:bciapplication/widget/FormatedDateWidget.dart';
import 'package:bciapplication/widget/TaskItemWidget.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:table_calendar/table_calendar.dart';

// Function to get the next 10 days dynamically

class CalendarScreen extends StatefulWidget {
  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    CalendarFormat calendarFormat = CalendarFormat.week; // Horizontal Scroll
    final taskProvider = Provider.of<TaskProvider2>(context);
    final notes = taskProvider.isToggle
        ? taskProvider.completedTasks
        : taskProvider.todayTasks;
    print("Notes: $notes");

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Colors.black,
        title: Text("Calendar",
            style: GoogleFonts.poppins(
                color: Colors.blue, fontSize: 30, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Color(0xFF334155),
            child: TableCalendar(
              daysOfWeekStyle: DaysOfWeekStyle(
                  weekendStyle:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  weekdayStyle: TextStyle(color: textPrimaryColor)),
              focusedDay: selectedDate,
              firstDay: DateTime(2020),
              lastDay: DateTime(2030),
              calendarFormat: calendarFormat,
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false, // Hide toggle
                titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
                leftChevronIcon: Icon(Icons.arrow_left, color: Colors.white),
                rightChevronIcon: Icon(Icons.arrow_right, color: Colors.white),
              ),
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: brandPrimaryColor,
                  shape: BoxShape.circle,
                ),
                defaultTextStyle: TextStyle(color: Colors.white, fontSize: 20),
                weekendTextStyle: TextStyle(color: Colors.red, fontSize: 20),
              ),
              selectedDayPredicate: (day) {
                return isSameDay(selectedDate, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  selectedDate = selectedDay;
                });
              },
            ),
          ),

          SizedBox(height: 30),

          // Today & Completed Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomElevatedButton(
                buttonText: 'Today',
                onPressed: () {
                  taskProvider.setToday();
                },
                txtColor: taskProvider.istoday ? textPrimaryColor : textcolor,
                backgroundColor:
                    taskProvider.istoday ? brandPrimaryColor : textPrimaryColor,
              ),
              CustomElevatedButton(
                buttonText: 'Completed',
                onPressed: () {
                  taskProvider.setCompleted();
                },
                txtColor:
                    taskProvider.isCompleted ? textPrimaryColor : textcolor,
                backgroundColor: taskProvider.isCompleted
                    ? brandPrimaryColor
                    : textPrimaryColor,
              ),
            ],
          ),

          SizedBox(height: 35),

          Expanded(
            child: notes.isEmpty
                ? Center(
                    child: Text(
                      "No Tasks Available",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    // ✅ Ensure horizontal scrolling works
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      final task = notes[index];
                      final date =
                          Formateddatewidget.formatedDate(task.dateTime);

                      return Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, bottom: 10),
                          child: TaskItemWidget(
                            title: task.title,
                            displayDate: date,
                            timeOfDay: task.timeOfDay,
                            isCompleted: task.isCompleted,
                            onCheckboxChanged: (bool? value) {
                              taskProvider.toggleTaskCompletion(
                                  task); // No need for setState()
                            },
                            category: task.category,
                            // icon: task.icons!,
                          ));
                    },
                  ),
          ),

          // Task List
        ],
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color txtColor;

  const CustomElevatedButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.txtColor = textcolor,
    this.backgroundColor = brandPrimaryColor, // Default button color
    // Default text color
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 120,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor, // Button color
          // Text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Rounded corners
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 12.0,
          ),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(
            color: txtColor,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
