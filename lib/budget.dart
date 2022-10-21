import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Budget extends StatefulWidget {
  @override
  _BudgetState createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  var formatter = NumberFormat('###,###.##');
  double budget = 100000;
  double spent = 500.82;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF657BE3),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 5.0),
            child: Center(
              child: Text.rich(
                TextSpan(
                  text: 'Budget',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Color.fromRGBO(254, 247, 236, 1),
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 9.0, 0.0, 0.0),
            child: Container(
              height: size.height - 184.0,
              decoration: BoxDecoration(
                color: Color(0xFFFEF7EC),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20.0),
                  topRight: const Radius.circular(20.0),
                ),
              ),
              child: ListView(
                children:[
                  SizedBox(height: 25),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Budget Remaining',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.black38,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        '\$' + formatter.format(double.parse((budget - spent).toString())),
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Total Budget',
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                '\$' + formatter.format(double.parse(budget.toString())),
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ]
                          ),
                          SizedBox(width: 40),
                          Column(
                              children: [
                                Text(
                                  'Spent Budget',
                                  style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                      color: Colors.black38,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  '\$' + formatter.format(double.parse(spent.toString())),
                                  style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ]
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      //Navigation Bar with Icons
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.black, size: 30), label: 'Home', backgroundColor: Color(0xFFA3B0EB)),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_month, color: Colors.black, size: 30), label: 'Calendar', backgroundColor: Color(0xFFA3B0EB)),
            BottomNavigationBarItem(icon: Icon(Icons.wallet, color: Colors.black, size: 30), label: 'Budget', backgroundColor: Color(0xFFA3B0EB)),
            BottomNavigationBarItem(icon: Icon(Icons.schedule, color: Colors.black, size: 30), label: 'Itinerary', backgroundColor: Color(0xFFA3B0EB)),
            BottomNavigationBarItem(icon: Icon(Icons.person_add, color: Colors.black, size: 30), label: 'Collaborate', backgroundColor: Color(0xFFA3B0EB)),
            BottomNavigationBarItem(icon: Icon(Icons.settings, color: Colors.black, size: 30), label: 'Settings', backgroundColor: Color(0xFFA3B0EB))
          ]
      ),
    );
  }
}