import 'package:url_launcher/url_launcher.dart';

import '../Event_Manager/event.dart';

/// @author [MatthewSheldon]
/// Represents all of the information that is important about the user who is
/// currently signed in, such as [_userID], [_userName], [_email], [_eventIDs],
/// and [_events]. When creating a new user, use the default constructor.
/// When creating a User from the cloud, user [User.fromJson].
class User {
  /// The user ID of the current user
  late String _userID;

  /// The name of the current user
  late String _userName;

  /// The email of the current user
  late String _email;

  /// The list of events that the user is a part of represented by their event IDs
  late List<String> _eventIDs;

  /// The list of events that the user is a part of represented by their Event object
  late List<Event> _events;

  /// Constructs a [User] object from the passed [userID], [name], [email], and list of [eventIDs].
  User(
      {required String userID,
      required String name,
      required String email,
      required List<String> eventIDs}) {
    _userID = userID;
    _userName = name;
    _email = email;
    _eventIDs = eventIDs;
    _events = <Event>[];
  }

  /// Constructs a [User] object from the passed [userID] and [json] file
  User.fromJson({required String userID, required Map<String, dynamic> json}) {
    _userID = userID;
    _userName = json["name"];
    _email = json["email"];
    _eventIDs = <String>[];
    for (dynamic eventID in json["eventIDs"]) {
      _eventIDs.add(eventID.toString());
    }
    _events = <Event>[];
  }

  /// Adds the passed [eventID] to the user's [_eventIDs] list
  void addEventID({required String eventID}) {
    _eventIDs.add(eventID);
  }

  /// Adds the passed [event] to the user's [_events] list
  void addEvent({required Event event}) {
    _events.add(event);
  }

  /// Returns the user's ID
  String getUserID() {
    return _userID;
  }

  /// Returns the user's name
  String getUserName() {
    return _userName;
  }

  /// Returns the user's email
  String getEmail() {
    return _email;
  }

  /// Returns the user's list of events represented as event IDs
  List<String> getEventIDs() {
    return _eventIDs;
  }

  /// Returns the user's list of events represented as [Event] objects
  List<Event> getEvents() {
    return _events;
  }

  /// Converts the current [User] object into a json file formatted [Map]
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "name": _userName,
      "email": _email,
      "eventIDs": _eventIDs
    };
  }
}
