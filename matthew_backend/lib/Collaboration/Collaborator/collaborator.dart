import 'null_parameter_exception.dart';
/// TODO: implement the notion of accepting the invitation and denoting between
/// invited collaborators and those who are actual collaborators.

/// The [Collaborator] object represents the information for an individual collaborator.
/// These forms of information include [_name], [_email], and [_phoneNumber].
class Collaborator {
  /// The name of the collaborator
  late String _name;
  /// The email of the collaborator
  late String _email;
  /// The phone number of the collaborator
  late String _phoneNumber;

  /// Constructs a [Collaborator] object with a required parameter [name]
  /// and optional parameters [email] and [phoneNumber]. If either [email]
  /// or [phoneNumber] are not passed, assume them to be ["null"]. If both
  /// [email] and [phoneNumber] are not passed, then a [NullParameterException]
  /// will be thrown and prevent the creation of the [Collaborator] object.
  Collaborator({required String name, String email = "null", String phoneNumber = "null"}) {
    if(email == "null" && phoneNumber == "null") {
      throw NullParameterException();
    } else {
      _name = name;
      _email = email;
      _phoneNumber = phoneNumber;
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

  @override
  /// Represents the current [Collaborator] class as the required name parameter,
  /// and the optional email and
  String toString() {
    return "Name: $_name\n"
        "${_email == "null" ? "" : "Email: $_email"}\n"
        "${_phoneNumber == "null" ? "" : "Phone Number: $_phoneNumber"}\n";
  }
}