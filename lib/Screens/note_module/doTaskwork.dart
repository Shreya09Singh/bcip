import 'dart:async';
import 'dart:math';

import 'package:bciapplication/chart/noteChart.dart';
import 'package:bciapplication/utils/constants.dart';
import 'package:flutter/material.dart';

class StopwatchScreen extends StatefulWidget {
  @override
  _StopwatchScreenState createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  Timer? _timer;
  int milliseconds = 0;
  bool isRunning = false;

  void startStopwatch() {
    if (!isRunning) {
      _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
        setState(() {
          milliseconds += 10;
        });
      });
    } else {
      _timer?.cancel();
    }
    setState(() {
      isRunning = !isRunning;
    });
  }

  void resetStopwatch() {
    _timer?.cancel();
    setState(() {
      milliseconds = 0;
      isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    int seconds = (milliseconds ~/ 1000) % 60;
    int centiseconds = (milliseconds ~/ 10) % 100;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: greybackgroundColor,
        title: Text('Do MathsHomework',
            style: TextStyle(
                color: brandPrimaryColor, fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'SessionTimer : ',
                  style: TextStyle(
                    color: brandPrimaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    size: Size(210, 210),
                    painter: StopwatchPainter(milliseconds),
                  ),
                  Text(
                    "00:${seconds.toString().padLeft(2, '0')}.${centiseconds.toString().padLeft(2, '0')}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(
                          isRunning
                              ? Icons.pause_circle_filled
                              : Icons.play_arrow_rounded,
                          color: Colors.blue,
                          size: 50,
                        ),
                        onPressed: startStopwatch,
                      ),
                      Text(
                        isRunning ? 'pause' : 'play',
                        style:
                            TextStyle(color: textSecondaryColor, fontSize: 20),
                      )
                    ],
                  ),
                  SizedBox(width: 40),
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.replay, color: Colors.blue, size: 50),
                        onPressed: resetStopwatch,
                      ),
                      Text(
                        'replay',
                        style:
                            TextStyle(color: textSecondaryColor, fontSize: 20),
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BrainwaveGraph(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class StopwatchPainter extends CustomPainter {
  final int milliseconds;

  StopwatchPainter(this.milliseconds);

  @override
  void paint(Canvas canvas, Size size) {
    final cennter = size.center(Offset.zero);
    final raddius = size.width / 2;
    final Paint circlePaint = Paint();
    circlePaint.color = brandPrimaryColor;
    circlePaint.style = PaintingStyle.stroke;
    circlePaint.strokeWidth = 7;

    canvas.drawCircle(cennter, raddius, circlePaint);

    final Paint tickPaint = Paint()
      ..color = textSecondaryColor
      ..strokeWidth = 1;

    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);
    for (int i = 0; i < 60; i++) {
      double angle = (pi / 30) * i - (pi / 2);
      double innerRadius = (i % 5 == 0) ? radius - 20 : radius - 10;

      Offset start = Offset(
        center.dx + innerRadius * cos(angle),
        center.dy + innerRadius * sin(angle),
      );

      Offset end = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );

      canvas.drawLine(start, end, tickPaint);
    }

    // Draw numbers
    final TextPainter textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < 12; i++) {
      int number = i * 5;
      String text = (number == 0) ? "60" : "$number";
      double angle = (pi / 6) * i - (pi / 2);
      Offset textOffset = Offset(
        center.dx + (radius - 30) * cos(angle) - 10,
        center.dy + (radius - 30) * sin(angle) - 10,
      );
      textPainter.text = TextSpan(
        text: text,
        style: const TextStyle(color: textSecondaryColor, fontSize: 12),
      );
      textPainter.layout();
      textPainter.paint(canvas, textOffset);
    }
    // Draw stopwatch hand
    final Paint handPaint = Paint()
      ..color = brandPrimaryColor
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    double handAngle = (milliseconds % 60000) * (pi / 30000) - (pi / 2);
    Offset handEnd = Offset(
      center.dx + (radius - 25) * cos(handAngle),
      center.dy + (radius - 25) * sin(handAngle),
    );

    canvas.drawLine(center, handEnd, handPaint);
  }

  @override
  bool shouldRepaint(covariant StopwatchPainter oldDelegate) {
    return oldDelegate.milliseconds != milliseconds;
  }
}
