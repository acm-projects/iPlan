/*
Line 109, has backend info
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

Widget email(TextEditingController _emailController){
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
          inputFormatters: [
            LengthLimitingTextInputFormatter(30),
          ],
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

Widget password(TextEditingController _passwordController){
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
          inputFormatters: [
            LengthLimitingTextInputFormatter(20),
          ],
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

Widget forgotPassword(){
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
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //TODO: for backend, text for email/password
    Future signIn() async{
      //email: _emailController.text.trim(),
      //password: _passwordController.text.trim(),
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
                            onPressed: () => signIn,
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
                                backgroundColor: MaterialStateProperty.all(Colors.transparent),
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