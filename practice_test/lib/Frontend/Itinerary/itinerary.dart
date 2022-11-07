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
                                EdgeInsets.fromLTRB(275.0, 20.0, 0.0, 10.0),
                            child: FloatingActionButton(
                                backgroundColor: Color(0xFFBAE365),
                                heroTag: "itinerary1",
                                onPressed: () {
                                  //When the button is clicked, displays the CreateTimePopup
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) => SingleChildScrollView(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        child: Container(
                                            color: Color(0xFF757575),
                                            child: Container(
                                              padding: EdgeInsets.all(20.0),
                                              decoration: BoxDecoration(
                                                color: Color(0xFFFEF7EC),
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20.0),
                                                    topRight:
                                                        Radius.circular(20.0)),
                                              ),
                                              child: Column(children: [
                                                Text("New Time Slot",
                                                    style: GoogleFonts.lato(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: EventTime(),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextField(
                                                      controller:
                                                          _eventDescriptionTextEditor,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            "Event Description",
                                                        filled: true,
                                                        fillColor:
                                                            Color(0xFFECECEC),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 3,
                                                                  color: Color(
                                                                      0xFFECECEC)),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                      )),
                                                ),
                                                ListTile(
                                                  leading: TextButton(
                                                    child: Text("Close",
                                                        style:
                                                            GoogleFonts.lato()),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  trailing: TextButton(
                                                      child: Text("Create",
                                                          style: GoogleFonts
                                                              .lato()),
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
                                                      }),
                                                ),
                                              ]),
                                            )),
                                      ),
                                    ),
                                  );
                                },
                                child: Icon(Icons.add)),
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
  String displayTime = "";
  if (_tasksBeforeEvent[index].getItemTime().hour < 10) {
    displayTime += "0";
    displayTime += '${_tasksBeforeEvent[index].getItemTime().hour.toString()}:';
  } else {
    displayTime +=
        '${_tasksBeforeEvent[index].getItemTime().hour.toString()}:${_tasksBeforeEvent[index].getItemTime().minute.toString()}';
  }
  if (_tasksBeforeEvent[index].getItemTime().minute < 10) {
    displayTime += "0";
    displayTime +=
        '${_tasksBeforeEvent[index].getItemTime().minute.toString()}';
  } else {
    displayTime +=
        '${_tasksBeforeEvent[index].getItemTime().minute.toString()}';
  }
  return displayTime;
}

//This method properly formats the times displayed by adding an extra 0 so the entire widget doesn't shift
//This method is for the userTimesDuringEventTime list
String displayTimeDuring(int index) {
  String displayTime = "";
  if (_tasksDuringEvent[index].getItemTime().hour < 10) {
    displayTime += "0";
    displayTime += '${_tasksDuringEvent[index].getItemTime().hour.toString()}:';
  } else {
    displayTime += '${_tasksDuringEvent[index].getItemTime().hour.toString()}:';
  }
  if (_tasksDuringEvent[index].getItemTime().minute < 10) {
    displayTime += "0";
    displayTime +=
        '${_tasksDuringEvent[index].getItemTime().minute.toString()}';
  } else {
    displayTime +=
        '${_tasksDuringEvent[index].getItemTime().minute.toString()}';
  }
  return displayTime;
}
