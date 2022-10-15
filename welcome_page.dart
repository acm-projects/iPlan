import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {

  Widget build(BuildContext context){
    return  MaterialApp(
      title: 'Welcome Page',
      home: Scaffold(
        backgroundColor: Color(0xFF657BE3),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  //Calls welcome title widget which says "Welcome to"
                  padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 15.0),
                  child: WelcomeTitle()),
                Padding(
                  padding: const EdgeInsets.fromLTRB(80.0, 0.0, 80.0, 0.0),
                  child: ListTile(
                    //The green circle with future logo and iPlan text
                    leading: CircleAvatar(radius: 40, backgroundColor: Color(0xFFBAE365)),
                    trailing: Text('iPlan', style: TextStyle(fontSize: 50.0, color: Color(0xFFFEF7EC), fontWeight: FontWeight.bold))
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 20.0),
                  child: Center(
                    //Log in button
                    child: ElevatedButton(
                      child: Text("Log in", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)
                        ),
                        fixedSize: Size(350, 50),
                        primary: Color(0xFFBAE365),
                      )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  child: Center(
                    //Sign up button
                    child: ElevatedButton(
                      child: Text("Sign up", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)
                        ),
                        fixedSize: Size(350, 50),
                        primary: Color(0xFFBAE365),
                      )
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}


class WelcomeTitle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text.rich(TextSpan(text: '', children: [
        TextSpan(
          text: 'Welcome to', 
          style: TextStyle(fontSize: 25.0, color: Color(0xFFFEF7EC), fontWeight: FontWeight.bold)),
      ],),),
    );
  }
}