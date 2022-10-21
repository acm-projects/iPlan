import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:matthew_backend/Collaboration/Invite_Collaborator/invite_collaborator.dart';
import 'package:matthew_backend/Collaboration/collaboration_page.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'Collaboration/Collaborator/collaborator.dart';

void main() async {
  CollaborationPage collaborationPage =
      CollaborationPage(title: "Event Name", date: "April 25, 2022");
  await collaborationPage.constructorHelperMethod();
  Contact matthew =
      collaborationPage.getContactsFromSearch(substring: "Matthew Sheldon")[0];
  collaborationPage.addCollaborator(
      contact: matthew, useEmail: true, hasAccepted: true);
  Contact veda = collaborationPage.getContactsFromSearch(substring: "Veda")[0];
  collaborationPage.addCollaborator(
      contact: veda, useEmail: false, hasAccepted: true);
  Contact casi = collaborationPage.getContactsFromSearch(substring: "Casi")[0];
  collaborationPage.addCollaborator(
      contact: casi, useEmail: false, hasAccepted: false);
  InviteCollaborator inviteCollaborator = InviteCollaborator();
  TextEditingController searchBarTextRetrieval = TextEditingController();
  runApp(MyApp(
      collaborationPage: collaborationPage,
      inviteCollaborator: inviteCollaborator,
      searchBarTextRetrieval: searchBarTextRetrieval));
}

class CollaborateTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text.rich(
        TextSpan(
          text: '',
          children: [
            TextSpan(
                text: 'Collaborate',
                style: TextStyle(
                    fontSize: 50.0,
                    color: Color(0xFFFEF7EC),
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class WhiteSquare extends StatelessWidget {
  late InviteCollaborator inviteCollaborator;
  late CollaborationPage collaborationPage;
  late TextEditingController searchBarTextRetrieval = TextEditingController();
  late List<String> contacts;
  String selectedContact = "";

  WhiteSquare(
      {required this.inviteCollaborator,
      required this.collaborationPage,
      required this.searchBarTextRetrieval});

  @override
  Widget build(BuildContext context) {
    contacts = collaborationPage.getNamesFromSearch(substring: "");
    List<Collaborator> collaborators = collaborationPage.getCollaborators();
    collaborators.sort();
    List<ListTile> collaboratorsToDisplay = <ListTile>[];
    for (Collaborator collaborator in collaborators) {
      String contactInformation = "";
      if (collaborator.getEmail() != "null") {
        contactInformation = collaborator.getEmail();
      } else if (collaborator.getPhoneNumber() != "null") {
        contactInformation = collaborator.getPhoneNumber();
      }

      Widget trailing = collaborator.hasAccepted()
          ? Text("Collaborator")
          : Wrap(
              spacing: 2,
              children: const <Widget>[
                Icon(Icons.check, color: Colors.black, size: 17),
                Text("Invited"),
              ],
            );

      collaboratorsToDisplay.add(ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 40.0),
          leading: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Color(0xFFFEF7EC))),
          title: Text("${collaborator.getName()}"),
          subtitle: Text("$contactInformation"),
          trailing: trailing));
    }

    return Container(
        height: 600.0,
        color: Colors.transparent,
        child: Container(
            decoration: const BoxDecoration(
                color: Color(0xFFFEF7EC),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20.0),
                  topRight: const Radius.circular(20.0),
                )),
            child: ListView(children: [
              Padding(
                padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 15.0),
                child: Container(
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(width: 5, color: Color(0xFF657BE3)),
                    ),
                    child: Column(
                      children: [
                        Text("${collaborationPage.getTitle()}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text("${collaborationPage.getDate()}")
                      ],
                    )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                child: const Text.rich(
                  TextSpan(
                    text: '',
                    children: [
                      TextSpan(
                          text: 'Share Invitation',
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
                child: SizedBox(
                    height: 40,
                    child: DropdownSearch<String>(
                      mode: Mode.MENU,
                      showSearchBox: true,
                      showClearButton: true,
                      showSelectedItems: true,
                      items: contacts,
                      dropdownSearchDecoration: InputDecoration(
                        labelText: "Search Contacts",
                      ),
                      onChanged: (String? value) {
                        if (value != null) {
                          selectedContact = value;
                          Contact contact = collaborationPage
                              .getContactsFromSearch(substring: value)[0];
                          String contactInfo = (contact.emails!.isNotEmpty)
                              ? contact.emails![0].value!
                              : contact.phones![0].value!;
                          Collaborator collaborator =
                              (contact.emails!.isNotEmpty)
                                  ? Collaborator(
                                      name: value,
                                      email: contactInfo,
                                      hasAccepted: false)
                                  : Collaborator(
                                      name: value,
                                      phoneNumber: contactInfo,
                                      hasAccepted: false);
                          collaborators.add(collaborator);
                          (contact.emails!.isNotEmpty)
                              ? inviteCollaborator.sendEmail(
                                  email: contactInfo,
                                  link: collaborationPage.getInviteLink())
                              : inviteCollaborator.sendSMS(
                                  phoneNumber: contactInfo,
                                  link: collaborationPage.getInviteLink());

                          for (Collaborator temp in collaborators) {
                            print(temp);
                          }
                        }
                      },
                    )),
              ),
              SingleChildScrollView(
                child: Column(children: collaboratorsToDisplay),
              ),
              Center(
                child: ElevatedButton(
                    child: Row(children: [
                      Icon(Icons.link, size: 25, color: Colors.black),
                      Text("     Copy Link",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black))
                    ]),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      fixedSize: Size(190, 30),
                      primary: Color(0xFFBAE365),
                    )),
              )
            ])));
  }
}

class MyApp extends StatelessWidget {
  final InviteCollaborator? inviteCollaborator;
  final CollaborationPage? collaborationPage;
  final TextEditingController? searchBarTextRetrieval;
  const MyApp(
      {super.key,
      this.inviteCollaborator,
      this.collaborationPage,
      required this.searchBarTextRetrieval});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'iPlan',
        home: Scaffold(
          backgroundColor: Color(0xFF657BE3),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 5.0),
                      //widget that has title of page
                      child: CollaborateTitle()),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 9.0, 0.0, 0.0),
                      //container widget that includes all other widgets
                      child: WhiteSquare(
                        inviteCollaborator: this.inviteCollaborator!,
                        collaborationPage: this.collaborationPage!,
                        searchBarTextRetrieval: this.searchBarTextRetrieval!,
                      )),
                ],
              ),
            ),
          ),

          //Navigation Bar with Icons
          bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.house, color: Colors.black, size: 30),
                    label: 'home',
                    backgroundColor: Color(0xFFA3B0EB)),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person, color: Colors.black, size: 30),
                    label: 'collaborate',
                    backgroundColor: Color(0xFFA3B0EB)),
                BottomNavigationBarItem(
                    icon: Icon(Icons.list, color: Colors.black, size: 30),
                    label: 'itinerary',
                    backgroundColor: Color(0xFFA3B0EB)),
                BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_month,
                        color: Colors.black, size: 30),
                    label: 'calendar',
                    backgroundColor: Color(0xFFA3B0EB)),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings, color: Colors.black, size: 30),
                    label: 'settings',
                    backgroundColor: Color(0xFFA3B0EB))
              ]),
        ));
  }
}
