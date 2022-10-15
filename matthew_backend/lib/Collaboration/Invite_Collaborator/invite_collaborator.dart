import 'package:url_launcher/url_launcher.dart';

class InviteCollaborator {
  void sendSMS({required String phoneNumber, required String link}) {
    final Uri smsLaunchUri = Uri(
        scheme: "sms",
        path: phoneNumber,
        queryParameters: <String, String>{
          "body": "You have been invited to an iPlan event.\n"
            "Upon downloading the iPlan app, on the event organization screen,"
            "paste the following link to be added as a collaborator: $link"
        });
    launchUrl(smsLaunchUri);
  }

  void sendEmail({required String email, required String link}) {
    final Uri emailLaunchUri = Uri(
        scheme: "mailto",
        path: email,
        query: _encodeQueryParameters(<String, String>{
          "subject": "You have been invited to an iPlan event",
          "body": "Upon downloading the iPlan app, on the event organization screen,"
            "paste the following link to be added as a collaborator: $link"
        }));
    launchUrl(emailLaunchUri);
  }

  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
