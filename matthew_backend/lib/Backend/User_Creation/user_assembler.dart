import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

import 'user.dart';
import '../Event_Manager/event.dart';

/// @author [MatthewSheldon]
/// Used to retrieve all important documents from the cloud given a user ID.
/// Assumes that [UserCreator] or [LogInAuthentication] has been used to
/// retrieve a valid [_userID] prior to creation of this [UserAssembler] object.
class UserAssembler {
  /// Code returned when [assembleUserFromCloud] encountered no errors
  static const int success = 0;

  /// Code returned when [assembleUserFromCloud] failed to retrieve the document in "user id to user"
  static const int failedUserIDToUser = 1;

  /// Code returned when [assembleUserFromCloud] failed to retrieve the json file for one of the event IDs in eventIDs
  static const int failedEvents = 2;

  /// The user's ID
  late String _userID;

  /// The [User] object that contains [User._userID], [User._userName], [User._eventIDs]. [User._events]
  late User _user;

  /// Construct a [UserAssembler] object specific
  /// for the passed [userID]
  UserAssembler({required String userID}) {
    _userID = userID;
  }

  /// Given this [UserAssembler] object's [_userID],
  /// retrieve the user's file(s) from "user id to name",
  /// "user id to events", and "events". Returns an integer
  /// describing the success or failure of this method. If
  /// the code returned is either [success] or [failedEvents],
  /// additionally return the [User] object that was created.
  Future<List<dynamic>> assembleUserFromCloud() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    List<dynamic> ans = <dynamic>[];
    var json1, json2;

    // Attempt to retrieve the user's "user id to user" file
    User user;
    try {
      json1 = await FirebaseFirestore.instance
          .collection("user id to user")
          .doc(_userID)
          .get()
          .then((document) => document.data());
      user = User.fromJson(userID: _userID, json: json1);
    } catch (e) {
      ans[0] = failedUserIDToUser;
      return ans;
    }

    bool failed = false;
    // Attempt to retrieve the json file for each event id and add the Event object to the list
    for (String eventID in user.getEventIDs()) {
      try {
        json2 = await FirebaseFirestore.instance
            .collection("events")
            .doc(eventID)
            .get()
            .then((document) => document.data());
        user.addEvent(event: Event.fromJson(json: json2, link: eventID));
      } catch (e) {
        failed = true;
      }
    }

    // Return the proper code and User object
    ans[0] = failed ? failedEvents : success;
    ans[1] = _user;
    return ans;
  }

  /// TODO: testing method; fix in the future
  Future<bool> updateUserToCloud(
      {required String eventID,
      required String key,
      required Map<String, dynamic> value}) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await FirebaseFirestore.instance
        .collection("events")
        .doc(eventID)
        .update({key: value});
    return true;
  }

  /// Returns the user's ID
  String getUserID() {
    return _userID;
  }

  /// Returns the user's [User] object
  User getUser() {
    return _user;
  }
}
