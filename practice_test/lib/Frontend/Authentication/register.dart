/*
 * TODO: Frontend, changes have been made at lines 14-36, 180-215, and 262-299. 
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matthew_backend/Backend/User_Creation/user_assembler.dart';
import 'package:matthew_backend/Backend/User_Creation/user_creator.dart';

import '../../Backend/User_Creation/user.dart';

class Register extends StatefulWidget {
  /// @author [MatthewSheldon]
  /// The following constants are needed for error/success reporting
  static const int success = 0;
  static const int accountWithEmailAlreadyInUse = 1;
  static const int userFileFailedUpload = 2;
  static const int userIDToUserFileFailedToFetch = 3;
  static const int oneOrMoreEventFilesFailedToFetch = 4;

  /// The following [User] object holds all of the info for the registered user
  static late User _userObj;

  @override
  _RegisterState createState() => _RegisterState();

  /// Update the [User] ojbect with the passed [user] parameter
  static void updateUserObject({required User user}) {
    _userObj = user;
  }

  /// Return the [User] object
  static User getUserObject() {
    return _userObj;
  }
}

Widget name(TextEditingController _nameController) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25.0),
    child: Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(254, 247, 236, 1),
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
            hintText: 'Name',
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

Widget email(TextEditingController _emailController) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25.0),
    child: Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(254, 247, 236, 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          style: GoogleFonts.lato(
            color: Colors.black,
          ),
          cursorColor: Colors.black,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Email',
            prefixIcon: Icon(
              Icons.email,
              color: Color(0xFF657BE3),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget password(TextEditingController _passwordController) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25.0),
    child: Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(254, 247, 236, 1),
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
            hintText: 'Password',
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

Widget confirmPassword(TextEditingController _confPasswordController) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25.0),
    child: Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(254, 247, 236, 1),
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
            hintText: 'Confirm Password',
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

class _RegisterState extends State<Register> {
  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confPasswordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// @author [MatthewSheldon]
    /// Attempts to create a new user and log the new user in. Returns a code indicating success/error status
    Future<int> signUp() async {
      // Attempt to create a new user from the email, password, and name provided
      List<dynamic> ans = await UserCreator.createNewUser(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          name: _nameController.text.trim());
      // If there weren't any issues creating the user...
      if (ans[0] == UserCreator.success) {
        // Retrieve the user's ID
        String userID = ans[1];
        // Attempt to retrieve their files from the cloud
        UserAssembler userAssembler = UserAssembler(userID: userID);
        ans = await userAssembler.assembleUserFromCloud();
        // If UserAssembler was able to create a User object...
        if (ans[0] != UserAssembler.failedUserIDToUser) {
          // Bubble up the User object
          Register.updateUserObject(user: ans[1]);
        }
        if (ans[0] != UserAssembler.success) {
          // Issues occurred in UserAssembler
          return ans[0] == 1
              ? Register.userIDToUserFileFailedToFetch
              : Register.oneOrMoreEventFilesFailedToFetch;
        }
        // No issues occurred
        return Register.success;
      } else {
        // Issues occurred in UserCreator
        return ans[0] == 1
            ? Register.accountWithEmailAlreadyInUse
            : Register.userFileFailedUpload;
      }
    }

    return Scaffold(
      backgroundColor: Color(0xFFFEF7EC),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                color: Color(0xFF657BE3),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          color: Color(0xFFBAE365),
                          Icons.circle_rounded,
                          size: 150,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Create account',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              color: Color.fromRGBO(254, 247, 236, 1),
                              fontSize: 30.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        name(_nameController),
                        SizedBox(height: 20),
                        email(_emailController),
                        SizedBox(height: 20),
                        password(_passwordController),
                        SizedBox(height: 20),
                        confirmPassword(_confPasswordController),
                        SizedBox(height: 40),
                        //login button
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 25.0),
                          width: double.infinity,
                          child: FloatingActionButton(
                            /// @author [MatthewSheldon]
                            /// Fully implemented backend for attempting to register
                            onPressed: () async {
                              // Attempt to sign up
                              int code = await signUp();
                              print(code);
                              if (code == Register.success) {
                                // TODO: Frontend, transition to the home page from here
                              } else if (code ==
                                  Register.oneOrMoreEventFilesFailedToFetch) {
                                // TODO: Frontend, transition to the home page, but alert the user that
                                // "One or more events failed to load. Sorry for the inconvenience."
                                // or something like that.
                              } else {
                                switch (code) {
                                  case Register.accountWithEmailAlreadyInUse:
                                    {
                                      // TODO: Front end, do NOT transition to the home page. Alert the user
                                      // that an account with the emial entered already exists. Print any
                                      // any additional error messages regarding trying again or resetting a
                                      // password now.
                                      break;
                                    }
                                  case Register.userFileFailedUpload:
                                    {
                                      // TODO: Front end, do NOT transition to the home page. Alert the user
                                      // that there was an error registering them and to please try again.
                                      break;
                                    }
                                  case Register.userIDToUserFileFailedToFetch:
                                    {
                                      // TODO: Front end, do NOT transition to the home page. Alert the user
                                      // than an uknown error occured while attempting to authenticate them
                                      // and to try again.
                                      break;
                                    }
                                }
                              }
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
                        //Already have an account? Login
                        SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style: GoogleFonts.lato(
                                color: Color.fromRGBO(254, 247, 236, 1),
                                fontSize: 20.0,
                              ),
                            ),
                            TextButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent),
                              ),
                              onPressed: () => print("Reroute to login page"),
                              child: Text(
                                'Login now!',
                                style: GoogleFonts.lato(
                                  color: Color(0xFFBAE365),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
