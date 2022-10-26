/// @author [MatthewSheldon]
/// Class used for creating/reading the "user id to name" document
/// for the current user. Use default constructor when creating a
/// new user. Use [fromJson] when creating an existing user.
class UserIDToName {
  /// Name of the current user
  late String _name;

  /// Constructs a new [UserIDToName] object from the passed name parameter
  UserIDToName({required String name}) {
    _name = name;
  }

  /// Constructs a new [UserIDToName] object from the passed json file
  UserIDToName.fromJson(Map<String, dynamic> json) {
    _name = json["name"];
  }

  /// Convers the current [UserIDToName] object into a json file formatted map
  Map<String, dynamic> toJson() {
    return <String, dynamic>{"name": _name};
  }
}
