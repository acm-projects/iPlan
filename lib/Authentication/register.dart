/*
Line 152, has backend info
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

Widget name(TextEditingController _nameController){
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

Widget confirmPassword(TextEditingController _confPasswordController){
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
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    _confPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //TODO: for backend, text for name/email/password
    Future signUp() async{
      //name: _nameController.text.trim(),
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
                            onPressed: () => signUp,
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
                                backgroundColor: MaterialStateProperty.all(Colors.transparent),
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