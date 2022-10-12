import 'package:contacts_service/contacts_service.dart';
import 'package:matthew_backend/Collaboration/collaboration_page.dart';

void main() async {
  CollaborationPage collaborationPage =
      CollaborationPage(title: "Test Event", date: "October 12, 2022");
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
