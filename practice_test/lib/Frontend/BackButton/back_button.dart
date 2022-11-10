import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BackButtonWidget extends StatefulWidget {
  //const EventsHomePage({Key? key}) : super(key: key);
  @override
  _BackButtonState createState() => _BackButtonState();
}

class _BackButtonState extends State<BackButtonWidget>{

  
  Widget build(BuildContext context){
    return  Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("<", style: GoogleFonts.lato(fontSize: 35.0, color: Colors.black)),
          onPressed: (){},
          style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFA3B0EB),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0)
          )
          ) 
        )
      )
    );
  }
}