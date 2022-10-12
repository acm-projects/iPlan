import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'Collaboration/collaboration_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CollaborationPage collaborationPage =
      CollaborationPage(title: "Test Event", date: "October 12, 2022");
  await collaborationPage.constructorHelperMethod();
  print("Title: ${collaborationPage.getTitle()}");
  print("Date: ${collaborationPage.getDate()}");
  print("Names that contain \"Sheldon\":\n"
    "${collaborationPage.getNamesFromSearch(substring: "Sheldon")}");
  print("Contacts that contain \"Sheldon\":\n");
  List<Contact> matchingContacts = await collaborationPage.getContactsFromSearch(substring: "Sheldon");
  for(Contact contact in matchingContacts) {
    print(collaborationPage.contactToString(contact: contact));
  }
  
}
