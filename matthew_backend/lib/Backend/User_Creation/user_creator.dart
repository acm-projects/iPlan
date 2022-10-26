import 'package:cloud_firestore/cloud_firestore.dart';
import '../Authentication/sign_up_authentication.dart';
import 'user_id_to_events.dart';
import 'user_id_to_name.dart';

/// @author [MatthewSheldon]
/// Used to add a user to the systema and create any
/// necessary documents to the cloud storage system.
class UserCreator {
  /// The code representing the successful creation of a new user and a new document
  static const int success = 0;

  /// The code representing failure to create a user
  static const int userFailed = 1;

  /// The code representing failure to create a document in "user id to events"
  static const int eventsDocumentFailed = 2;

  /// The code representing failure to create a document in "user id to name"
  static const int nameDocumentFailed = 3;

  /// Attempts to create a new user to the system and the necessary files.
  /// Returns 0 if there was no issue creating the user to the system
  /// and creating a document with the userID in the "user id to events"
  /// collection. Returns 1 if the email is already in use. Returns 2 if
  /// the email is not in use, but there already exits a document in collection
  /// "user id to events" with the name userID. Returns 3 if the email is
  /// not in use, but there already exists a document in collection
  /// "user id to name" with the name userID.
  static Future<int> createNewUser(
      {required String email,
      required String password,
      required String name}) async {
    int code = success;
    // Retrieve the userID generated when signing up with email
    String? userID = await SignUpAuthentication.signUpWithEmail(
        email: email, password: password);
    // If the user did not fail to be created
    if (userID != null) {
      // Create a [UserIDToEvents] object to get a JSON formatted output
      UserIDToEvents userIdToEvents = UserIDToEvents();
      // Create a new document in the collection "user id to events" with document name [userID]
      await FirebaseFirestore.instance
          .collection("user id to events")
          .doc(userID)
          .set(userIdToEvents.toJson())
          .onError((error, stackTrace) {
        code = eventsDocumentFailed;
        print(error);
        print(stackTrace);
      });
    } else {
      code = userFailed;
    }

    if (code == success) {
      // Create a [UserIDToname] object to get a JSON formatted output
      UserIDToName userIDToName = UserIDToName(name: name);
      // Create a new document in the collection "user id to name" with document name [userID]
      await FirebaseFirestore.instance
          .collection("user id to name")
          .doc(userID)
          .set(userIDToName.toJson())
          .onError((error, stackTrace) {
        code = nameDocumentFailed;
        print(error);
        print(stackTrace);
      });
    }

    return code;
  }
}
