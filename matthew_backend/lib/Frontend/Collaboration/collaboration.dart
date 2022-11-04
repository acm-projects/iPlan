import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Backend/Authentication/invite_user.dart';
import '../../Backend/Authentication/update_files.dart';
import '../../Backend/Collaboration/collaboration_page.dart';
import '../../Backend/Collaboration/Collaborator/collaborator.dart';
import '../../Backend/Collaboration/Invite_Collaborator/invite_collaborator.dart';
import '../../Backend/Event_Manager/event.dart';
import '../../Backend/User_Creation/user.dart';

/// The [User] object that needs to be updated
late User _user;

/// The [Event] object that needs to be updated
late Event _event;

/// The [CollaborationPage] object of the current [User] object
late CollaborationPage _collaborationPage;

/// The [TextEditingController] to retrieve the name of the contact being added
late TextEditingController _searchBarTextRetrieval;

/// The list of names of contacts for the current device
late List<String> _contacts;

/// The contact that was selected
String _selectedContact = "";

/// Used to update the [Event] object in the cloud
void _updateEventObject() async {
  _event.updateCollaborationPage(collaborationPage: _collaborationPage);
  _user.updateEvent(eventID: _event.getLink(), event: _event);
  bool result = await UpdateFiles.updateEventFile(
      documentID: _event.getLink(), json: _event.toJson());
  print(result);
}

//CASI - Changed to GoogleFont style
class CollaborateTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('Collaborate',
            style: GoogleFonts.lato(
                fontSize: 50.0,
                color: Color(0xFFFEF7EC),
                fontWeight: FontWeight.bold)));
  }
}

//CASI - Turned Stateful
class Collaboration extends StatefulWidget {
  Collaboration({super.key, required User user, required Event event}) {
    _user = user;
    _event = event;
    _collaborationPage = event.getCollaborationPage();
    _searchBarTextRetrieval = TextEditingController();
  }

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
                      child: WhiteSquare()),
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
                BottomNavigationBarItem(
                    icon: Icon(Icons.home, size: 30), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_month, size: 30),
                    label: 'Calendar'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.wallet, size: 30), label: 'Budget'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.schedule, size: 30), label: 'Itinerary'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_add, size: 30),
                    label: 'Collaborate'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings, size: 30), label: 'Settings')
              ]),
        ));
  }
}

//CASI - Changed to StatefulWidget
class WhiteSquare extends StatefulWidget {
  WhiteSquare({super.key});

  @override
  State<WhiteSquare> createState() => _WhiteSquareState();
}

class _WhiteSquareState extends State<WhiteSquare> {
  /// @author [MatthewSheldon]
  /// Method called when a collaborator is added to the event
  Future _updateCollaborators({required String? value}) async {
    // If the contact name entered is valid...
    if (value != null) {
      // Update the selected contact
      _selectedContact = value;
      // Retrieve the first contact with that name
      Contact contact =
          _collaborationPage.getContactsFromSearch(substring: value)[0];
      // Retrieve their contact information
      String contactInfo = (contact.emails!.isNotEmpty)
          ? contact.emails![0].value!
          : contact.phones![0].value!;
      // Generate a temporary user ID
      String tempUserID = await InviteUser.addCollaborator();
      // Create a Collaborator object with that information
      Collaborator collaborator = (contact.emails!.isNotEmpty)
          ? Collaborator(
              userID: tempUserID,
              name: value,
              email: contactInfo,
              hasAccepted: false)
          : Collaborator(
              userID: tempUserID,
              name: value,
              phoneNumber: contactInfo,
              hasAccepted: false);
      // Add them to the list of collaborators
      _collaborationPage.addCollaboratorFromCollaborator(
          collaborator: collaborator);
      //CASI - Set State
      setState(() {});
      (contact.emails!.isNotEmpty)
          ? InviteCollaborator.sendEmail(
              email: contactInfo,
              link: _collaborationPage.getInviteLink() + tempUserID)
          : InviteCollaborator.sendSMS(
              phoneNumber: contactInfo,
              link: _collaborationPage.getInviteLink() + tempUserID);
      _updateEventObject();
    }
  }

  @override
  Widget build(BuildContext context) {
    /// @author [MatthewSheldon]

    // Get the list of contacts on the current device
    _contacts = _collaborationPage.getNamesFromSearch(substring: "");

    // Get the list of people who are already collaborators of the event
    List<Collaborator> collaborators = _collaborationPage.getCollaborators();
    collaborators.sort();

    // Construct the list of ListTile object that display the collaborators
    List<ListTile> collaboratorsToDisplay = <ListTile>[];
    for (Collaborator collaborator in collaborators) {
      // Get the contact information to display
      String contactInformation = collaborator.getEmail() != "null"
          ? collaborator.getEmail()
          : collaborator.getPhoneNumber() != "null"
              ? collaborator.getPhoneNumber()
              : "";

      // Get the status of their acceptance and display the proper information
      Widget trailing = collaborator.hasAccepted()
          ? Text("Collaborator", style: GoogleFonts.lato())
          : Wrap(
              spacing: 2,
              children: <Widget>[
                const Icon(Icons.check, color: Colors.black, size: 17),
                Text("Invited", style: GoogleFonts.lato()),
              ],
            );

      // Add the ListTile object to the list
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

    /// end @author [MatthewSheldon]

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
                        Text(_collaborationPage.getTitle(),
                            style: GoogleFonts.lato(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(_collaborationPage.getDate(),
                            style: GoogleFonts.lato())
                      ],
                    )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                child: Text('Share Invitation',
                    style: GoogleFonts.lato(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w400)),
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
                      items: _contacts,
                      dropdownSearchDecoration: InputDecoration(
                        labelText: "Search Contacts",
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xFF657BE3), width: 1),
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      searchFieldProps: TextFieldProps(
                        cursorColor: Color(0xFF657BE3),
                      ),
                      onChanged: (String? value) async {
                        await _updateCollaborators(value: value);
                      },
                    )),
              ),
              SizedBox(
                height: 800,
                child: Expanded(
                  child: ListView.builder(
                      itemCount: collaboratorsToDisplay.length,
                      itemBuilder: (context, index) {
                        return collaboratorsToDisplay[index];
                      }),
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
