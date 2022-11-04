import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Backend/Authentication/log_in_authentication.dart';
import 'Backend/Event_Manager/event.dart';
import 'Backend/User_Creation/user.dart';
import 'Backend/User_Creation/user_assembler.dart';

import 'Frontend/Collaboration/collaboration.dart';

late User user;

late Event event;

void main() async {
  String? userID = await LogInAuthentication.logInWithEmail(
      email: "jon.perry@gmail.com", password: "absolute_legend");

  UserAssembler userAssembler = UserAssembler(userID: userID!);
  List<dynamic> ans = await userAssembler.assembleUserFromCloud();

  if (ans[0] == UserAssembler.success) {
    user = ans[1];
  }

  print(ans[0]);

  // ans = await EventCreator.createEvent(
  //     eventName: "iPlan test 2.0",
  //     budget: 15999.99,
  //     date: DateTime(2022, 11, 5),
  //     startTime: TimeOfDay(hour: 7, minute: 30),
  //     endTime: TimeOfDay(hour: 15, minute: 45),
  //     user: user);

  event = user.getEvents()[0];
  await event.getCollaborationPage().constructorHelperMethod();
  print(event.toJson());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Budget Home Page",
      theme: ThemeData(
        timePickerTheme: _timePickerTheme,
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor:
                MaterialStateColor.resolveWith((states) => Colors.black),
            backgroundColor:
                MaterialStateColor.resolveWith((states) => Color(0xFFBAE365)),
          ),
        ),
      ),
      home: Collaboration(user: user, event: event),
    );
  }
}

final _timePickerTheme = TimePickerThemeData(
  backgroundColor: Color(0xFF657BE3),
  hourMinuteShape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    side: BorderSide(color: Color(0xFFBAE365), width: 4),
  ),
  dayPeriodBorderSide: const BorderSide(color: Color(0xFFBAE365), width: 4),
  dayPeriodColor: Color(0x80657BE3),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    side: BorderSide(color: Color(0xFFBAE365), width: 4),
  ),
  dayPeriodTextColor: Color.fromRGBO(254, 247, 236, 1),
  dayPeriodShape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    side: BorderSide(color: Color(0xFFBAE365), width: 4),
  ),
  hourMinuteColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected)
          ? Color(0xFFBAE365)
          : Color(0xFF8193ff)),
  hourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected)
          ? Colors.black
          : Color(0xFFBAE365)),
  dialHandColor: Color(0xFF657BE3),
  dialBackgroundColor: Color(0xFF8193ff),
  hourMinuteTextStyle:
      GoogleFonts.lato(fontSize: 40, fontWeight: FontWeight.bold),
  dayPeriodTextStyle:
      GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.bold),
  helpTextStyle: GoogleFonts.lato(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: Color.fromRGBO(254, 247, 236, 1)),
  inputDecorationTheme: const InputDecorationTheme(
    border: InputBorder.none,
    contentPadding: EdgeInsets.all(0),
  ),
  dialTextColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected)
          ? Color(0xFFBAE365)
          : Color.fromRGBO(254, 247, 236, 1)),
  entryModeIconColor: Color(0xFFBAE365),
);
