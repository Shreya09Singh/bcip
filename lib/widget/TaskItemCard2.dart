// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bciapplication/utils/category_icons.dart';
import 'package:flutter/material.dart';
import 'package:bciapplication/utils/constants.dart';

class TaskItemWidget2 extends StatelessWidget {
  final String title;
  final String displayDate;
  final String timeOfDay;
  final bool isCompleted;
  final ValueChanged<bool?>? onCheckboxChanged;
  final String category;
  final bool ongoing;

  const TaskItemWidget2({
    Key? key,
    required this.title,
    required this.displayDate,
    required this.timeOfDay,
    required this.isCompleted,
    this.onCheckboxChanged,
    required this.category,
    required this.ongoing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.08, // 8% of screen width
        vertical: screenHeight * 0.015, // 1.5% of screen height
      ),
      child: Container(
        height: screenHeight * 0.1, // 10% of screen height
        width: screenWidth * 0.85, // 85% of screen width
        decoration: BoxDecoration(
          color: greybackgroundColor,
          borderRadius: BorderRadius.circular(
              screenWidth * 0.02), // Adaptive border radius
        ),
        child: ListTile(
          title: Text(
            title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: screenWidth * 0.045, // Scalable font size
              color: Colors.white,
            ),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                displayDate,
                style: TextStyle(
                  fontSize: screenWidth * 0.035, // Responsive text
                  color: textSecondaryColor,
                ),
              ),
              Container(
                height: screenHeight * 0.04, // Scalable height
                width: screenWidth * 0.2, // Scalable width
                decoration: BoxDecoration(
                  color: brandPrimaryColor,
                  borderRadius: BorderRadius.circular(screenWidth * 0.02),
                ),
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      categoryIcons[category] ?? Icons.category,
                      color: textPrimaryColor,
                      size: screenWidth * 0.05, // Scalable icon size
                    ),
                    SizedBox(width: screenWidth * 0.015),
                    Flexible(
                      child: Text(
                        category,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: screenWidth * 0.03,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          trailing: Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.04),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  ongoing ? Icons.sync_alt : Icons.check_circle_outline,
                  size: screenWidth * 0.07,
                  color: ongoing ? brandPrimaryColor : Colors.lightGreen,
                ),
                Text(
                  ongoing ? 'Ongoing' : 'Completed',
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: textSecondaryColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
