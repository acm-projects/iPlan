import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Frontend/Authentication/login.dart';
import 'Frontend/Authentication/register.dart';
import 'Frontend/Authentication/forgotPass.dart';

import 'Frontend/Finance/budget.dart';
import 'Frontend/Calendar/calendar.dart';
import 'Frontend/Home_Page/eventHome.dart';
import 'Frontend/Settings/settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Budget Home Page",
        theme: ThemeData(
          timePickerTheme: _timePickerTheme,
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              foregroundColor: MaterialStateColor.resolveWith((states) => Colors.black),
              backgroundColor: MaterialStateColor.resolveWith((states) => Color(0xFFBAE365)
              ),
            ),
          ),
        ),
        home: Register(),
    );
  }
}

final _timePickerTheme = TimePickerThemeData(
  backgroundColor: Color(0xFF657BE3),
  hourMinuteShape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    side: BorderSide(color: Color(0xFFBAE365)
        , width: 4),
  ),
  dayPeriodBorderSide: const BorderSide(color: Color(0xFFBAE365)
      , width: 4),
  dayPeriodColor: Color(0x80657BE3),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    side: BorderSide(color: Color(0xFFBAE365)
        , width: 4),
  ),
  dayPeriodTextColor: Color.fromRGBO(254, 247, 236, 1),
  dayPeriodShape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    side: BorderSide(color: Color(0xFFBAE365)
        , width: 4),
  ),
  hourMinuteColor: MaterialStateColor.resolveWith((states) =>
  states.contains(MaterialState.selected) ? Color(0xFFBAE365)
      : Color(0xFF8193ff)),
  hourMinuteTextColor: MaterialStateColor.resolveWith(
          (states) => states.contains(MaterialState.selected) ? Colors.black : Color(0xFFBAE365)
  ),
  dialHandColor: Color(0xFF657BE3),
  dialBackgroundColor: Color(0xFF8193ff),
  hourMinuteTextStyle: GoogleFonts.lato(fontSize: 40, fontWeight: FontWeight.bold),
  dayPeriodTextStyle: GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.bold),
  helpTextStyle:
  GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.bold, color: Color.fromRGBO(254, 247, 236, 1)),
  inputDecorationTheme: const InputDecorationTheme(
    border: InputBorder.none,
    contentPadding: EdgeInsets.all(0),
  ),
  dialTextColor: MaterialStateColor.resolveWith(
          (states) => states.contains(MaterialState.selected) ? Color(0xFFBAE365)
              : Color.fromRGBO(254, 247, 236, 1)),
  entryModeIconColor: Color(0xFFBAE365)
  ,
);
