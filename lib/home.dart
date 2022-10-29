import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Authentication/login.dart';
import 'Authentication/register.dart';
import 'Authentication/forgotPass.dart';

import 'Finance/budget.dart';
import 'Calendar/calendar.dart';
import 'Home_Page/eventHome.dart';
import 'Settings/settings.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{
  int currentIndex = 0;

  final screens = [
    EventHome(),
    Calendar(),
    Budget(),
    Login(), //should be itinerary
    Register(), //should be collaborate
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xFFA3B0EB),
          selectedItemColor: Color.fromRGBO(254, 247, 236, 1),
          unselectedItemColor: Colors.black,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          showSelectedLabels: true,
          showUnselectedLabels: false,
          landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home, size: 30), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_month, size: 30), label: 'Calendar'),
            BottomNavigationBarItem(icon: Icon(Icons.wallet, size: 30), label: 'Budget'),
            BottomNavigationBarItem(icon: Icon(Icons.schedule, size: 30), label: 'Itinerary'),
            BottomNavigationBarItem(icon: Icon(Icons.person_add, size: 30), label: 'Collaborate'),
            BottomNavigationBarItem(icon: Icon(Icons.settings, size: 30), label: 'Settings')
          ]
      ),
    );
  }
}