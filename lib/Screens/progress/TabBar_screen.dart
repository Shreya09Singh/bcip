import 'package:bciapplication/widget/TabBar.dart';
import 'package:flutter/material.dart';
import 'package:bciapplication/Screens/progress/day_view_screen.dart';
import 'package:bciapplication/Screens/progress/week_view_screen.dart';
import 'package:bciapplication/Screens/progress/month_view_screen.dart';

class TabbarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBarScreen(
      tabs: [
        Tab(text: "Day"),
        Tab(text: "Week"),
        Tab(text: "Month"),
      ],
      tabViews: [
        DayViewScreen(date: 'Feb 02, 2025', progress: 34),
        WeekViewScreen(),
        MonthViewScreen(),
      ],
    );
  }
}
