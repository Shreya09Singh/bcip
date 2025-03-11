import 'dart:math';

import 'package:bciapplication/Screens/progress/CustomChart.dart';
import 'package:bciapplication/provider/getsession_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Replace with the actual provider file path

class SessionHelper {
  final BuildContext context;
  late int guidedTime;
  late int unguidedTime;
  late int greenVal;
  late int sec;
  late String sessionName1;
  late String sessionName2;
  late int listenTime;
  late int previoustime;
  late int selectedTime;
  late double progress;
  late int overThresholdCount;
  late List<int> overThresholdValue;
  late int thresholdPercentage;
  late String formattedTime;
  late num totalthresholdvalue;
  late List<WeekData> chartdata;
  late List<int> focusvalues;
  // late num lowthresholdvalue;
  // late num lowval;
  SessionHelper(this.context) {
    _initializeValues();
  }

  void _initializeValues() {
    final getSessionProvider =
        Provider.of<GetsessionProvider>(context, listen: false);
    guidedTime = 0;
    unguidedTime = 0;
    greenVal = 0;
    sec = 0;
    totalthresholdvalue = 0;
    sessionName1 = "";
    sessionName2 = "";
    listenTime = 0;
    selectedTime = 0;
    previoustime = 0;
    progress = 0;
    overThresholdCount = 1;
    overThresholdValue = [];
    chartdata = [];
    // lowval = 0;
    focusvalues = [];
    // lowthresholdvalue = 0;
    final Random random = Random();
    if (!getSessionProvider.isLoading &&
        getSessionProvider.user != null &&
        getSessionProvider.user!.sessions.isNotEmpty) {
      int sessionIndex = getSessionProvider.user!.sessions.length - 1;

      greenVal =
          getSessionProvider.user!.sessions[sessionIndex].selectedThreshold;

      listenTime =
          getSessionProvider.user!.sessions[sessionIndex].actualDuration;
      selectedTime =
          getSessionProvider.user!.sessions[sessionIndex].listenDuration;

      int selectedSec = selectedTime * 60;
      int totalListenSec = selectedSec - listenTime;
      // int totalthresholdval =
      //     focusvalues.isNotEmpty ? focusvalues.reduce((a, b) => a + b) : 0;

      previoustime =
          getSessionProvider.user!.sessions[sessionIndex].actualDuration;

      if (totalListenSec > 0) {
        progress = totalListenSec.toDouble() / selectedSec.toDouble();
      }

      if (getSessionProvider.user!.sessions.length > 1) {
        sessionName1 =
            getSessionProvider.user!.sessions[sessionIndex].sessionName;
        sessionName2 =
            getSessionProvider.user!.sessions[sessionIndex - 1].sessionName;
        overThresholdValue =
            getSessionProvider.user!.sessions[sessionIndex].overThresholdValues;
        overThresholdCount =
            getSessionProvider.user!.sessions[sessionIndex].overThresholdCount;
        // int lowthresholdvalue = guidedTime = totalListenSec;
        unguidedTime = getSessionProvider
                .user!.sessions[sessionIndex - 1].actualDuration -
            getSessionProvider.user!.sessions[sessionIndex - 1].listenDuration;

        guidedTime =
            getSessionProvider.user!.sessions[sessionIndex].actualDuration -
                getSessionProvider.user!.sessions[sessionIndex].listenDuration;

        // getSessionProvider.user!.sessions[sessionIndex].listenDuration;

        focusvalues =
            getSessionProvider.user!.sessions[sessionIndex].focusValues;
        final List<String> weekDays = [
          'Sun',
          'Mon',
          'Tue',
          'Wed',
          'Thu',
          'Fri',
          'Sat'
        ];
        for (int i = 0; i < 7; i++) {
          int value =
              (i < focusvalues.length) ? focusvalues[i] : Random().nextInt(101);

          if (i < focusvalues.length) {
            value = focusvalues[i];
          } else {
            value = random.nextInt(101);
          }
          chartdata.add(WeekData(
            weekDays[i], // Correctly mapping days of the week
            value, // Ensuring we don't exceed focusValues length
          ));
        }
      } else {
        sessionName1 =
            getSessionProvider.user!.sessions[sessionIndex].sessionName;
        sessionName2 = "No Session Available";
        overThresholdValue = [];
        overThresholdCount = 1;
        // focusvalues = [];
      }
    }

    // void _populateChartData() {
    //   final List<String> weekDays = [
    //     'Sun',
    //     'Mon',
    //     'Tue',
    //     'Wed',
    //     'Thu',
    //     'Fri',
    //     'Sat'
    //   ];

    //   for (int i = 0; i < 7; i++) {
    //     int value;
    //     if (i < focusvalues.length) {
    //       value = focusvalues[i];
    //     } else {
    //       // Generate a random value between 0 and 100
    //       value = random.nextInt(101);
    //     }
    //     chartData.add(WeekData(weekDays[i], value));
    //   }
    // }

    int totalOverThreshold = overThresholdValue.isNotEmpty
        ? overThresholdValue.reduce((a, b) => a + b)
        : 30;

    thresholdPercentage = (totalOverThreshold / overThresholdCount).toInt();

    int totalSeconds = guidedTime + unguidedTime;
    Duration duration = Duration(seconds: totalSeconds);
    int minutes = duration.inMinutes;
    int seconds = duration.inSeconds % 60;
    formattedTime =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
