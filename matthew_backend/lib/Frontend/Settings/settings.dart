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
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:practice_test/Backend/Authentication/log_out_authentication.dart';
import 'package:practice_test/Backend/Authentication/update_files.dart';

import '../../Backend/Event_Manager/event.dart';
import '../Authentication/welcomePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Backend/Authentication/settings.dart' as backendSettings;
import '../../Backend/User_Creation/user.dart' as backendUser;

late backendUser.User _user;

class Settings extends StatefulWidget {
  Settings({required backendUser.User user}) {
    _user = user;
  }
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  //initializes user for testing purposes only

  //TODO: saving state of notifications switch
  bool isSwitched = false;

  //text controllers
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  //current password to confirm changes
  final _confPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _confPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    /// @author [MatthewSheldon]
    Future updateInfo() async {
      // Get the confirmation password
      String confirmationPassword = _confPasswordController.text.trim();
      // Attempt to validate the user information
      List<dynamic> ans = await backendSettings.Settings.validatePassword(
          email: _user.getEmail(), password: confirmationPassword);
      firebase.User firebaseUser;
      // If validating the password was successful, then we are good to go
      if (ans[0] == backendSettings.Settings.success) {
        print("Passwords matched");
        firebaseUser = ans[1];
      } else {
        // Otherwise, nothing more can be done
        print("Passwords do not match / other error");
        return;
      }

      // If the new password field is not empty, then go ahead and change it
      String newPassword = _passwordController.text.trim();
      if (newPassword.isNotEmpty) {
        ans = await backendSettings.Settings.changePassword(
            firebaseUser: firebaseUser, newPassword: newPassword);
        if (ans[0] == backendSettings.Settings.success) {
          print("Password change successful");
          firebaseUser = ans[1];
        } else {
          print("Password change failed");
        }
      }

      // If the new name field is not empty, then go ahead and change it
      String newName = _nameController.text.trim();
      if (newName.isNotEmpty) {
        ans = await backendSettings.Settings.changeUserName(
            firebaseUser: firebaseUser,
            backendUser: _user,
            newUserName: newName);
        if (ans[0] == backendSettings.Settings.success) {
          print("Username change successful");
          firebaseUser = ans[1];
          _user = ans[2];
        } else if (ans[0] ==
            backendSettings.Settings.backendUpdateEmailFailed) {
          print("Username failed to change in backend");
          firebaseUser = ans[1];
          _user = ans[2];
          return;
        } else {
          print("Username change failed");
          return;
        }

        // Lastly, update each instance of the user object in each of their events
        for (Event event in _user.getEvents()) {
          event.updateCollaborator(oldUserID: _user.getUserID(), user: _user);
          UpdateFiles.updateEventFile(
              documentID: event.getLink(), json: event.toJson());
        }
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF657BE3),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
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
                height: size.height - 229.0,
                decoration: BoxDecoration(
                  color: Color(0xFFFEF7EC),
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20.0),
                    topRight: const Radius.circular(20.0),
                  ),
                ),
                child: ListView(
                  children: [
                    SizedBox(height: 25),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            _user.getUserName(),
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
                            _user.getEmail(),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(horizontal: 50.0)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
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
                        SizedBox(width: 50),
                        ElevatedButton(
                          onPressed: () async {
                            await updateInfo();
                            _nameController.clear();
                            _passwordController.clear();
                            _confPasswordController.clear();
                            setState(() {});
                          },
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(horizontal: 50)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            )),
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromRGBO(186, 227, 101, 1)),
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
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                      padding: EdgeInsets.fromLTRB(100, 0, 100, 0),
                      height: 50,
                      child: FloatingActionButton(
                        heroTag: "settings1",
                        onPressed: () async {
                          bool success = await LogOutAuthentication.signOut();
                          if (!success) {
                            print("Unable to log user out");
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WelcomePage()));
                          }
                        },
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

  Widget name() {
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

  Widget password() {
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

  Widget confPassword() {
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
