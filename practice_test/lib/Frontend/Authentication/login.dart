/*
Line 109, has backend info
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Backend/Authentication/log_in_authentication.dart';
import '../../Backend/User_Creation/user_assembler.dart';
import '../../Backend/User_Creation/user.dart';

class Login extends StatefulWidget {
  /// @author [MatthewSheldon]
  /// The following constants are needed for success/error reporting
  static const int success = 0;
  static const int invalidEmailOrPassword = 1;
  static const int userIDToUserFileFailedToFetch = 2;
  static const int oneOrMoreEventFilesFailedToFetch = 3;

  /// The following [User] object holds all of the info for the logged in user
  static late User _userObj;

  @override
  _LoginState createState() => _LoginState();

  /// Update the [User] ojbect with the passed [user] parameter
  static void updateUserObject({required User user}) {
    _userObj = user;
  }

  /// Return the [User] object
  static User getUserObject() {
    return _userObj;
  }
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

Widget forgotPassword() {
  return Container(
    alignment: Alignment.center,
    child: TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
      ),
      onPressed: () => print("Forgot Password"),
      child: Text(
        'Forgot password?',
        style: GoogleFonts.lato(
          textStyle: TextStyle(
            color: Color.fromRGBO(254, 247, 236, 1),
            fontSize: 15.0,
          ),
        ),
      ),
    ),
  );
}

class _LoginState extends State<Login> {
  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// @author [MatthewSheldon]
    /// Attempts to sign the user in. Returns a code indicating success/error status
    Future<int> signIn() async {
      // Attempt to sign the user back in
      String? userID = await LogInAuthentication.logInWithEmail(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      if (userID != null) {
        // Attempt to retrieve the user's information
        UserAssembler userAssembler = UserAssembler(userID: userID);
        List<dynamic> ans = await userAssembler.assembleUserFromCloud();

        // If there wasn't an error retrieving the user's information
        if (ans[0] != UserAssembler.failedUserIDToUser) {
          // Bubble up [User] object
          Login.updateUserObject(user: ans[1]);
          return ans[0] == 0
              ? Login.success
              : Login.oneOrMoreEventFilesFailedToFetch;
        }
        return Login.userIDToUserFileFailedToFetch;
      } else {
        // The user's email or password do not match
        return Login.invalidEmailOrPassword;
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
                          'Log in to continue',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              color: Color.fromRGBO(254, 247, 236, 1),
                              fontSize: 30.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        email(_emailController),
                        SizedBox(height: 20),
                        password(_passwordController),
                        SizedBox(height: 40),
                        //sign in button
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 25.0),
                          width: double.infinity,
                          child: FloatingActionButton(
                            /// @author [MatthewSheldon]
                            /// Fully implemented backend for attempting to register
                            onPressed: () async {
                              // Attempt to sign in
                              int code = await signIn();
                              print("\nError/Success code: ${code}\n");
                              if (code == Login.success) {
                                // TODO: Transition to the home page
                              } else if (code ==
                                  Login.oneOrMoreEventFilesFailedToFetch) {
                                // TODO: Transition to the home page, but alert the user that one or more events failed to be retrieved
                              } else {
                                switch (code) {
                                  case Login.invalidEmailOrPassword:
                                    {
                                      // TODO: Do NOT transition to the home page. Alert the
                                      // user that the email and password entered to not match
                                      break;
                                    }
                                  case Login.userIDToUserFileFailedToFetch:
                                    {
                                      // TODO: Do NOT transition to the home page. Alert the
                                      // user that an unnexpected error occured and to try again
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
                        SizedBox(height: 10),
                        forgotPassword(),
                        SizedBox(height: 60),
                        //Don't have an account? Register
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Not a member? ',
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
                              onPressed: () => print("Reroute to sign up page"),
                              child: Text(
                                'Sign up now!',
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
