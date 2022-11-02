import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Holds the title of the events
List<String> userEvents = ["Beach Party", "Another Event"];
//Holds a DateTime object with the event date
List<DateTime> eventDates = [DateTime(2022, 12, 24), DateTime(2022, 12, 30)];
//Calculates days left depending on current date
List<int> daysLeft = [(eventDates[0]).difference(dateToday).inDays, (eventDates[1]).difference(dateToday).inDays];
//Current date used for comparison
DateTime dateToday = DateTime.now();
DateTime dateSelected = dateToday;


class EventsHomePage extends StatefulWidget {
  //const EventsHomePage({Key? key}) : super(key: key);
  @override
  _EventsHomeState createState() => _EventsHomeState();
}

class _EventsHomeState extends State<EventsHomePage>{
TimeOfDay _timeOfDay = TimeOfDay(hour: 8, minute: 30);

TextEditingController _eventNameTextEditor = TextEditingController();
TextEditingController _eventBudgetTextEditor = TextEditingController();

  
  Widget build(BuildContext context){

    Future updateInfo() async{ //for backend

    }

    return  Scaffold(
      backgroundColor: Color(0xFF657BE3),
      body: Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
            //CTitle widget just says events
            child: Center(
              child: Text("Events", style: GoogleFonts.lato(fontSize: 50.0, color: Color(0xFFFEF7EC), fontWeight: FontWeight.bold)),
            )
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
            //WhiteSquare widget which holds all other widgets
            child: Center(
            //This child is the container that holds the white square container
              child: Container(
                height: 742.4,
                color: Colors.transparent,
                child: Container(
                  //This is the container that holds all other widgets
                  //decoration rounds the corners and changes color to cream
                  decoration: const BoxDecoration(
                    color: Color(0xFFFEF7EC),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20.0),
                      topRight: const Radius.circular(20.0),
                    )
                  ),
                  //The ListView child displays the hardcoded List of user events that's at the top of this file
                  //The children are inside of a column : list view and the add button
                  //Inside of a container which is inside of expanded
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                      child: SizedBox(
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                child: ListView.builder(
                                  itemCount: userEvents.length,
                                  itemBuilder: (context, index){
                                    return Center(
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
                                        //each event widget is a button that will take a user to that event's specific page 
                                        child: ElevatedButton(
                                          child: ListTile(
                                          //filled in circle with number of days left and "days left" text as the leading widget
                                            leading: CircleAvatar(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0), 
                                                    child: 
                                                      Text(daysLeft[index].toString(), style: GoogleFonts.lato(color: Color(0xFFFEF7EC), fontSize: 25)),), 
                                                      Text("days left", style: GoogleFonts.lato(color: Color(0xFFFEF7EC), fontSize: 10))
                                                ]
                                              ), 
                                              radius: 30, backgroundColor: Color(0xFF657BE3)
                                            ),
                                            //This is the event name the user provided
                                            title: Text(userEvents[index], style: GoogleFonts.lato()),
                                            //This is the date the user provided
                                            subtitle: Text('${eventDates[index].year}/${eventDates[index].month}/${eventDates[index].day}', style: GoogleFonts.lato(color: Colors.black)),
                                          ),
                                          //to be implemented 
                                          onPressed: () {},
                                          //button decoration stuff
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15.0)
                                            ),
                                            side: BorderSide(
                                              width: 3.0,
                                              color: Color(0xFF657BE3)
                                            ),
                                            fixedSize: Size(300, 80),
                                            primary: Color(0xFFFEF7EC),
                                          )
                                        ),
                                      )
                                    );
                                  }
                                ),
                              ),
                            ),
                            //This is the green add button         
                            Padding(
                              padding: EdgeInsets.fromLTRB(300.0, 20.0, 0.0, 15.0),
                              child: FloatingActionButton(
                                backgroundColor: Color(0xFFBAE365),
                                //When the button is pressed, it pulls up a bottom sheet and calls CreateEventPopup widget
                                //This widget is located in the create_event_popup.dart file
                                onPressed: (){
                                  showModalBottomSheet(
                                    context: context, 
                                    isScrollControlled: true,
                                    builder: (context) => SingleChildScrollView(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context).viewInsets.bottom),
                                        child: Container(
                                          color: Color(0xFF757575),
                                          child: Container(
                                            //This is the container the text fields are inside of with decoration
                                            padding: EdgeInsets.all(20.0),
                                            decoration: BoxDecoration(
                                              color: Color(0xFFFEF7EC),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20.0),
                                                topRight: Radius.circular(20.0)
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                //New Event text at the top of the popup
                                                Text("New Event", style: GoogleFonts.lato(fontSize: 17, fontWeight: FontWeight.bold)),

                                                //EVENT NAME TEXT FIELD
                                                Padding(
                                                  padding: const EdgeInsets.all(16.0),
                                                  child: TextField(
                                                    controller: _eventNameTextEditor,
                                                    decoration: InputDecoration(
                                                      hintText: "Event Name",
                                                      filled: true,
                                                      fillColor: Color(0xFFECECEC),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: const BorderSide(width: 3, color: Color(0xFFECECEC)),
                                                        borderRadius: BorderRadius.circular(20),
                                                      ),
                                                    )
                                                  ),
                                                ),
                                                //TOTAL BUDGET TEXT FIELD
                                                Padding(
                                                  padding: const EdgeInsets.all(16.0),
                                                  child: TextField(
                                                    controller: _eventBudgetTextEditor,
                                                    decoration: InputDecoration(
                                                      hintText: "Total Budget",
                                                      filled: true,
                                                      fillColor: Color(0xFFECECEC),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: const BorderSide(width: 3, color: Color(0xFFECECEC)),
                                                        borderRadius: BorderRadius.circular(20),
                                                      ),
                                                    )
                                                  ),
                                                ),

                                                //EVENT DATE BUTTON WITH PICKER
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text("Pick Event Time", style: GoogleFonts.lato(fontWeight: FontWeight.bold)),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: EventTime(),
                                                ),

                                                //START TIME BUTTON WITH PICKER
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text("Pick Event Start Time", style: GoogleFonts.lato(fontWeight: FontWeight.bold)),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: EventStartTime()
                                                ),

                                                //END TIME BUTTON WITH PICKER
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text("Pick Event End Time", style: GoogleFonts.lato(fontWeight: FontWeight.bold)),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: EventEndTime() 
                                                ),

                                                //This listTile contains the Close and Create buttons at the bottom of the popup
                                                ListTile(
                                                  //Close button is leading
                                                  leading: ElevatedButton(
                                                      child: Text("Close", style: GoogleFonts.lato(color: Colors.black)),
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: Color(0xFFBAE365),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10.0)
                                                        )
                                                      ),
                                                      onPressed: (){
                                                      Navigator.pop(context);
                                                      },
                                                    ),

                                                  //Create button is trailing
                                                  trailing: ElevatedButton(
                                                    child: Text("Create", style: GoogleFonts.lato(color: Colors.black)),
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor: Color(0xFFBAE365),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10.0)
                                                        )
                                                    ),
                                                    onPressed: (){
                                                      //Gets info from the text fields here
                                                      var _eventName = _eventNameTextEditor.text;
                                                      var _eventBudget = _eventBudgetTextEditor.text;
                                                      //updates the list with a new widget with info from text fields 
                                                      userEvents.add(_eventName);
                                                      daysLeft.add(dateSelected.difference(dateToday).inDays);
                                                      eventDates.add(dateSelected);
                                                      //returns to the main page with Navigator.pop()
                                                      setState(() {});
                                                      Navigator.pop(context);
                                                    }
                                                  )
                                                ),
                                              ]
                                            ,)
                                          )
                                        ),
                                      ),
                                    ),
                                  );
                                  setState(() {});
                                },
                                //This icon is the plus that's displayed inside the button
                                child: Icon(Icons.add, size: 30)
                              ),
                            )
                          ]
                        ),
                      ),
                    ),
                  ),
                )
              )
            )
          ]
        )
      )
    );
  }
}

//Widget which calls the date picker
class EventTime extends StatefulWidget {
  //const EventsHomePage({Key? key}) : super(key: key);
  @override
  _EventTimeState createState() => _EventTimeState();
}

class _EventTimeState extends State<EventTime>{
  DateTime dateTime = DateTime.now();

  Widget build(BuildContext context){

    Future updateInfo() async{ //for backend

    }

  return ElevatedButton(
        child: Text('${dateTime.year}/${dateTime.month}/${dateTime.day}', style: GoogleFonts.lato(color: Colors.black)),
        onPressed: () async {
          final date = await pickDate();
          if (date == null) return;
          dateSelected = date;
          setState(() => dateTime = date);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFBAE365),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          )
        )
      );
  }
  //shows the date picker
  Future<DateTime?> pickDate() => showDatePicker(
    context: context,
    initialDate: dateTime,
    firstDate: DateTime(1900),
    lastDate: DateTime(2100),
    builder:(context, child) => Theme(
      data: ThemeData().copyWith(
        colorScheme: ColorScheme.light(
          primary: Color(0xFFBAE365),
          onPrimary: Colors.black,
          surface: Color(0xFFECECEC),
          onSurface: Color(0xFFECECEC),
        ),
        dialogBackgroundColor: Color(0xFF657BE3),
        textTheme: TextTheme(
          headline5: GoogleFonts.lato(), // Selected Date landscape
          headline6: GoogleFonts.lato(), // Selected Date portrait
          overline: GoogleFonts.lato(), // Title - SELECT DATE
          bodyText1: GoogleFonts.lato(), // year gridbview picker
          subtitle1: GoogleFonts.lato(color: Colors.black), // input
          subtitle2: GoogleFonts.lato(), // month/year picker
          caption: GoogleFonts.lato(), // days
        ),
      ),
      child: child as Widget,
    ),
  );
}

//Calls the time picker for the event start time
class EventStartTime extends StatefulWidget {
  //const EventsHomePage({Key? key}) : super(key: key);
  @override
  _EventStartTimeState createState() => _EventStartTimeState();
}

class _EventStartTimeState extends State<EventStartTime>{
  TimeOfDay? time = TimeOfDay.now();

  Widget build(BuildContext context){

    Future updateInfo() async{ //for backend

    }

    return ElevatedButton(
      child: Text('${time!.hour.toString()}:${time!.minute.toString()}', style: GoogleFonts.lato(color: Colors.black)),
      onPressed: () async { TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: time!,
      );
      if (newTime != null){
        setState((){
          time = newTime;
        });
      }
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFBAE365),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          )
      )
    );
  }
}

//calls the time picker for the event end time
class EventEndTime extends StatefulWidget {
  @override
  _EventEndTimeState createState() => _EventEndTimeState();
}

class _EventEndTimeState extends State<EventEndTime>{
  TimeOfDay? time = TimeOfDay.now();

  Widget build(BuildContext context){

    Future updateInfo() async{ //for backend

    }

    return ElevatedButton(
      child: Text('${time!.hour.toString()}:${time!.minute.toString()}', style: GoogleFonts.lato(color: Colors.black)),
      onPressed: () async { TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: time!,
        
      );
      if (newTime != null){
        setState((){
          time = newTime;
        });
      }
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFBAE365),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          )
      )
    );
  }
}