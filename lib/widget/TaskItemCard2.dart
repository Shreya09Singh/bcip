// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:bciapplication/utils/constants.dart';

class TaskItemWidget2 extends StatelessWidget {
  final String title;
  final String displayDate;
  final String timeOfDay;
  final bool isCompleted;
  final ValueChanged<bool?>? onCheckboxChanged;
  final String category;
  // final IconData icon;
  final bool ongoing;

  const TaskItemWidget2({
    Key? key,
    required this.title,
    required this.displayDate,
    required this.timeOfDay,
    required this.isCompleted,
    this.onCheckboxChanged,
    required this.category,
    // required this.icon,
    required this.ongoing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
      child: Container(
        height: 80,
        width: 300,
        decoration: BoxDecoration(
          color: greybackgroundColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: ListTile(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                  color: Colors.white,
                ),
              ),
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  displayDate,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                Container(
                  height: 30,
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
              ],
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    ongoing ? Icons.sync_alt : Icons.check_box,
                    color: ongoing ? brandPrimaryColor : Colors.lightGreen,
                  ),
                  Text(
                    ongoing ? 'Ongoing' : 'Completed',
                    style: TextStyle(color: textSecondaryColor),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
