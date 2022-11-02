import 'package:url_launcher/url_launcher.dart';

/// @author [MatthewSheldon]
/// The [InviteCollaborator] class handles the creation of mailto and sms links,
/// as well as navigating the user to their native email and/or messaging app.
class InviteCollaborator {
  /// Create a [Uri] object to generate a text message to the chosen [phoneNumber]
  /// that includes the [link] used to invite users. Additionally, take the user
  /// to their native messaging app.
  void sendSMS({required String phoneNumber, required String link}) {
    final Uri smsLaunchUri = Uri(
        scheme: "sms",
        path: phoneNumber,
        queryParameters: <String, String>{
          "body": "You have been invited to an iPlan event.\n"
            "Upon downloading the iPlan app, on the event organization screen,"
            " enter the following link to be added as a collaborator: $link"
        });
    launchUrl(smsLaunchUri);
  }

  /// Create a [Uri] object to generate an email to the chosen [email] that
  /// includes the [link] used to invite users. Additionally, take the user
  /// to their native emailing app.
  void sendEmail({required String email, required String link}) {
    final Uri emailLaunchUri = Uri(
        scheme: "mailto",
        path: email,
        query: _encodeQueryParameters(<String, String>{
          "subject": "You have been invited to an iPlan event",
          "body": "Upon downloading the iPlan app, on the event organization screen,"
            " enter the following link to be added as a collaborator: $link"
        }));
    launchUrl(emailLaunchUri);
  }

  /// Helper method to [sendEmail] which encodes the parameters [params] per
  /// the heuristic given by [Uri.encodeComponent].
  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}