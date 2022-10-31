import 'package:flutter/material.dart';
import "itinerary_page.dart";

class CreateTimePopup extends StatefulWidget{
  @override
  _CreateTimePopupState createState() => _CreateTimePopupState();
}

class _CreateTimePopupState extends State<CreateTimePopup> {

  TextEditingController _eventTimeTextEditor = TextEditingController();
  TextEditingController _eventDescriptionTextEditor = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Container(
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
            Text("New Time Slot", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _eventTimeTextEditor,
                decoration: InputDecoration(
                  hintText: "Event Time",
                  filled: true,
                  fillColor: Color(0xFFECECEC),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 3, color: Color(0xFFECECEC)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                )
              ),
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
                  child: Text("Close"),
                  onPressed: (){
                   Navigator.pop(context);
                  },
                ),
              trailing: TextButton( 
                child: Text("Create"),
                onPressed: (){
                  var _eventTime = _eventTimeTextEditor.text;
                  var _eventDescription = _eventDescriptionTextEditor.text;
                  userTimesDuringEvent.add(TimeWidget(time: _eventTime, description: _eventDescription));
                  Navigator.pop(context);
                }
                ),
            ),
          ]
        ),
      )
    );
  }
}