import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

/// @author [MatthewSheldon]
/// Used for logging into an existing user in the FirebaseAuthentication user 
/// database. If the email is not in use or the password does not match, then
/// it will throw an exception.
class LogInAuthentication {
  /// Static method that attempts to log an existing user into the system with
  /// the passed [email] and [password]. Will throw an error if the email is not
  /// in use, or if the password does not match the email.
  static Future<String?> logInWithEmail(
      {required String email, required String password}) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    String? userID = "";
    // Attempt to log in an existing user. If it fails, the return value will be null
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        userID = value.user!.uid;
      });
    } catch (e) {
      userID = null;
      print("Error: Email or password do not match. Please try again.");
      print(e);
    }
    return userID;
  }
}
