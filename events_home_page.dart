/*
  TO FIX - Have the page update after creating a new EventWidget. Right now this only happens after you click on another
  EventWidget on the emulator.

  TO FIX - Make the view scrollable so the user can add more than 4 widgets and be able to display all properly without the 
  add button being shifted. Right now, there is an error when I attempt to make the view scrollable.
*/

import 'package:flutter/material.dart';
import 'create_event_popup.dart';

List<EventWidget> userEvents = [EventWidget(title: "Staff Beach Party", date: "04/15/2022", daysLeft: "2"), EventWidget(title: "Baby Shower", date: "04/30/2022", daysLeft: "5"),EventWidget(title: "Another Party", date: "05/15/2022", daysLeft: "10")];

class EventsHomePage extends StatelessWidget {

  Widget build(BuildContext context){
    return  MaterialApp(
      title: 'Events Home Page',
      home: Scaffold(
        backgroundColor: Color(0xFF657BE3),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 5.0),
                  //Calls the title widget which sits at the top
                  child: EventsPageTitle()
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                  //Calls the WhiteSquare widget which holds all other widgets
                  child: WhiteSquare()
                )
              ]
            )
          )
        ),
      ),
    );
  }
}

//Text widget with style inside TextSpan()
class EventsPageTitle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text.rich(TextSpan(text: '', children: [
        TextSpan(
          text: 'Events', 
          style: TextStyle(fontSize: 50.0, color: Color(0xFFFEF7EC), fontWeight: FontWeight.bold)),
      ],),),
    );
  }
}

//Container that holds all other widgets
class WhiteSquare extends StatefulWidget{
  @override
  _WhiteSquareState createState() => _WhiteSquareState();
}

class _WhiteSquareState extends State<WhiteSquare> {

//class WhiteSquare extends StatefulWidget{
  
  @override
  Widget build(BuildContext context) {
    return Center(
      //This child is the container that holds the white square container
      child: Container(
        height: 660.0,
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
                                child: ListView(
                                  children: userEvents,
                                  //key: Key(randomString()),
                                ),
                              ),
                            ),
                       //This is the green add button         
                      Padding(
                        padding: EdgeInsets.fromLTRB(275.0, 60.0, 0.0, 20.0),
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
                                  child: CreateEventPopup(),
                                ),
                              ),
                            );
                            setState(() {});
                          },
                          //This icon is the plus that's displayed inside the button
                          child: Icon(Icons.add)
                        ),
                      )
                      ]
                    ),
                  ),
            ),
        ),
      )
    );
  }
}
  


class EventWidget extends StatelessWidget {

  String title, date, daysLeft;

  EventWidget({
    //Must provide a title, date, and days left which are added to the widget elements below
    required this.title,
    required this.date,
    required this.daysLeft
  });
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
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
                  Text(daysLeft, style: TextStyle(color: Color(0xFFFEF7EC), fontSize: 25)),), 
                  Text("days left", style: TextStyle(color: Color(0xFFFEF7EC), fontSize: 10))]), radius: 30, backgroundColor: Color(0xFF657BE3)),
          //This is the event name the user provided
          title: Text(title),
          //This is the date the user provided
          subtitle: Text(date, style: TextStyle(color: Colors.black)),
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
    );
  }
}

