/*
Notes:
BUGFIX: Can now add tasks on initial load screen

TODO: remove dot markers when task isComplete

Backend:
store and retrieve selectedTasks (map of DateTime and Task<List>)
order tasks from earliest time to latest time in selectedTasks
 */

//can be replaced with backend task class, requires title, day, time, isComplete
import 'helpers/task.dart';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:google_fonts/google_fonts.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  //map with date as key and list of tasks on that date as value
  late Map<DateTime, List<Task>> selectedTasks;
  //calendar format is calendar view (month, two weeks, week)
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.parse((DateTime.now().toString()).substring(0, 10) + " 00:00:00.000Z");
  DateTime focusedDay = DateTime.parse((DateTime.now().toString()).substring(0, 10) + " 00:00:00.000Z");

  TextEditingController _taskController = TextEditingController();
  TimeOfDay _timeController = TimeOfDay(hour: 0, minute: 0);

  @override
  void initState() {
    selectedTasks = {}; //initializes selectedTasks to nothing
    super.initState();
  }

  List<Task> _getTasksfromDay(DateTime date) {
    String strManip = (date.toString()).substring(0, 10) + " 00:00:00.000Z";
    return selectedTasks[DateTime.parse(strManip)] ?? [];
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _timeController = TimeOfDay(hour: 0, minute: 0);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF657BE3),
      body: Column(
        children: [
          //title of page
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 5.0),
            child: Center(
              child: Text.rich(
                TextSpan(
                  text: 'Calendar',
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
          Padding(
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TableCalendar(
                      rowHeight: 45.0,
                      daysOfWeekHeight: 15.0,

                      focusedDay: selectedDay,
                      firstDay: DateTime(1990),
                      lastDay: DateTime(2050),

                      //calendar view changes
                      calendarFormat: format,
                      onFormatChanged: (CalendarFormat _format) {
                        setState(() {
                          format = _format;
                        });
                      },

                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      daysOfWeekVisible: true,

                      //day changes
                      onDaySelected: (DateTime selectDay, DateTime focusDay) {
                        setState(() {
                          selectedDay = selectDay;
                          focusedDay = focusDay;
                        });
                      },
                      selectedDayPredicate: (DateTime date) {
                        return isSameDay(selectedDay, date);
                      },

                      eventLoader: _getTasksfromDay,

                      //aesthetics
                      calendarStyle: const CalendarStyle(
                        isTodayHighlighted: true,
                        selectedTextStyle: TextStyle(
                          color: Colors.black,
                        ),
                        todayTextStyle: TextStyle(
                          color: Colors.black,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: Color.fromRGBO(186, 227, 101, 1),
                          shape: BoxShape.circle,
                        ),
                        todayDecoration: BoxDecoration(
                          color: Color.fromRGBO(186, 227, 101, 0.5),
                          shape: BoxShape.circle,
                        ),
                      ),
                      headerStyle: HeaderStyle(
                        titleCentered: false,
                        titleTextStyle: GoogleFonts.lato(),
                        formatButtonTextStyle: GoogleFonts.lato(),
                        formatButtonVisible: true,
                        formatButtonShowsNext: false,
                        formatButtonDecoration: BoxDecoration(
                          color: const Color.fromRGBO(186, 227, 101, 1),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
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
                    //click on a new day, returns a list of tasks for that day
                    ..._getTasksfromDay(selectedDay).map(
                          (Task event) => listTileWidget(event),
                    ),
                    SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      //button to add new task
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  color: Color(0xff757575),
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(101, 123, 227, 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: const Icon(
                                size: 40.0,
                                Icons.close,
                              ),
                              color: Color.fromRGBO(186, 227, 101, 1),
                              onPressed: (){
                                _taskController.clear();
                                Navigator.pop(context);
                              },
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Add Task",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0,
                                color: Color.fromRGBO(254, 247, 236, 1),
                              ),
                            ),
                            SizedBox(height: 10),
                            IconButton(
                              icon: const Icon(
                                size: 40.0,
                                Icons.check_circle,
                              ),
                              color: Color.fromRGBO(186, 227, 101, 1),
                              onPressed: () {
                                if (_taskController.text.isEmpty || _timeController == null) {

                                } else {
                                  if (selectedTasks[selectedDay] != null) {
                                    selectedTasks[selectedDay]?.add(
                                      Task(title: _taskController.text, day: selectedDay, time: _timeController),
                                    );
                                  } else {
                                    selectedTasks[selectedDay] = [
                                      Task(title: _taskController.text, day: selectedDay, time: _timeController),
                                    ];
                                  }
                                }
                                Navigator.pop(context);
                                _taskController.clear();
                                setState((){});
                                return;
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                        //task name
                        Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(254, 247, 236, 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: TextField(
                              controller: _taskController,
                              style: GoogleFonts.lato(
                                color: Colors.black,
                              ),
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Task Name',
                                prefixIcon: Icon(
                                  Icons.task,
                                  color: Color(0xFF657BE3),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        //task name
                        Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(254, 247, 236, 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                            child: Text(
                              'Select Time',
                              style: GoogleFonts.lato(
                                fontSize: 15.0,
                                color: Colors.black,
                              ),
                            ),
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20, vertical: 15)),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              )),
                              backgroundColor: MaterialStateProperty.all(Color(0xFFBAE365)),
                            ),
                            onPressed: () async{
                              _timeController = (await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ))!;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        label: Text(
          "Add Task",
          style: GoogleFonts.lato(),
        ),
        icon: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(186, 227, 101, 1),
        foregroundColor: Colors.black,
      ),
      //Navigation Bar with Icons
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

  Widget listTileWidget(Task event){
    return CheckboxListTile(
      activeColor: Color.fromRGBO(186, 227, 101, 1),
      checkColor: Colors.black,
      title: Text(
        "${event.time.format(context)}".padRight(25) + "${event.title}",
        style: GoogleFonts.lato(
            decoration: event.isComplete
                ? TextDecoration.lineThrough
                : TextDecoration.none
        ),
      ),
      value: event.isComplete,
      onChanged: (value){
        setState((){
          event.isComplete = value!;
        });
      },
    );
  }
}