/*
Notes:
Can scroll to 2 days prior to current day + 500 days after

Backend:
store and retrieve selectedTasks (map of DateTime and Task<List>)
order tasks from earliest time to latest time in selectedTasks
 */

import 'package:intl/intl.dart';

import '../Helpers/event.dart';
import '../Helpers/task.dart';
import '../Date_Picker_Timeline/date_picker_timeline.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventHome extends StatefulWidget {
  @override
  _EventHomeState createState() => _EventHomeState();
}

class _EventHomeState extends State<EventHome> {
  //selectedTasks maps a date to a list of tasks on that date (same as calendar)
  //initializes selectedTasks for testing purposes only
  //TODO: change to Map<DateTime, List<Task>> selectedTasks;
  Map<DateTime, List<Task>> selectedTasks = {
    DateTime.utc(2022, DateTime.october, 20): [Task(title: "Cater", day: DateTime.utc(2022, DateTime.october, 20), time: TimeOfDay(hour: 8, minute: 0)), Task(title: "RSVP", day: DateTime.utc(2022, DateTime.october, 20), time: TimeOfDay(hour: 0, minute: 0))],
    DateTime.utc(2022, DateTime.october, 25): [Task(title: "Cater", day: DateTime.utc(2022, DateTime.october, 25), time: TimeOfDay(hour: 0, minute: 0)), Task(title: "RSVP", day: DateTime.utc(2022, DateTime.october, 25), time: TimeOfDay(hour: 3, minute: 20))],
  };

  //initializes event for testing purposes only
  //TODO: change to pull event info from backend
  Event example = Event(title: "Staff Beach Party", day: DateTime.now());

  DatePickerController _controller = DatePickerController();
  //selected date
  DateTime _selectedValue = DateTime.now();

  @override
  void initState() {
    //TODO: initialize selectedTasks to user's selectedTasks (same as calendar)
    super.initState();
  }

  //returns list of tasks given date
  List<Task> _getTasksfromDay(DateTime date) {
    //manipulates dateTime because of formatting issues
    String strManip = (date.toString()).substring(0, 10) + " 00:00:00.000Z";
    return selectedTasks[DateTime.parse(strManip)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF657BE3),
      body: Column(
        children: [
          //displays title of event
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 5.0),
            child: Center(
              child: Text.rich(
                TextSpan(
                  text: example.title,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Color.fromRGBO(254, 247, 236, 1),
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0.0, 9.0, 0.0, 0.0),
              child: Container(
                height: size.height - 184.0,
                decoration: BoxDecoration(
                  color: Color(0xFFFEF7EC),
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20.0),
                    topRight: const Radius.circular(20.0),
                  ),
                ),
                child: ListView(
                  children: [
                    SizedBox(height: 30),
                    //displays date of event
                    Center(
                      child: Text(
                        DateFormat.MMMM().format(example.day) + DateFormat(' dd, yyyy').format(example.day),
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    //calendar button
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 40.0),
                      height: 50.0,
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: (){}, //TODO: reroute to calendar page
                        icon: Icon(
                          color: Colors.black,
                          Icons.calendar_month
                        ),
                        label: Text(
                          "Calendar",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 50)),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          )),
                          backgroundColor: MaterialStateProperty.all(Color.fromRGBO(186, 227, 101, 1)),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    calendarView(),
                    SizedBox(height: 20),
                    //tasks to complete text
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Tasks to complete",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    //displays list of tasks for selected day
                    ..._getTasksfromDay(_selectedValue).map(
                      (Task task) {
                        return listTileWidget(task);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      //navigation Bar with Icons
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.black, size: 30), label: 'Home', backgroundColor: Color(0xFFA3B0EB)),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_month, color: Colors.black, size: 30), label: 'Calendar', backgroundColor: Color(0xFFA3B0EB)),
            BottomNavigationBarItem(icon: Icon(Icons.wallet, color: Colors.black, size: 30), label: 'Budget', backgroundColor: Color(0xFFA3B0EB)),
            BottomNavigationBarItem(icon: Icon(Icons.schedule, color: Colors.black, size: 30), label: 'Itinerary', backgroundColor: Color(0xFFA3B0EB)),
            BottomNavigationBarItem(icon: Icon(Icons.person_add, color: Colors.black, size: 30), label: 'Collaborate', backgroundColor: Color(0xFFA3B0EB)),
            BottomNavigationBarItem(icon: Icon(Icons.settings, color: Colors.black, size: 30), label: 'Settings', backgroundColor: Color(0xFFA3B0EB))
          ]
      ),
    );
  }

  //horizontal scrolling calendar
  Widget calendarView() {
    return Container(
      child: DatePicker(
        //first day available to access
        DateTime.now().subtract(const Duration(days: 2)),
        width: 60,
        height: 80,
        controller: _controller,
        initialSelectedDate: DateTime.now(),
        selectionColor: Color(0xFF657BE3),
        selectedTextColor: Color.fromRGBO(254, 247, 236, 1),
        onDateChange: (date) {
          setState(() {
            _selectedValue = date;
          });
        },
        monthTextStyle: GoogleFonts.lato(
          fontSize: 15.0,
        ),
        dayTextStyle: GoogleFonts.lato(
          fontSize: 10.0,
        ),
        dateTextStyle: GoogleFonts.lato(
          fontSize: 20.0,
        ),
      ),
    );
  }

  //displays task with checkbox
  Widget listTileWidget(Task task){
    return Positioned(
      child: CheckboxListTile(
        activeColor: Color.fromRGBO(186, 227, 101, 1),
        checkColor: Colors.black,
        title: Text(
          "${task.time.format(context)}".padRight(25) + "${task.title}",
          style: GoogleFonts.lato(
              decoration: task.isComplete
                  ? TextDecoration.lineThrough
                  : TextDecoration.none
          ),
        ),
        value: task.isComplete,
        onChanged: (value){
          setState((){
            task.isComplete = value!;
          });
        },
      ),
    );
  }
}