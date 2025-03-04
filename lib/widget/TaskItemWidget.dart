import 'package:bciapplication/utils/constants.dart';
import 'package:flutter/material.dart';

class TaskItemWidget extends StatelessWidget {
  final String title;
  final String displayDate;
  final String timeOfDay;
  final bool isCompleted;
  final ValueChanged<bool?>? onCheckboxChanged;
  final String category;
  // final IconData icon;

  const TaskItemWidget({
    Key? key,
    required this.title,
    required this.displayDate,
    required this.timeOfDay,
    required this.isCompleted,
    this.onCheckboxChanged,
    required this.category,
    // required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 300,
      decoration: BoxDecoration(
        color: greybackgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: ListTile(
        leading: SizedBox(
            width: 15,
            child: Checkbox(
              shape: CircleBorder(), // Optional: Make it square
              side: BorderSide(
                  color: backgroundLightBlueColor,
                  width: 1.5), // Change border color when unchecked
              fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                if (states.contains(WidgetState.selected)) {
                  return brandPrimaryColor; // Filled color when checked
                }
                return Colors.transparent; // Transparent when unchecked
              }),
              checkColor: textPrimaryColor, // Tick color
              value: isCompleted,
              onChanged: onCheckboxChanged,
            )),
        title: Text(
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 17,
            color: Colors.white,
          ),
        ),
        subtitle: Row(
          children: [
            Text(
              "$displayDate at $timeOfDay",
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ],
        ),
        trailing: Container(
          height: 40,
          width: 80,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon(icon, size: 18, color: Colors.white),
              SizedBox(width: 4),
              Text(
                overflow: TextOverflow.ellipsis,
                category,
                style: TextStyle(fontSize: 13, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
