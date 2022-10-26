import 'package:firebase_auth/firebase_auth.dart';

/// @author [MatthewSheldon]
/// Used to log the current user out. Will return true if the user
/// was successfully logged out. Will return false otherwise.
class LogOutAuthentication {
  /// Attempts to sign the user out. If successful, returns true.
  /// If unsuccessful, returns false.
  static Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut().then((value) {
        return true;
      });
    } catch (e) {
      print(e);
      return false;
    }
    return false; // Because dart is "smart" sometimes
  }
}
