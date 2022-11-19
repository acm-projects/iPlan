import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Backend/Authentication/update_files.dart';
import '../../Backend/Event_Manager/event.dart';
import '../../Backend/Itinerary/itinerary_item.dart';
import '../../Backend/Itinerary/itinerary_page.dart';
import '../../Backend/User_Creation/user.dart';

/// @author [MatthewSheldon] the [User] object that will get updated
late User _user;

/// @author [MatthewSheldon] the [Event] object that will get updated
late Event _event;

/// tasksBeforeEvent is the list that contains the times and descriptions of tasks before the event starts
late List<ItineraryItem> _tasksBeforeEvent;

/// tasksDuringEvent is the list that contains the times and descriptions of tasks after the event starts
late List<ItineraryItem> _tasksDuringEvent;

/// This is the title of the page
late String _title;

TimeOfDay _timeOfDay = TimeOfDay.now();
TimeOfDay eventStartTime = TimeOfDay(hour: 16, minute: 15);

///Made gloabl to make accessibility easier
late ItineraryPage _itineraryPage;

/// @author [MatthewSheldon]
/// Used to update the [Event] object in the cloud
void _updateEventObject() async {
  _event.updateItineraryPage(itineraryPage: _itineraryPage);
  _user.updateEvent(eventID: _event.getLink(), event: _event);
  await UpdateFiles.updateEventFile(
      documentID: _event.getLink(), json: _event.toJson());
}

// the method that connects the front-end and back-end lists called as stuff is being changed
void _buildSelectedItemsFromItineraryPage() {
  _tasksBeforeEvent = _itineraryPage.getTasksBefore();
  _tasksDuringEvent = _itineraryPage.getTasksDuring();
}

class Itinerary extends StatefulWidget {
  ///Constructor for the itinerary
  Itinerary({super.key, required User user, required Event event}) {
    _user = user;
    _event = event;
    _title = event.getEventName();
    _itineraryPage = _event.getItineraryPage();
    _buildSelectedItemsFromItineraryPage();
  }

  @override
  _ItineraryState createState() => _ItineraryState();
}

class _ItineraryState extends State<Itinerary> {
  TextEditingController _eventTimeTextEditor = TextEditingController();
  TextEditingController _eventDescriptionTextEditor = TextEditingController();

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Future updateInfo() async {
      //for backend
    }

    return Scaffold(
        backgroundColor: Color(0xFF657BE3),
        body: Center(
            child: Center(
                child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                child: Center(
                  child: Text(_event.getEventName(),
                      style: GoogleFonts.lato(
                          fontSize: 50.0,
                          color: Color(0xFFFEF7EC),
                          fontWeight: FontWeight.bold)),
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(0.0, 9.0, 0.0, 0.0),
                child: Center(
                    child: Container(
                  height: size.height - 229,
                  color: Colors.transparent,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color(0xFFFEF7EC),
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(20.0),
                          topRight: const Radius.circular(20.0),
                        )),
                    //The Column child inside of the SizedBox is what will hold the rest of the widgets inside the WhiteSquare
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                      child: SizedBox(
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            //This container is the Event Setup dividor which goes before the userTimesBeforeEvent list
                            child: Container(
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xFF65BAE3)),
                                    color: Color(0xFF65BAE3),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                height: 25,
                                width: 300,
                                child: Center(
                                    child: Text("Event Setup",
                                        style: GoogleFonts.lato()))),
                          ),
                          //This list view contains the userTimesBeforeEvent list
                          Expanded(
                            child: Container(
                              child: ListView.builder(
                                  itemCount: _tasksBeforeEvent.length,
                                  itemBuilder: (context, index) {
                                    return Center(
                                        child: Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: Row(children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                    displayTimeBefore(index),
                                                    style: GoogleFonts.lato(
                                                        color: Colors.grey)),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundColor:
                                                        Color(0xFFBAE365)),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                    _tasksBeforeEvent[index]
                                                        .getItemName(),
                                                    style: GoogleFonts.lato(
                                                        color: Colors.black)),
                                              ),
                                            ])));
                                  }),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            //This container is the Event Start dividor which goes before the userTimesDuringEvent list
                            child: Container(
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xFF65BAE3)),
                                    color: Color(0xFF65BAE3),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                height: 25,
                                width: 300,
                                child: Center(
                                    child: Text("Event Start",
                                        style: GoogleFonts.lato()))),
                          ),
                          //This list view contains the userTimesDuringEvent list
                          Expanded(
                            child: Container(
                                child: ListView.builder(
                                    itemCount: _tasksDuringEvent.length,
                                    itemBuilder: (context, index) {
                                      return Center(
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(1.0),
                                              child: Row(children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      displayTimeDuring(index),
                                                      style: GoogleFonts.lato(
                                                          color: Colors.grey)),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: CircleAvatar(
                                                      radius: 12,
                                                      backgroundColor:
                                                          Color(0xFFBAE365)),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      _tasksDuringEvent[index]
                                                          .getItemName(),
                                                      style: GoogleFonts.lato(
                                                          color: Colors.black)),
                                                ),
                                              ])));
                                    })),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            //This container is the final dividor under both the lists and the dividors
                            child: Container(
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xFF65BAE3)),
                                    color: Color(0xFF65BAE3),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                height: 25,
                                width: 300,
                                child: Center(
                                    child: Text("Event End",
                                        style: GoogleFonts.lato()))),
                          ),
                          //This is the add button that goes at the very bottom
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(275.0, 20.0, 20.0, 10.0),
                            child: FloatingActionButton.extended(
        heroTag: 'itinerary1',
        onPressed: () {
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
                              onPressed: () {
                                _eventTimeTextEditor.clear();
					  _eventDescriptionTextEditor.clear();
                                Navigator.pop(context);
                              },
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Add Timeslot",
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
                                var _eventDescription =
                                                            _eventDescriptionTextEditor
                                                                .text;
                                                        // addTime(_timeOfDay, _eventDescription); Cassis method that was here before
                                                        //adds the thing to the itinerary item
                                                        _itineraryPage
                                                            .addItineraryItem(
                                                                description:
                                                                    _eventDescription,
                                                                time:
                                                                    _timeOfDay);
                                                        // the method that connects the front-end and back-end lists called as stuff is being changed
                                                        _buildSelectedItemsFromItineraryPage();
                                                        _updateEventObject();
                                                        setState(() {});
                                                        Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                        //timeslot name
                        Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(254, 247, 236, 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: TextField(
                              controller: _eventDescriptionTextEditor,
                              style: GoogleFonts.lato(
                                color: Colors.black,
                              ),
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Timeslot Name',
                                prefixIcon: Icon(
                                  Icons.event_available,
                                  color: Color(0xFF657BE3),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        //select time
                        EventTime(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        label: Text(
          "Add Time",
          style: GoogleFonts.lato(),
        ),
        icon: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(186, 227, 101, 1),
        foregroundColor: Colors.black,
      ),
                                
                          )
                        ]),
                      ),
                    ),
                  ),
                )))
          ],
        ))),
      );
  }
}

//calls the time picker for the event time and updates the button with the picked time
class EventTime extends StatefulWidget {
  @override
  _EventTimeState createState() => _EventTimeState();
}

class _EventTimeState extends State<EventTime> {
  TimeOfDay? time = TimeOfDay.now();

  Widget build(BuildContext context) {
    Future updateInfo() async {}

    return ElevatedButton(
        child: Text('${time!.hour.toString()}:${time!.minute.toString()}',
            style: GoogleFonts.lato(color: Colors.black)),
        onPressed: () async {
          TimeOfDay? newTime = await showTimePicker(
            context: context,
            initialTime: time!,
          );
          if (newTime != null) {
            setState(() {
              time = newTime;
              _timeOfDay = newTime;
            });
          }
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFBAE365),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))));
  }
}

//This method properly formats the times displayed by adding an extra 0 so the entire widget doesn't shift
//This method is for the userTimesBeforeEventTime list
String displayTimeBefore(int index) {
  int hour = _tasksBeforeEvent[index].getItemTime().hour;
  int minute = _tasksBeforeEvent[index].getItemTime().minute;
  return "${((hour > 10) ? "$hour" : "0$hour")}:${((minute > 10) ? "$minute" : "0$minute")}";
}

//This method properly formats the times displayed by adding an extra 0 so the entire widget doesn't shift
//This method is for the userTimesDuringEventTime list
String displayTimeDuring(int index) {
  int hour = _tasksDuringEvent[index].getItemTime().hour;
  int minute = _tasksDuringEvent[index].getItemTime().minute;
  return "${((hour > 10) ? "$hour" : "0$hour")}:${((minute > 10) ? "$minute" : "0$minute")}";
}
