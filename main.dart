import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class CollaborateTitle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const Center(
            child: Text.rich(TextSpan(text: '', children: [
            TextSpan(
              text: 'Collaborate', 
              style: TextStyle(fontSize: 50.0, color: Color(0xFFFEF7EC), fontWeight: FontWeight.bold)),
                ],
              ), 
            ),
          );
  }
}

class WhiteSquare extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
            height: 600.0,
            color: Colors.transparent,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFEF7EC),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20.0),
                  topRight: const Radius.circular(20.0),
                )
              ),
              child: ListView(
                children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 15.0),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                            width: 5,
                            color: Color(0xFF657BE3)
                          ),
                        ),
                        child: Column(children: [
                          Text("Event Name", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          Text("April 25, 2022")
                        ],)
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                      child: const Text.rich(TextSpan(text: '', children: [
                        TextSpan(
                          text: 'Share Invitation', 
                          style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w400)),
                      ],
                      ), 
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        
                        decoration: InputDecoration(
                          labelText: 'Search Contacts',
                          filled: true,
                          fillColor: Color(0xFFECECEC),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 3, color: Color(0xFFECECEC)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        )
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [ const ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 40.0),
                        leading: CircleAvatar(radius: 20, backgroundColor: Colors.grey, child:Icon(Icons.person, color: Color(0xFFFEF7EC))),
                        title: Text("Contact 1"),
                        subtitle: Text("123-456-7891"),
                        trailing: Text("Collaborator")
                      ),
                      ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 40.0),
                    leading: CircleAvatar(radius: 20, backgroundColor: Colors.grey, child:Icon(Icons.person, color: Color(0xFFFEF7EC))),
                    title: Text("Contact 2"),
                    subtitle: Text("123-456-7891"),
                    trailing: Wrap(
                      spacing: 2,
                      children: const <Widget>[
                        Icon(Icons.check, color: Colors.black, size: 17),
                        Text("Invited"),
                      ],
                    ),
                  ),
                   ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 40.0),
                    leading: CircleAvatar(radius: 20, backgroundColor: Colors.grey, child:Icon(Icons.person, color: Color(0xFFFEF7EC))),
                    title: Text("Contact 3"),
                    subtitle: Text("123-456-7891"),
                    trailing: Wrap(
                      spacing: 2,
                      children: const <Widget>[
                        Icon(Icons.check, color: Colors.black, size: 17),
                        Text("Invited"),
                      ],
                    ),
                  ),
                   ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 40.0),
                    leading: CircleAvatar(radius: 20, backgroundColor: Colors.grey, child:Icon(Icons.person, color: Color(0xFFFEF7EC))),
                    title: Text("Contact 4"),
                    subtitle: Text("123-456-7891"),
                    trailing: Wrap(
                      spacing: 2,
                      children: const <Widget>[
                        Icon(Icons.check, color: Colors.black, size: 17),
                        Text("Invited"),
                      ],
                    ),
                  ),
                   ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 40.0),
                    leading: CircleAvatar(radius: 20, backgroundColor: Colors.grey, child:Icon(Icons.person, color: Color(0xFFFEF7EC))),
                    title: Text("Contact 5"),
                    subtitle: Text("123-456-7891"),
                    trailing: Wrap(
                      spacing: 2,
                      children: const <Widget>[
                        Icon(Icons.check, color: Colors.black, size: 17),
                        Text("Invited"),
                      ],
                    ),
                  )
                      ]
                    ),
                  ),
                  
                  Center(
                    child: ElevatedButton(
                        child: Row(
                          children: [
                            Icon(Icons.link, size: 25, color: Colors.black),
                            Text("     Copy Link", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black))
                          ]
                        ),
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)
                          ),
                          fixedSize: Size(190, 30),
                          primary: Color(0xFFBAE365),
                        )
                    ),
                  )
                ]
              )
            )
          );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
      title: 'My Flutter App',
      home: Scaffold(
        backgroundColor: Color(0xFF657BE3),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 5.0),
                  //widget that has title of page
                  child: CollaborateTitle()
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 9.0, 0.0, 0.0),
                  //container widget that includes all other widgets
                  child: WhiteSquare()
                ),
              ],
            ),
          ),
        ),

        //Navigation Bar with Icons
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.house, color: Colors.black, size: 30), label: 'home', backgroundColor: Color(0xFFA3B0EB)),
            BottomNavigationBarItem(icon: Icon(Icons.person, color: Colors.black, size: 30), label: 'collaborate', backgroundColor: Color(0xFFA3B0EB)),
            BottomNavigationBarItem(icon: Icon(Icons.list, color: Colors.black, size: 30), label: 'itinerary', backgroundColor: Color(0xFFA3B0EB)),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_month, color: Colors.black, size: 30), label: 'calendar', backgroundColor: Color(0xFFA3B0EB)),
            BottomNavigationBarItem(icon: Icon(Icons.settings, color: Colors.black, size: 30), label: 'settings', backgroundColor: Color(0xFFA3B0EB))
        ]),
        )
      );
  }
}