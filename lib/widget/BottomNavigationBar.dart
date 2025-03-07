import 'package:bciapplication/Screens/meditaion/meditaion_screen.dart';
import 'package:bciapplication/Screens/note_module/showProgress_screen.dart';
import 'package:bciapplication/Screens/note_module/todo_List_screen.dart';
import 'package:bciapplication/Screens/splash/Welcome_screen.dart';
import 'package:bciapplication/utils/constants.dart';
import 'package:flutter/material.dart';

class BottomnavigationbarScreen extends StatefulWidget {
  const BottomnavigationbarScreen({super.key});

  @override
  State<BottomnavigationbarScreen> createState() =>
      _BottomnavigationbarScreenState();
}

class _BottomnavigationbarScreenState extends State<BottomnavigationbarScreen> {
  int selectedIndex = 0;
  void onItemTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  static const List<Widget> _screens = [
    MeditaionScreen(),
    TodoListScreen(),
    ShowprogressScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onItemTap,
          currentIndex: selectedIndex,
          selectedItemColor: brandPrimaryColor,
          unselectedItemColor: textSecondaryColor,
          backgroundColor: greybackgroundColor,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.note_add),
              label: 'Todo',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.update),
              label: 'Progress',
            ),
          ]),
    );
  }
}
