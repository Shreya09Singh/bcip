import 'package:bciapplication/Screens/note_module/showProgress_screen.dart';

import 'package:bciapplication/provider/taskProvider2.dart';

import 'package:bciapplication/provider/connection_provider.dart';

import 'package:bciapplication/provider/onboarding_provider.dart';
import 'package:bciapplication/provider/song_provider.dart';

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
          ChangeNotifierProvider(create: (context) => SongProvider()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
          ),
          // home: ShowtaskScreen()
          // home: TodoListScreen(),
          home: ShowprogressScreen(),
          // home: TaskScreen(),
          // home: MeditaionScreen(),
          // home: Recomendedong(),
          // home: SearchGanaScreen(),
          // home: WelcomeScreen(),
          // home: MusicScreen(),
          // home: MusicPlayerScreenn(),
          // home: SearchScreen(),
        ));
  }
}
