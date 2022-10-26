/// @author [MatthewSheldon]
/// Class used for creating/reading the "user id to events" document
/// for the current user. Use default constructor when creating a
/// new user. Use [fromJson] when creating an existing user.
class UserIDToEvents {
  /// List of events that the current user is a part of
  late List<String> _eventIDs;

  /// Constructs a new [UserIDToEvents] object with no events
  UserIDToEvents() {
    _eventIDs = <String>[];
  }

  /// Constructs a new [UserIDToEvents] object from the passed json file
  UserIDToEvents.fromJson({required Map<String, dynamic> json}) {
    _eventIDs = json["events"] as List<String>;
  }

  /// Convers the current [UserIDToEvents] object into a json file formatted map
  Map<String, dynamic> toJson() {
    return <String, dynamic>{"events": _eventIDs};
  }
}
