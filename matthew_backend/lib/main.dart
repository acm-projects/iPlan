import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:matthew_backend/Collaboration/Invite_Collaborator/invite_collaborator.dart';
import 'Collaboration/collaboration_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CollaborationPage collaborationPage =
      CollaborationPage(title: "Test Event", date: "October 12, 2022");
  await collaborationPage.constructorHelperMethod();

  print("Title: ${collaborationPage.getTitle()}");
  print("Date: ${collaborationPage.getDate()}");

  print("Names that contain \"Sheldon\":\n");
  List<String> matchingNames =
      await collaborationPage.getNamesFromSearch(substring: "Sheldon");
  String output = "[";
  for (String name in matchingNames) {
    output += "$name, ";
  }
  output = output.substring(0, output.length - 2);
  output += "]";
  print(output);

  print("Contacts that contain \"Sheldon\":\n");
  List<Contact> matchingContacts =
      await collaborationPage.getContactsFromSearch(substring: "Sheldon");
  for (Contact contact in matchingContacts) {
    print(collaborationPage.contactToString(contact: contact));
  }

  print("Names that contain \"ab\":\n");
  matchingNames = await collaborationPage.getNamesFromSearch(substring: "ab");
  output = "[";
  for (String name in matchingNames) {
    output += "$name, ";
  }
  output = output.substring(0, output.length - 2);
  output += "]";
  print(output);

  InviteCollaborator invite = InviteCollaborator();
  // invite.sendEmail(
  //     email: "punchwood2003@gmail.com",
  //     link: "https://www.youtube.com/watch?v=dQw4w9WgXcQ");
  invite.sendSMS(
      phoneNumber: "4694307144",
      link: "https://www.youtube.com/watch?v=dQw4w9WgXcQ");
}
