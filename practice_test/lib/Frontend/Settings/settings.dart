/*
Notes:
Can change user's name and/or password if "confirm" text field matches current password
Only changes value if not empty (i.e. can change name w/o changing password, vv)
Page automatically updates with new name/password upon clicking save

TODO: Notification functionality (stretch goal)

Backend:
store and retrieve user info
 */

//can be replaced with backend user class, requires name/email/password
import '../Helpers/user.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  //initializes user for testing purposes only
  User testUser = new User(name: "Jon", email: "jon@gmail.com", password: "iplan");

  //TODO: saving state of notifications switch
  bool isSwitched = false;

  //text controllers
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  //current password to confirm changes
  final _confPasswordController = TextEditingController();

  @override
  void dispose(){
    _nameController.dispose();
    _passwordController.dispose();
    _confPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    //TODO: for backend, update user info
    Future updateInfo() async{
      if (_confPasswordController.text.trim() == testUser.password){
        if(_nameController.text.isNotEmpty){
          testUser.name = _nameController.text.trim();
        }
        if(_passwordController.text.isNotEmpty){
          testUser.password = _passwordController.text.trim();
        }
      }
    }

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
                  text: 'Settings',
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
          SingleChildScrollView(
            child: Padding(
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
                    Center(
                      child: Column(
                        children: [
                          Text(
                            testUser.getName(),
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 35.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            testUser.getEmail(),
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    name(),
                    SizedBox(height: 20),
                    password(),
                    SizedBox(height: 20),
                    confPassword(),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 50.0)),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              )),
                            ),
                            onPressed: () {
                              _nameController.clear();
                              _passwordController.clear();
                              _confPasswordController.clear();
                            },
                            child: Text(
                              "Cancel",
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              updateInfo();
                              _nameController.clear();
                              _passwordController.clear();
                              _confPasswordController.clear();
                              setState((){});
                            },
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 50)),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              )),
                              backgroundColor: MaterialStateProperty.all(Color.fromRGBO(186, 227, 101, 1)),
                            ),
                            child: Text(
                              "Save",
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(25.0),
                      child: Text(
                        "Preferences",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children:[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            Text(
                              "Notifications",
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                            SizedBox(width: 100),
                            Switch(
                              value: isSwitched,
                              onChanged: (value) {
                                //TODO
                                setState(() {
                                  isSwitched = value;
                                });
                              },
                              activeTrackColor: Color(0x80BAE365),
                              activeColor: Color(0xFFBAE365),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 175.0),
                      width: 50.0,
                      child: FloatingActionButton(
                        //TODO: reroute to welcome screen
                        onPressed: () => print("Do Something"),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        backgroundColor: Color(0xFFBAE365),
                        child: Text(
                          'Log out',
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
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget name(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: TextField(
            controller: _nameController,
            keyboardType: TextInputType.name,
            style: GoogleFonts.lato(
              color: Colors.black,
            ),
            cursorColor: Colors.black,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Change name',
              prefixIcon: Icon(
                Icons.person,
                color: Color(0xFF657BE3),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget password(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: TextField(
            controller: _passwordController,
            obscureText: true,
            style: GoogleFonts.lato(
              color: Colors.black,
            ),
            cursorColor: Colors.black,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Change password",
              prefixIcon: Icon(
                Icons.lock,
                color: Color(0xFF657BE3),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget confPassword(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: TextField(
            controller: _confPasswordController,
            obscureText: true,
            style: GoogleFonts.lato(
              color: Colors.black,
            ),
            cursorColor: Colors.black,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Confirm with current password",
              prefixIcon: Icon(
                Icons.lock,
                color: Color(0xFF657BE3),
              ),
            ),
          ),
        ),
      ),
    );
  }
}