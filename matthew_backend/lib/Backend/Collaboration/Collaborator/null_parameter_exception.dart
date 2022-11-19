/// @author [MatthewSheldon]
/// An Exception that handles the edge case of both the [email] and [phoneNumber]
/// parameters of a [Collaborator] object being null.
class NullParameterException implements Exception {
  /// The error message to be printed when a [NullParameterException] object is thrown
  final String _errorMessage = "Both 'email' and 'phoneNumber' parameters cannot be null.\n"
      "Please pass a non-null value for either 'email' and/or 'phoneNumber";

  /// Constructs a default [NullparameterException] object
  NullParameterException();

  /// Returns the error message for a [NullParameterException] object
  @override
  String toString() {
    return _errorMessage;
  }
}