import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//2 separate lists so that each is displayed under the correct dividor down below
//userTimesBeforeEvent is the list that contains the times before the event starts
List<TimeOfDay> userTimesBeforeEventTime = [TimeOfDay(hour: 8, minute: 30), TimeOfDay(hour: 9, minute: 30)];
List<String> userTimesBeforeEventDescription = ["Start time", "Set up"];
//userTimesDuringEvent is the list that contains the times after the event starts
List<TimeOfDay> userTimesDuringEventTime = [TimeOfDay(hour: 16, minute: 30), TimeOfDay(hour: 17, minute: 30)];
List<String> userTimesDuringEventDescription = ["Start time", "Set up"];
//This is the title of the page
const title = 'Staff Beach Party';
TimeOfDay _timeOfDay = TimeOfDay.now();
TimeOfDay eventStartTime = TimeOfDay(hour: 16, minute: 15);

class ItineraryPage extends StatefulWidget {
  const ItineraryPage({Key? key}) : super(key: key);
  @override
  _ItineraryPageState createState() => _ItineraryPageState();
}

class _ItineraryPageState extends State<ItineraryPage>{

  TextEditingController _eventTimeTextEditor = TextEditingController();
  TextEditingController _eventDescriptionTextEditor = TextEditingController();

  Widget build(BuildContext context){

    Future updateInfo() async{ //for backend

    }

    return  MaterialApp(
      title: 'Itinerary Page',
      home: Scaffold(
        backgroundColor: Color(0xFF657BE3),
        body: Center(
          child: Center(
            child: Column(
              children: <Widget>[
                 Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 5.0),
                  child: Center(
                    child: Text(title, style: GoogleFonts.lato(fontSize: 40.0, color: Color(0xFFFEF7EC), fontWeight: FontWeight.bold)),
                  )
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                  child: Center(
                    child: Container(
                      height: 610.0,
                      color: Colors.transparent,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFFEF7EC),
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(20.0),
                            topRight: const Radius.circular(20.0),
                          )
                        ),
                          //The Column child inside of the SizedBox is what will hold the rest of the widgets inside the WhiteSquare
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                                child: SizedBox(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        //This container is the Event Setup dividor which goes before the userTimesBeforeEvent list
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Color(0xFF65BAE3)
                                            ),
                                            color: Color(0xFF65BAE3),
                                            borderRadius: BorderRadius.all(Radius.circular(15))
                                          ),
                                          height: 25,
                                          width: 300,
                                          child: Center(child: Text("Event Setup", style: GoogleFonts.lato()))
                                        ),
                                      ),
                                      //This list view contains the userTimesBeforeEvent list
                                      Expanded(
                                        child: Container(
                                          child: ListView.builder(
                                            itemCount: userTimesBeforeEventTime.length,
                                            itemBuilder: (context, index){
                                              return Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(1.0),
                                                  child: Row(
                                                    children:[
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text(displayTimeBefore(index), style: GoogleFonts.lato(color: Colors.grey)),
                                                      ), 
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: CircleAvatar(radius: 12, backgroundColor: Color(0xFFBAE365)),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text(userTimesBeforeEventDescription[index], style: GoogleFonts.lato(color: Colors.black)),
                                                      ),
                                                    ]
                                                  )
                                                )
                                              );
                                            }
                                          
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        //This container is the Event Start dividor which goes before the userTimesDuringEvent list
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Color(0xFF65BAE3)
                                            ),
                                            color: Color(0xFF65BAE3),
                                            borderRadius: BorderRadius.all(Radius.circular(15))
                                          ),
                                          height: 25,
                                          width: 300,
                                          child: Center(child: Text("Event Start", style: GoogleFonts.lato()))
                                        ),
                                      ),
                                      //This list view contains the userTimesDuringEvent list
                                      Expanded(
                                        child: Container(
                                          child: ListView.builder(
                                            itemCount: userTimesDuringEventTime.length,
                                            itemBuilder: (context, index){
                                              return Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(1.0),
                                                  child: Row(
                                                    children:[
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text(displayTimeDuring(index), style: GoogleFonts.lato(color: Colors.grey)),
                                                      ), 
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: CircleAvatar(radius: 12, backgroundColor: Color(0xFFBAE365)),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text(userTimesDuringEventDescription[index], style: GoogleFonts.lato(color: Colors.black)),
                                                      ),
                                                    ]
                                                  )
                                                )
                                              );
                                            }
                                          
                                          )
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        //This container is the final dividor under both the lists and the dividors
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Color(0xFF65BAE3)
                                            ),
                                            color: Color(0xFF65BAE3),
                                            borderRadius: BorderRadius.all(Radius.circular(15))
                                          ),
                                          height: 25,
                                          width: 300,
                                          child: Center(child: Text("Event End", style: GoogleFonts.lato()))
                                        ),
                                      ),
                                    //This is the add button that goes at the very bottom
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(275.0, 20.0, 0.0, 10.0),
                                      child: FloatingActionButton(
                                        backgroundColor: Color(0xFFBAE365),
                                        onPressed: (){
                                          //When the button is clicked, displays the CreateTimePopup
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
                                                        Text("New Time Slot", style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold)),
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child:  EventTime(),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: TextField(
                                                            controller: _eventDescriptionTextEditor,
                                                            decoration: InputDecoration(
                                                              hintText: "Event Description",
                                                              filled: true,
                                                              fillColor: Color(0xFFECECEC),
                                                              enabledBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 3, color: Color(0xFFECECEC)),
                                                                borderRadius: BorderRadius.circular(20),
                                                              ),
                                                            )
                                                          ),
                                                        ),
                                                        ListTile(
                                                          leading: TextButton(
                                                              child: Text("Close", style: GoogleFonts.lato()),
                                                              onPressed: (){
                                                              Navigator.pop(context);
                                                              },
                                                            ),
                                                          trailing: TextButton( 
                                                            child: Text("Create", style: GoogleFonts.lato()),
                                                            onPressed: (){
                                                              var _eventDescription = _eventDescriptionTextEditor.text;
                                                              addTime(_timeOfDay, _eventDescription);
                                                              setState(() {});
                                                              Navigator.pop(context);
                                                            }
                                                            ),
                                                        ),
                                                      ]
                                                    ),
                                                  )
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Icon(Icons.add)
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
        ),

        //Navigation Bar with Icons
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.house, color: Colors.black, size: 30),
                  label: 'home',
                  backgroundColor: Color(0xFFA3B0EB)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person, color: Colors.black, size: 30),
                  label: 'collaborate',
                  backgroundColor: Color(0xFFA3B0EB)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.list, color: Colors.black, size: 30),
                  label: 'itinerary',
                  backgroundColor: Color(0xFFA3B0EB)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month,
                      color: Colors.black, size: 30),
                  label: 'calendar',
                  backgroundColor: Color(0xFFA3B0EB)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings, color: Colors.black, size: 30),
                  label: 'settings',
                  backgroundColor: Color(0xFFA3B0EB))
            ]),
      ),
    );
  }
}

//calls the time picker for the event time and updates the button with the picked time
class EventTime extends StatefulWidget {
  @override
  _EventTimeState createState() => _EventTimeState();
}

class _EventTimeState extends State<EventTime>{
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
          _timeOfDay = newTime;
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

//This method properly formats the times displayed by adding an extra 0 so the entire widget doesn't shift
//This method is for the userTimesBeforeEventTime list
String displayTimeBefore(int index){
  String displayTime = "";
    if(userTimesBeforeEventTime[index].hour < 10){
      displayTime += "0";
      displayTime += '${userTimesBeforeEventTime[index].hour.toString()}:';
    }
    else{
      displayTime += '${userTimesBeforeEventTime[index].hour.toString()}:${userTimesBeforeEventTime[index].minute.toString()}';
    }
    if(userTimesBeforeEventTime[index].minute < 10){
      displayTime += "0";
      displayTime += '${userTimesBeforeEventTime[index].minute.toString()}';
    }
    else{
      displayTime += '${userTimesBeforeEventTime[index].minute.toString()}';
    }
    return displayTime;
}

//This method properly formats the times displayed by adding an extra 0 so the entire widget doesn't shift
//This method is for the userTimesDuringEventTime list
String displayTimeDuring(int index){
  String displayTime = "";
    if(userTimesDuringEventTime[index].hour < 10){
      displayTime += "0";
      displayTime += '${userTimesDuringEventTime[index].hour.toString()}:';
    }
    else{
      displayTime += '${userTimesDuringEventTime[index].hour.toString()}:';
    }
    if(userTimesDuringEventTime[index].minute < 10){
      displayTime += "0";
      displayTime += '${userTimesDuringEventTime[index].minute.toString()}';
    }
    else{
      displayTime += '${userTimesDuringEventTime[index].minute.toString()}';
    }
    return displayTime;
}

//This method adds the new time widget in the correct position and in the correct list
void addTime(TimeOfDay time, String description){
  bool added = false;
  int beforeLength = userTimesBeforeEventTime.length;
  int duringLength = userTimesBeforeEventTime.length;
  if(time.hour < eventStartTime.hour || (time.hour == eventStartTime.hour && time.minute < eventStartTime.minute)){
    int count = 0;
    while(added == false && count < beforeLength){
      if(time.hour < userTimesBeforeEventTime[count].hour || (time.hour == userTimesBeforeEventTime[count].hour && time.minute < userTimesBeforeEventTime[count].minute)){
        userTimesBeforeEventTime.insert(count, time);
        userTimesBeforeEventDescription.insert(count, description);
        added = true;
      }
      count++;
    }
    if(!added){
      userTimesBeforeEventTime.add(time);
      userTimesBeforeEventDescription.add(description);
    }
  }
  else{
    int count = 0;
    while(added == false && count < duringLength){
      if(time.hour < userTimesDuringEventTime[count].hour || (time.hour == userTimesDuringEventTime[count].hour && time.minute < userTimesDuringEventTime[count].minute)){
        userTimesDuringEventTime.insert(count, time);
        userTimesDuringEventDescription.insert(count, description);
        added = true;
      }
      count++;
    }
    if(!added){
      userTimesDuringEventTime.add(time);
      userTimesDuringEventDescription.add(description);
    }
  }
}