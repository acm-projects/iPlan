import 'package:flutter/material.dart';
import 'create_time_popup.dart';

//2 separate lists so that each is displayed under the correct dividor down below
//userTimesBeforeEvent is the list that contains the times before the event starts
List<TimeWidget> userTimesBeforeEvent = [TimeWidget(time: "08:30 am", description: "Start time"), TimeWidget(time: "09:30 am", description: "Set up"), TimeWidget(time: "12:30 pm", description: "time to eat"), TimeWidget(time: "12:30 pm", description: "time to eat"), TimeWidget(time: "12:30 pm", description: "time to eat")];
//userTimesDuringEvent is the list that contains the times after the event starts
List<TimeWidget> userTimesDuringEvent = [TimeWidget(time: "03:30 am", description: "Start time"), TimeWidget(time: "09:30 am", description: "Set up")];
//This is the title of the page
const title = 'Staff Beach Party';

class ItineraryPage extends StatelessWidget {

  Widget build(BuildContext context){
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
                  child: ItineraryPageTitle()
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                  child: WhiteSquare()
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

class ItineraryPageTitle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text.rich(TextSpan(text: '', children: [
        TextSpan(
          text: title, 
          style: TextStyle(fontSize: 40.0, color: Color(0xFFFEF7EC), fontWeight: FontWeight.bold)),
      ],),),
    );
  }
}

class WhiteSquare extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    //WhiteSquare container with decorations 
    return Center(
      child: Container(
        height: 611.0,
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
                    //height: 1000,
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
                            child: Center(child: Text("Event Setup"))
                          ),
                        ),
                        //This list view contains the userTimesBeforeEvent list
                        Expanded(
                          child: Container(
                            child: ListView(
                              children: userTimesBeforeEvent
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
                            child: Center(child: Text("Event Start"))
                          ),
                        ),
                        //This list view contains the userTimesDuringEvent list
                        Expanded(
                          child: Container(
                            child: ListView(
                              children: userTimesDuringEvent
                            ),
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
                            child: Center(child: Text("Event End"))
                          ),
                        ),
                      //This is the add button that goes at the very bottom
                      Padding(
                        padding: EdgeInsets.fromLTRB(275.0, 20.0, 0.0, 80.0),
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
                                  child: CreateTimePopup(),
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
    );
  }
}

class TimeWidget extends StatelessWidget {

  String time, description;

  TimeWidget({
    required this.time,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Row(
          children:[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(time, style: TextStyle(color: Colors.grey)),
            ), 
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(radius: 15, backgroundColor: Color(0xFFBAE365)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(description, style: TextStyle(color: Colors.black)),
            ),
          ]
        )
      )
    );
  }
}

