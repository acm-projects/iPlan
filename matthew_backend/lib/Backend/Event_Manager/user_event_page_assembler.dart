import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

import 'event.dart';

/// @author [MatthewSheldon]
/// Used to retrieve all important documents from the cloud given a user ID.
class UserEventPageAssembler {
  /// Code returned when [readEventsFromCloud] encountered no errors
  static const int success = 0;

  /// Code returned when [readEventsFromCloud] failed to retrieve the document in "user id to name"
  static const int failedUserIDToName = 1;

  /// Code returned when [readEventsFromCloud] failed to retrieve the document in "user id to events"
  static const int failedUserIDToEvents = 2;

  /// Code returned when [readEventsFromCloud] failed to retrieve the json file for one of the event IDs in [_eventIDs]
  static const int failedEvents = 3;

  /// The user's ID
  late String _userID;

  /// The user's name
  late String _userName;

  /// The event IDs associated with the user
  late List<String> _eventIDs;

  /// The events that the user is a part of
  late List<Event> _events;

  /// Construct a [UserEventPageAssembler] object specific
  /// for the passed [userID]
  UserEventPageAssembler({required String userID}) {
    _userName = userID;
    _eventIDs = <String>[];
    _events = <Event>[];
  }

  /// Given this [UserEventPageAssembler] object's [_userID],
  /// retrieve the user's file(s) from "user id to name",
  /// "user id to events", and "events". Returns an integer
  /// describing the success or failure of this method.
  Future<int> readEventsFromCloud() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    var map1, map2, map3;

    // Attempt to retrieve the user's "user id to name" file
    try {
      map1 = await FirebaseFirestore.instance
          .collection("user id to name")
          .doc(_userID)
          .get()
          .then((document) => document.data());
      _userName = map1!["name"];
    } catch (e) {
      return failedUserIDToName;
    }

    // Attempt to retrieve the user's "user id to events" file
    try {
      map2 = await FirebaseFirestore.instance
          .collection("user id to events")
          .doc(_userID)
          .get()
          .then((document) => document.data());
    } catch (e) {
      return failedUserIDToEvents;
    }

    // For each event id in the file, add it to the list of event ids
    for (dynamic eventID in map2["events"]) {
      _eventIDs.add(eventID as String);
    }

    bool failed = false;
    // Attempt to retrieve the json file for each event id and add the Event object to the list
    for (String eventID in _eventIDs) {
      try {
        map3 = await FirebaseFirestore.instance
            .collection("events")
            .doc(eventID)
            .get()
            .then((document) => document.data());
        _events.add(Event.fromJson(json: map3, link: eventID));
      } catch (e) {
        failed = true;
      }
    }

    return failed ? failedEvents : success;
  }

  /// TODO: testing method; fix in the future
  Future<bool> updateEventToCloud(
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
  
  /// Returns the user's name
  String getUserName() {
    return _userName;
  }

  /// Returns the event IDs associated with the user
  List<String> getEventIDs() {
    return _eventIDs;
  }

  /// Returns the events that the user is a part of
  List<Event> getEvents() {
    return _events;
  }
}
