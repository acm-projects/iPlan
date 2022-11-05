import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Frontend/Finance/budget.dart';
import 'Frontend/Collaboration/collaboration.dart';
import 'Frontend/Calendar/calendar.dart';
import 'Frontend/Home_Page/eventHome.dart';
import 'Frontend/Settings/settings.dart';

import 'Backend/User_Creation/user.dart';
import 'Backend/Event_Manager/event.dart';

/// @author [MatthewSheldon]
/// The [User] object that will be updated
late User _user;

/// @author [MatthewSheldon]
/// The [Event] object for the current event that will be updated
late Event _event;

class Home extends StatefulWidget {
  Home({super.key, required User user, required Event event}) {
    _user = user;
    _event = event;
  }

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  final screens = [
    EventHome(),
    Calendar(user: _user, event: _event),
    Budget(user: _user, event: _event),
    Budget(user: _user, event: _event),
    Collaboration(user: _user, event: _event),
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
            BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 30), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month, size: 30), label: 'Calendar'),
            BottomNavigationBarItem(
                icon: Icon(Icons.wallet, size: 30), label: 'Budget'),
            BottomNavigationBarItem(
                icon: Icon(Icons.schedule, size: 30), label: 'Itinerary'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_add, size: 30), label: 'Collaborate'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings, size: 30), label: 'Settings')
          ]),
    );
  }
}
