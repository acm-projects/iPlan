import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../../Backend/Collaboration/Invite_Collaborator/invite_collaborator.dart';
import '../../Backend/Collaboration/collaboration_page.dart';
import '../../Backend/Collaboration/Collaborator/collaborator.dart';
import 'package:google_fonts/google_fonts.dart';

//CASI - Changed to GoogleFont style
class CollaborateTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Collaborate', style: GoogleFonts.lato(fontSize: 50.0, color: Color(0xFFFEF7EC), fontWeight: FontWeight.bold))
    );
  }
}

//CASI - Changed to StatefulWidget
class WhiteSquare extends StatefulWidget {
  late InviteCollaborator inviteCollaborator;
  late CollaborationPage collaborationPage;
  late TextEditingController searchBarTextRetrieval = TextEditingController();

  WhiteSquare(
      {required this.inviteCollaborator,
      required this.collaborationPage,
      required this.searchBarTextRetrieval});

  @override
  State<WhiteSquare> createState() => _WhiteSquareState();
}

class _WhiteSquareState extends State<WhiteSquare> {
  late List<String> contacts;

  String selectedContact = "";

  @override
  Widget build(BuildContext context) {
    contacts = widget.collaborationPage.getNamesFromSearch(substring: "");
    List<Collaborator> collaborators = widget.collaborationPage.getCollaborators();
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
          ? Text("Collaborator", style: GoogleFonts.lato())
          : Wrap(
              spacing: 2,
              children: <Widget>[
                const Icon(Icons.check, color: Colors.black, size: 17),
                Text("Invited", style: GoogleFonts.lato()),
              ],
            );

      collaboratorsToDisplay.add(ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 40.0),
          leading: const CircleAvatar(
              radius: 20,
              backgroundColor: Color(0xFFA3B0EB),
              child: Icon(Icons.person, color: Color(0xFFFEF7EC))),
          title: Text("${collaborator.getName()}", style: GoogleFonts.lato()),
          subtitle: Text("$contactInformation", style: GoogleFonts.lato()),
          trailing: trailing));
          setState(() {});

    }

    return Container(
        height: 683.4,
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
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(width: 4, color: Color(0xFF657BE3)),
                    ),
                    child: Column(
                      children: [
                        Text("${widget.collaborationPage.getTitle()}",
                            style: GoogleFonts.lato(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text("${widget.collaborationPage.getDate()}", style: GoogleFonts.lato())
                      ],
                    )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                child: Text('Share Invitation', style: GoogleFonts.lato(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w400)),
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
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF657BE3),
                            width: 1
                          ),
                          borderRadius: BorderRadius.circular(15)
                        ),
                      ),
                      searchFieldProps: TextFieldProps(
                        cursorColor: Color(0xFF657BE3),
                      ),
                      onChanged: (String? value) {
                        if (value != null) {
                          selectedContact = value;
                          Contact contact = widget.collaborationPage
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
                          setState(() {}); //CAsi - Set State
                          (contact.emails!.isNotEmpty)
                              ? widget.inviteCollaborator.sendEmail(
                                  email: contactInfo,
                                  link: widget.collaborationPage.getInviteLink())
                              : widget.inviteCollaborator.sendSMS(
                                  phoneNumber: contactInfo,
                                  link: widget.collaborationPage.getInviteLink());

                          for (Collaborator temp in collaborators) {
                            print(temp);
                          }
                        }
                      },
                    )),
              ),
              SizedBox(
                height: 800,
                child: Expanded(
                    child: ListView.builder(
                      itemCount: collaboratorsToDisplay.length,
                      itemBuilder: (context, index){
                      return collaboratorsToDisplay[index];
                      }
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                    child: Row(children: [
                      Icon(Icons.link, size: 25, color: Colors.black),
                      Text("     Copy Link",
                          style: GoogleFonts.lato(
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

//CASI - Turned Stateful
class Collaboration extends StatefulWidget {
  final InviteCollaborator? inviteCollaborator;
  final CollaborationPage? collaborationPage;
  final TextEditingController? searchBarTextRetrieval;
  const Collaboration(
      {super.key,
      this.inviteCollaborator,
      this.collaborationPage,
      required this.searchBarTextRetrieval});

  @override
  State<Collaboration> createState() => _CollaborationState();
}

class _CollaborationState extends State<Collaboration> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'iPlan',
        home: Scaffold(
          backgroundColor: Color(0xFF657BE3),
          body: SingleChildScrollView(
            child: Center(
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 5.0),
                        child: CollaborateTitle(),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 9.0, 0.0, 0.0),
                        //container widget that includes all other widgets
                        child: WhiteSquare(
                          inviteCollaborator: this.widget.inviteCollaborator!,
                          collaborationPage: this.widget.collaborationPage!,
                          searchBarTextRetrieval: this.widget.searchBarTextRetrieval!,
                        )),
                  ],
                ),
              
            ),
          ),

          //Casi - Changed Nav bar
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Color(0xFFA3B0EB),
            selectedItemColor: Color.fromRGBO(254, 247, 236, 1),
            unselectedItemColor: Colors.black,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home, size: 30), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.calendar_month, size: 30), label: 'Calendar'),
              BottomNavigationBarItem(icon: Icon(Icons.wallet, size: 30), label: 'Budget'),
              BottomNavigationBarItem(icon: Icon(Icons.schedule, size: 30), label: 'Itinerary'),
              BottomNavigationBarItem(icon: Icon(Icons.person_add, size: 30), label: 'Collaborate'),
              BottomNavigationBarItem(icon: Icon(Icons.settings, size: 30), label: 'Settings')
            ]
          ),
        )
      );
  }
}