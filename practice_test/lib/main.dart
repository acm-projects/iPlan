import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice_test/Backend/Authentication/sign_up_authentication.dart';
import 'package:practice_test/Backend/Authentication/update_files.dart';
import 'package:practice_test/Backend/Collaboration/collaboration_page.dart';
import 'package:practice_test/Frontend/Collaboration/collaboration.dart';

import 'Backend/Authentication/log_in_authentication.dart';
import 'Backend/Event_Manager/event_creator.dart';
import 'Backend/Event_Manager/event.dart';
import 'Backend/User_Creation/user.dart';
import 'Backend/User_Creation/user_assembler.dart';
import 'Backend/User_Creation/user_creator.dart';

import 'Frontend/Authentication/welcomePage.dart';
import 'Frontend/Event_Manager/events_home_page.dart';
import 'home.dart';

late User user;

late Event event;

void main() async {
  /// {begin} the following lines of code can be used to reset the items created during live demo testing
  String? userID = await LogInAuthentication.logInWithEmail(
      email: "jon@gmail.com", password: "jonperry");
  UserAssembler uA = UserAssembler(userID: userID!);
  await uA.assembleUserFromCloud();
  
  User jon = uA.getUser();
  var event = jon.getEvents()[0];
  var calendarPage = event.getCalendarPage();
  while (calendarPage.removeTask(taskName: "Buy Lighting")) {
    print("removed calendar event");
  }
  var collaborationPage = event.getCollaborationPage();
  while (
      collaborationPage.removeCollaborator(collaboratorName: "Veda Charthad")) {
    print("removed collaborator");
  }
  var itineraryPage = event.getItineraryPage();
  while (
      itineraryPage.removeTask(isBefore: true, taksName: "Set Up Lighting")) {
    print("removed itinerary task");
  }
  var financePage = event.getFinancePage();
  while (financePage.removeExpenseFromCategory(
      categoryName: "Venue", expenseName: "Lighting")) {
    print("removed expense");
  }
  while (financePage.removeCategory(categoryName: "Outfits")) {
    print("removed category");
  }

  event.updateCalendarPage(calendarPage: calendarPage);
  event.updateCollaborationPage(collaborationPage: collaborationPage);
  event.updateFinancePage(financePage: financePage);
  event.updateItineraryPage(itineraryPage: itineraryPage);
  await UpdateFiles.updateEventFile(
      documentID: event.getLink(), json: event.toJson());

  /// {end}
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "iPlan",
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
      // routes: {
      //   '/': (context) => WelcomePage(),
      // },
      home: WelcomePage(),
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
