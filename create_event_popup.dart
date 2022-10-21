import 'package:flutter/material.dart';
import "events_home_page.dart";

class CreateEventPopup extends StatefulWidget{
  @override
  _CreateEventPopupState createState() => _CreateEventPopupState();
}

class _CreateEventPopupState extends State<CreateEventPopup> {

  TextEditingController _eventNameTextEditor = TextEditingController();
  TextEditingController _eventDateTextEditor = TextEditingController();
  TextEditingController _eventBudgetTextEditor = TextEditingController();
  TextEditingController _eventStartTimeTextEditor = TextEditingController();
  TextEditingController _eventEndTimeTextEditor = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Container(
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
            Text("New Event", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

            //EVENT NAME TEXT FIELD

            Padding(
              padding: const EdgeInsets.all(8.0),
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

            //EVENT DATE TEXT FIELD

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _eventDateTextEditor,
                decoration: InputDecoration(
                  hintText: "Event Date",
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
              padding: const EdgeInsets.all(8.0),
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

            //START TIME TEXT FIELD

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _eventStartTimeTextEditor,
                decoration: InputDecoration(
                  hintText: "Event Start Time",
                  filled: true,
                  fillColor: Color(0xFFECECEC),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 3, color: Color(0xFFECECEC)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                )
              ),
            ),

            //END TIME TEXT FIELD

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _eventEndTimeTextEditor,
                decoration: InputDecoration(
                  hintText: "Event End Time",
                  filled: true,
                  fillColor: Color(0xFFECECEC),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 3, color: Color(0xFFECECEC)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                )
              ),
            ),

            //This listTile contains the Close and Create buttons at the bottom of the popup

            ListTile(
              //Close button is leading
              leading: TextButton(
                  child: Text("Close"),
                  onPressed: (){
                   Navigator.pop(context);
                  },
                ),

              //Create button is trailing
              trailing: TextButton(
                child: Text("Create"),
                onPressed: (){
                  //Gets info from the text fields here
                  var _eventName = _eventNameTextEditor.text;
                  var _eventDate = _eventDateTextEditor.text;
                  var _eventBudget = _eventBudgetTextEditor.text;
                  var _eventStartTime = _eventStartTimeTextEditor.text;
                  var _eventEndTime = _eventStartTimeTextEditor.text;
                  //updates the list with a new widget with info from text fields 
                  userEvents.add(EventWidget(title: _eventName, date: _eventDate, daysLeft: "2"));
                  //returns to the main page with Navigator.pop()
                  Navigator.pop(context);
                  setState(() {});
                }
              )
            ),
          ]
        ,)
      )
    );
  }
}