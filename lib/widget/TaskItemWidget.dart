import 'package:bciapplication/utils/category_icons.dart';
import 'package:bciapplication/utils/constants.dart';
import 'package:flutter/material.dart';

class TaskItemWidget extends StatelessWidget {
  final String title;
  final String displayDate;
  final String timeOfDay;
  final bool isCompleted;
  final ValueChanged<bool?>? onCheckboxChanged;
  final String category;

  const TaskItemWidget({
    Key? key,
    required this.title,
    required this.displayDate,
    required this.timeOfDay,
    required this.isCompleted,
    this.onCheckboxChanged,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth * 0.9; // 90% of screen width
    double fontSize = screenWidth * 0.045; // Scales text size based on width

    return Container(
      height: 80,
      width: containerWidth,
      padding:
          EdgeInsets.symmetric(horizontal: screenWidth * 0.03), // 3% padding
      decoration: BoxDecoration(
        color: greybackgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Checkbox(
            shape: CircleBorder(),
            side: BorderSide(color: backgroundLightBlueColor, width: 1.5),
            fillColor: WidgetStateProperty.resolveWith<Color>((states) {
              if (states.contains(WidgetState.selected)) {
                return brandPrimaryColor;
              }
              return Colors.transparent;
            }),
            checkColor: textPrimaryColor,
            value: isCompleted,
            onChanged: onCheckboxChanged,
          ),
          SizedBox(width: screenWidth * 0.02), // Spacing
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: fontSize,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "$displayDate at $timeOfDay",
                  style: TextStyle(
                    fontSize: fontSize * 0.7, // Smaller subtitle
                    color: textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: screenWidth * 0.02),
          Container(
            height: screenWidth * 0.12,
            width: screenWidth * 0.24,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  categoryIcons[category] ?? Icons.category,
                  color: textPrimaryColor,
                  size: screenWidth * 0.05,
                ),
                SizedBox(width: 4),
                Flexible(
                  child: Text(
                    category,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: fontSize * 0.7,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
