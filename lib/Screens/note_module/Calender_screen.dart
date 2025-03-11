import 'package:bciapplication/Screens/note_module/doTaskwork.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:bciapplication/provider/Todo_provider.dart';
import 'package:bciapplication/utils/constants.dart';
import 'package:bciapplication/widget/FormatedDateWidget.dart';
import 'package:bciapplication/widget/TaskItemWidget.dart';

class CalendarScreen extends StatefulWidget {
  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime selectedDate = DateTime.now();
  CalendarFormat calendarFormat = CalendarFormat.week;

  @override
  void initState() {
    super.initState();
    Provider.of<TodoProvider>(context, listen: false).fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    final todoprovider = Provider.of<TodoProvider>(context);
    final notes = todoprovider.isToggle
        ? todoprovider.completedTask
        : todoprovider.todayTask;

    // Get screen width and height
    final size = MediaQuery.of(context).size;
    final double screenWidth = size.width;
    final double screenHeight = size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.12,
        backgroundColor: Colors.black,
        title: Text(
          "Calendar",
          style: GoogleFonts.poppins(
            color: Colors.blue,
            fontSize: screenWidth * 0.08,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: const Color(0xFF334155),
            child: TableCalendar(
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekendStyle:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                weekdayStyle: TextStyle(color: textPrimaryColor),
              ),
              focusedDay: selectedDate,
              firstDay: DateTime(2020),
              lastDay: DateTime(2030),
              calendarFormat: calendarFormat,
              headerStyle: const HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
                titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
                leftChevronIcon: Icon(Icons.arrow_left, color: Colors.white),
                rightChevronIcon: Icon(Icons.arrow_right, color: Colors.white),
              ),
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: brandPrimaryColor,
                  shape: BoxShape.circle,
                ),
                defaultTextStyle: TextStyle(color: Colors.white, fontSize: 18),
                weekendTextStyle: TextStyle(color: Colors.red, fontSize: 18),
              ),
              selectedDayPredicate: (day) => isSameDay(selectedDate, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  selectedDate = selectedDay;
                });
              },
            ),
          ),

          SizedBox(height: screenHeight * 0.03),

          // Today & Completed Buttons
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomElevatedButton(
                  buttonText: 'Today',
                  onPressed: todoprovider.setToday,
                  txtColor: todoprovider.istoday ? textPrimaryColor : textcolor,
                  backgroundColor: todoprovider.istoday
                      ? brandPrimaryColor
                      : textPrimaryColor,
                ),
                CustomElevatedButton(
                  buttonText: 'Completed',
                  onPressed: todoprovider.setCompleted,
                  txtColor:
                      todoprovider.isCompleted ? textPrimaryColor : textcolor,
                  backgroundColor: todoprovider.isCompleted
                      ? brandPrimaryColor
                      : textPrimaryColor,
                ),
              ],
            ),
          ),

          SizedBox(height: screenHeight * 0.03),

          Expanded(
            child: notes.isEmpty
                ? const Center(
                    child: Text(
                      "No Tasks Available",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      final task = notes[index];
                      final date = Formateddatewidget.formatedDate(task.date);

                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.07,
                          vertical: screenHeight * 0.01,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StopwatchScreen()),
                            );
                          },
                          child: TaskItemWidget(
                            title: task.title,
                            displayDate: date,
                            timeOfDay: task.time,
                            isCompleted: task.isCompleted,
                            onCheckboxChanged: (bool? value) {
                              todoprovider.toggleTaskCompletion(task);
                            },
                            category: task.type,
                          ),
                        ),
                      );
                    },
                  ),
          ),
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
    this.backgroundColor = brandPrimaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 50,
      width: screenWidth * 0.3,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        ),
        onPressed: onPressed,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            buttonText,
            style: TextStyle(
              color: txtColor,
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
