import 'null_parameter_exception.dart';
// import 'dart:convert';
// import 'package:json_serializable/json_serializable.dart';
// import 'package:built_value/built_value.dart';

/// @author [MatthewSheldon]
/// The [Collaborator] object represents the information for an individual collaborator.
/// These forms of information include [_name], [_email], and [_phoneNumber].
class Collaborator implements Comparable<Collaborator> {
  /// The name of the collaborator
  late String _name;

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
      required bool hasAccepted}) {
    if (email == "null" && phoneNumber == "null") {
      throw NullParameterException();
    } else {
      _name = name;
      _email = email;
      _phoneNumber = phoneNumber;
      _hasAccepted = hasAccepted;
    }
  }

  /// Constructs a [Collaborator] object from the passed [json] file
  /// decomposition of a [Collaborator] object.
  Collaborator.fromJson(Map<String, dynamic> json) {
    _name = json["name"];
    _email = json["email"];
    _phoneNumber = json["phoneNumber"];
    _hasAccepted = json["hasAccepted"];
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

  /// Returns whether or not the [Collaborator] has accepte the invitation
  bool hasAccepted() {
    return _hasAccepted;
  }

  /// Deconstructs the current [Collaborator] object
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "name": _name,
      "email": _email,
      "phoneNumber": _phoneNumber,
      "hasAccepted": _hasAccepted
    };
  }

  /// Represents the current [Collaborator] class as the required name parameter,
  /// and the optional email and
  @override
  String toString() {
    return "Name: $_name\n"
        "${_email == null ? "" : "Email: $_email"}\n"
        "${_phoneNumber == "null" ? "" : "Phone Number: $_phoneNumber"}\n";
  }

  /// Sort first by whether or not the user has accepted the collaboration
  /// invitation denoted by [_hasAccepted], and then by alphabetical order
  /// denoted by [_name].
  @override
  int compareTo(Collaborator other) {
    if (this._hasAccepted == other._hasAccepted) {
      return this._name.compareTo(other._name);
    } else if (this._hasAccepted) {
      return -1;
    }
    return 1;
  }
}
