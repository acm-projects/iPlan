import 'package:cloud_firestore/cloud_firestore.dart';
import '../Authentication/sign_up_authentication.dart';
import '../User_Creation/user.dart';

/// @author [MatthewSheldon]
/// Used to add a user to the system and create any
/// necessary documents to the cloud storage system.
class UserCreator {
  /// The code representing the successful creation of a new user and a new document
  static const int success = 0;

  /// The code representing failure to create a user
  static const int userFailed = 1;

  /// The code representing failure to create/update a document in "user id to user"
  static const int userIDToUserFailed = 2;

  /// Attempts to create a new user to the system and the necessary files.
  /// Returns both 0 and the userID if there was no issue creating the user 
  /// to the system and creating a document with the userID in the 
  /// "user id to user" collection. Returns 1 if the email is already in use. 
  /// Returns 2 if updating the this user's "user id to user" document failed.
  static Future<List<dynamic>> createNewUser(
      {required String email,
      required String password,
      required String name}) async {
    List<dynamic> ans = <dynamic>[];
    var map1, map2, map3;
    User user;

    // Retrieve the userID generated when signing up with email
    String? userID = await SignUpAuthentication.signUpWithEmail(
        email: email, password: password);

    // If the user did not fail to be created
    if (userID != null) {
      // Create a [User] object to get a JSON formatted output
      user =
          User(userID: userID, name: name, email: email, eventIDs: <String>[]);
      // Attempt to create a new document in the collection "user id to events" with document name [userID]
      try {
        await FirebaseFirestore.instance
            .collection("user id to user")
            .doc(userID)
            .set(user.toJson());
      } catch (e) {
        print(e);
        ans[0] = userIDToUserFailed;
        return ans;
      }
    } else {
      ans[0] = userFailed;
      return ans;
    }

    ans[0] = success;
    ans[1] = userID;
    return ans;
  }
}
