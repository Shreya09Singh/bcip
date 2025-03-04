import 'package:bciapplication/Screens/note_module/ShowTask_screen.dart';
import 'package:bciapplication/provider/taskProvider2.dart';

import 'package:bciapplication/utils/constants.dart';
import 'package:bciapplication/widget/TabBar.dart';
import 'package:bciapplication/widget/progressComparisonChart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ShowprogressScreen extends StatelessWidget {
  const ShowprogressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskprovider = Provider.of<TaskProvider2>(context);
    return Scaffold(
      backgroundColor: backgroundBlackColor,
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Colors.black,
        title: Text("Progress",
            style: GoogleFonts.poppins(
                color: Colors.blue, fontSize: 30, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,

          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text('Task Overview',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TabBarScreen(
                          initialIndex: 2, // Set default to "Completed"
                          tabs: const [
                            Tab(text: 'All'),
                            Tab(text: 'Ongoing'),
                            Tab(text: 'Completed'),
                          ],
                          tabViews: const [
                            ShowtaskScreen(filter: 'All'),
                            ShowtaskScreen(filter: 'Ongoing'),
                            ShowtaskScreen(filter: 'Completed'),
                          ],
                        ),
                      ),
                    );
                  },
                  child: TaskCard(
                    number: taskprovider.completedTaskCount,
                    title: 'Completed',
                    imagePath: 'assets/completedLines.png',
                    cardColor: brandPrimaryColor,
                    textColor: textPrimaryColor,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TabBarScreen(initialIndex: 1, tabs: [
                                  Tab(
                                    text: 'All',
                                  ),
                                  Tab(
                                    text: 'Ongoing',
                                  ),
                                  Tab(
                                    text: 'Completed',
                                  ),
                                ], tabViews: [
                                  ShowtaskScreen(
                                    filter: 'All',
                                  ),
                                  ShowtaskScreen(
                                    filter: 'Ongoing',
                                  ),
                                  ShowtaskScreen(
                                    filter: 'Completed',
                                  ),
                                ])));
                  },
                  child: TaskCard(
                      number: taskprovider.incompletedTaskCount,
                      title: 'Ongoing',
                      imagePath: 'assets/ongoingLines.png',
                      cardColor: backgroundWhiteColor,
                      textColor: brandPrimaryColor),
                )
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text('Daily Task Overview',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
                height: 240,
                width: 325,
                child: Center(child: ComparisonChart())),
          ],
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final num number;
  final String title;
  final String imagePath;
  final Color cardColor;
  final Color textColor;

  const TaskCard({
    Key? key,
    required this.number,
    required this.title,
    required this.imagePath,
    required this.cardColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 155,
      width: 155,
      child: Card(
        color: cardColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              number.toString(),
              style: TextStyle(
                color: textColor,
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
