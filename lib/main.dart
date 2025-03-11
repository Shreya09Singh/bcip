import 'package:bciapplication/Screens/splash/Welcome_screen.dart';
import 'package:bciapplication/provider/Todo_provider.dart';

import 'package:bciapplication/provider/getsession_provider.dart';
import 'package:bciapplication/provider/session_provider.dart';

import 'package:bciapplication/provider/taskProvider2.dart';

import 'package:bciapplication/provider/connection_provider.dart';

import 'package:bciapplication/provider/onboarding_provider.dart';
import 'package:bciapplication/provider/timer_provider.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => OnboardingProvider(),
          ),
          ChangeNotifierProvider(create: (context) => ConnectionProvider()),
          ChangeNotifierProvider(create: (context) => TaskProvider2()),
          ChangeNotifierProvider(create: (context) => TodoProvider()),
          ChangeNotifierProvider(create: (context) => SessionProvider()),
          ChangeNotifierProvider(create: (context) => GetsessionProvider()),
          ChangeNotifierProvider(create: (context) => TimerProvider()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
          ),
          // home: MeditaionScreen(),
          home: WelcomeScreen(),
        ));
  }
}
