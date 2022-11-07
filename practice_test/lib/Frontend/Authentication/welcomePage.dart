/// Welcome Page

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login.dart';
import 'register.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return  MaterialApp(
        title: 'Welcome Page',
        home: Scaffold(
          backgroundColor: Color(0xFF657BE3),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text(
                    "Welcome to",
                    style: GoogleFonts.lato(
                      color: Color(0xFFFEF7EC),
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "iPlan",
                    style: GoogleFonts.lato(
                      color: Color(0xFFFEF7EC),
                      fontSize: 75.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  //TODO: replace with logo
                  Icon(
                    color: Color(0xFFBAE365),
                    Icons.circle_rounded,
                    size: 150,
                  ),
                  SizedBox(height: 15),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 35.0),
                    width: double.infinity,
                    child: FloatingActionButton(
                      heroTag: "btn1",
                      onPressed: (){
                        print("hi");
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                      },
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      backgroundColor: Color(0xFFBAE365),
                      child: Text(
                        'Log in',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 35.0),
                    width: double.infinity,
                    child: FloatingActionButton(
                      heroTag: "btn2",
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                      },
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      backgroundColor: Color(0xFFBAE365),
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
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