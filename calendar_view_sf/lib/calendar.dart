import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'main.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCalendar(
        dataSource: MeetingDataSource(getAppointments()), //this is needed so that we are able to create the actual appointments
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource{
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}

List<Appointment> getAppointments() {
  List<Appointment> meetings = <Appointment>[];
  DateTime today = DateTime.now(); //DataTime is the variable type
  DateTime startTime = DateTime(today.year, today.month, today.day); // the time the event starts at
  DateTime endTime = startTime; //timing of how long the event actually takes

  meetings.add(Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: 'Dinner with friends', //name of the event
      color: Colors.blue)); // color of what it will show up as on the calendar page

  startTime = DateTime(today.year, today.month, today.day, 15, 30, 0); // timing for the second event
  endTime = startTime.add(const Duration(hours: 1)); // length of second event

  meetings.add(Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: 'Take Dog for walk',
      color: Colors.red));

  startTime = DateTime(today.year, today.month, today.day, 7, 00, 0); // timing for the third event
  endTime = startTime.add(const Duration(hours: 2, minutes: 30)); // length of third event

  meetings.add(Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: 'Breakfast with friends',
      color: Colors.lightGreen));

  return meetings;

}