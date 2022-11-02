import '../../User_Creation/user.dart';
import 'null_parameter_exception.dart';

/// @author [MatthewSheldon]
/// The [Collaborator] object represents the information for an individual
/// collaborator. These forms of information include [_userID], [_name],
/// [_email], [_phoneNumber], [_userID], and [_hasAccepted].
class Collaborator implements Comparable<Collaborator> {
  /// The name of the collaborator
  late String _name;

  /// The userID of the collaborator
  late String _userID;

  /// The email of the collaborator
  late String _email;

  /// The phone number of the collaborator
  late String _phoneNumber;

  /// Whether or not the current collaborator is an invitee
  /// or has actually accepted the invitation.
  late bool _hasAccepted;

  /// Constructs a [Collaborator] object with a required parameter [name]
  /// and optional parameters [email] and [phoneNumber]. If either [email]
  /// or [phoneNumber] are not passed, assume them to be ["null"]. If both
  /// [email] and [phoneNumber] are not passed, then a [NullParameterException]
  /// will be thrown and prevent the creation of the [Collaborator] object.
  Collaborator(
      {required String name,
      String email = "null",
      String phoneNumber = "null",
      required bool hasAccepted,
      String userID = ""}) {
    if (email == "null" && phoneNumber == "null") {
      throw NullParameterException();
    } else {
      _name = name;
      _email = email;
      _phoneNumber = phoneNumber;
      _hasAccepted = hasAccepted;
      _userID = userID;
    }
  }

  /// Constructs a [Collaborator] object from the passed [User] object
  Collaborator.fromUser({required User user}) {
    _userID = user.getUserID();
    _name = user.getUserName();
    _email = user.getEmail();
    _phoneNumber = "null";
    _hasAccepted = true;
  }

  /// Constructs a [Collaborator] object from the passed [json] file
  /// decomposition of a [Collaborator] object.
  Collaborator.fromJson(Map<String, dynamic> json) {
    if (json["email"] == "null" && json["phoneNumber"] == "null") {
      throw NullParameterException();
    } else {
      _name = json["name"];
      _email = json["email"];
      _phoneNumber = json["phoneNumber"];
      _hasAccepted = json["hasAccepted"];
      _userID = json["userID"];
    }
  }

  /// Returns the [_name] of the [Collaborator] object
  String getName() {
    return _name;
  }

  /// Returns the [_email] of the [Collaborator] object
  String getEmail() {
    return _email;
  }

  /// Returns the [_phoneNumber] of the [Collaborator] object
  String getPhoneNumber() {
    return _phoneNumber;
  }

  String getUserID() {
    return _userID;
  }

  /// Returns whether or not the [Collaborator] has accepte the invitation
  bool hasAccepted() {
    return _hasAccepted;
  }

  /// Updates the user ID of the [Collaborator] object to be [userID]
  void updateUserID({required String userID}) {
    _userID = userID;
  }

  /// Updates the name of the [Collaborator] object to be [name]
  void updateName({required String name}) {
    _name = name;
  }

  /// Updates the email of the [Collaborator] object to be [email]
  void updateEmail({required String email}) {
    _email = email;
  }

  /// Updates the acceptance status of the [Collaborator] object to be [hasAccepted]
  void updateHasAccepted({required bool hasAccepted}) {
    _hasAccepted = hasAccepted;
  }

  /// Deconstructs the current [Collaborator] object in a JSON format
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "hasAccepted": _hasAccepted,
      "phoneNumber": _phoneNumber,
      "name": _name,
      "email": _email,
      "userID": _userID
    };
  }

  /// Represents the current [Collaborator] class as the required name parameter,
  /// and the optional email and
  @override
  String toString() {
    return "Name: $_name\n"
        "${_email == "null" ? "" : "Email: $_email"}\n"
        "${_phoneNumber == "null" ? "" : "Phone Number: $_phoneNumber"}\n";
  }

  /// Sort first by whether or not the user has accepted the collaboration
  /// invitation denoted by [_hasAccepted], and then by alphabetical order
  /// denoted by [_name].
  @override
  int compareTo(Collaborator other) {
    if (_hasAccepted == other._hasAccepted) {
      return _name.compareTo(other._name);
    }
    return _hasAccepted ? -1 : 1;
  }
}
