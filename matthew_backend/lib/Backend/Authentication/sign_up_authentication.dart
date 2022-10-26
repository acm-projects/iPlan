import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

/// @author [MatthewSheldon]
/// Used for creating a new user in the FirebaseAuthentication user database.
/// If the email is already in use, then it will throw an exception.
class SignUpAuthentication {
  /// Static method that attempts to create a new user with the passed [email] and [password].
  /// Will throw an error if the email is already in use by another user already in the system.
  static Future<String?> signUpWithEmail(
      {required String email, required String password}) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    String? userID;
    // Attempt to create a new user. If it fails, the return value will be null
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        userID = value.user!.uid;
      });
    } catch (e) {
      print(
          "Error: Email already used by another user. Please enter a different email.");
      print(e);
      userID = null;
    }
    return userID;
  }
}
