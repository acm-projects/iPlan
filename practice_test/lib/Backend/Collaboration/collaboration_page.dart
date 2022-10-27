import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

import '../User_Creation/user.dart';
import '../Navigation_Bar/page_type.dart';
import 'Contact_Search/contact_mapper.dart';
import 'Contact_Search/contact_puller.dart';
import 'Collaborator/collaborator.dart';
import 'Collaborator/null_parameter_exception.dart';

/// @author [MatthewSheldon]
/// The [CollaborationPage] class implements the use of classes like [ContactMap]
/// and [ContactPuller] to request contact permissions, retrieve contacts from the
/// user's native OS contacts app, store and mannage current [Collaborator]
/// objects, and search the user's contacts for people who's display names match
/// or contain a certain substring.
class CollaborationPage {
  /// The list of [Collaborator] objects for the current event
  late List<Collaborator> _collaborators;

  /// The list of [Contact] objects for the current user
  late List<Contact> _contacts;

  /// The mapping between names of contacts and [Contact] objects
  late ContactMap
      _contactMap; // TODO: remove [ContactMap] if it is no longer a needed class

  /// The tool used to request contact permissions and scrape the user's contacts
  late ContactPuller _contactPuller;

  /// The invite link that can be sent to users to allow them to collaborate
  late String _inviteLink;

  /// The title of the event
  late String _title;

  /// The date of the event
  late String _date;

  /// Whether or not the user has enabled contact permissions. This will
  /// drastically change the behavior of the page if they are turned off.
  late bool _contactPermissionsEnabled;

  /// Creates a [CollaborationPage] object with the passed [title] and [date]
  /// parameters. The invite link will be created as time goes on.
  CollaborationPage(
      {required String title, required String date, required String link}) {
    _title = title;
    _date = date;
    _collaborators = <Collaborator>[];
    _inviteLink = link;
  }

  /// Constructs a [CollaborationPage] object from the passed [json] and [link] parameters
  CollaborationPage.fromJson(
      {required Map<String, dynamic> json, required String link}) {
    _title = json["title"];
    _date = json["date"];
    List<dynamic> collaboratorsData = json["collaborators"] as List<dynamic>;
    _collaborators = collaboratorsData
        .map((collaborator) => Collaborator.fromJson(collaborator))
        .toList();
    _inviteLink = link;
  }

  /// Used by the [CollaborationPage] constructor to mitigate the issue of
  /// asynchronous methods and constructor conflicts. Finished initializing
  /// the [ContactPuller] and [ContactMap] objects.
  Future<bool> constructorHelperMethod() async {
    _contactPuller = ContactPuller();
    await _contactPuller.requestContactPermissions();
    PermissionStatus permissionStatus =
        await _contactPuller.getCurrentContactPermissionStatus();

    if (permissionStatus.isGranted) {
      _contactPermissionsEnabled = true;
      _contacts = await _contactPuller.getContactsFromOS();
      _contactMap = ContactMap(contacts: _contacts);
    } else {
      _contactPermissionsEnabled = false;
      _contactPuller.openSettings();
    }
    return true;
  }

  /// Returns a [PageType] object representing the page that the user should
  /// be returned to given that they are currently on the Collaboration Page
  PageType backButton() {
    return PageType.homeScreen;
  }

  /// Returns the [_title] of the event
  String getTitle() {
    return _title;
  }

  /// Returns the [_date] of the event
  String getDate() {
    return _date;
  }

  /// Returns the [_inviteLink] of the event
  String getInviteLink() {
    return _inviteLink;
  }

  /// Returns the current state of contact permissions
  bool isContactPermissionsEnabled() {
    return _contactPermissionsEnabled;
  }

  /// Returns a list of the current people who have either been invited to
  /// collaborate or are active collaborators.
  List<Collaborator> getCollaborators() {
    return _contactPermissionsEnabled ? _collaborators : <Collaborator>[];
  }

  /// Returns a list of names that match the [substring] parameter.
  List<String> getNamesFromSearch({required String substring}) {
    return _contactPermissionsEnabled
        ? _contactMap.getNamesThatContain(substring: substring)
        : <String>[];
  }

  /// Returns a list of Contacts that match the [substring] parameter.
  List<Contact> getContactsFromSearch({required String substring}) {
    return _contactPermissionsEnabled
        ? _contactMap.getContactsFromNames(
            names: getNamesFromSearch(substring: substring))
        : <Contact>[];
  }

  /// Returns a [String] representation of the passed [contact] parameter
  String contactToString({required Contact contact}) {
    String output =
        "${contact.displayName}${contact.company == null ? "" : " (${contact.company})"}:\n";
    List<Item>? emails = contact.emails;
    if (emails!.isNotEmpty) {
      output += "\tEmails:\n";
      for (int i = 0; i < emails.length; i++) {
        output += "\t\t-> ${emails[i].value}\n";
      }
    }
    List<Item>? phoneNumbers = contact.phones;
    if (phoneNumbers!.isNotEmpty) {
      output += "\tPhone Numbers:\n";
      for (int i = 0; i < phoneNumbers.length; i++) {
        output += "\t\t-> ${phoneNumbers[i].value}\n";
      }
    }
    return output;
  }

  /// Given the passed paramater [contact], create and add a [Collaborator] object
  /// to [_collaborators] using either the email or phone number denoted by the
  /// value of the parameter [useEmail]. If the passed [contact] paramaeter does
  /// not include the type of contact information denoted by [useEmail], then
  /// [addCollaborator] will throw a [NullParameterException].
  void addCollaborator(
      {required Contact contact,
      required bool useEmail,
      required bool hasAccepted}) {
    if (useEmail) {
      List<Item> emails = contact.emails!;
      try {
        _collaborators.add(Collaborator(
            name: contact.displayName!,
            email: emails[0].value!,
            hasAccepted: hasAccepted));
      } catch (e) {
        print("Collaborator was attempted to be made with email, "
            "but no email exists for ${contact.displayName}'s contact.");
        print(e);
      }
    } else {
      List<Item> phoneNumbers = contact.phones!;
      try {
        _collaborators.add(Collaborator(
            name: contact.displayName!,
            phoneNumber: phoneNumbers[0].value!,
            hasAccepted: hasAccepted));
      } catch (e) {
        print("Collaborator was attempted to be made with phone number, "
            "but no phone number exists for ${contact.displayName}'s contact.");
        print(e);
      }
    }
  }

  /// Adds the passed [User] object as a [Collaborator] object to the [_collaborators] list
  void addCollaboratorFromUser({required User user}) {
    _collaborators.add(Collaborator.fromUser(user: user));
  }

  /// Updates the [Collaborator] object described by the passed [oldUserID]
  /// parameter with the information contained in the passed [User] object
  void updateCollaborator({required String oldUserID, required User user}) {
    for (int i = 0; i < _collaborators.length; i++) {
      Collaborator collaborator = _collaborators[i];
      if (collaborator.getUserID() == oldUserID) {
        collaborator.updateUserID(userID: user.getUserID());
        collaborator.updateEmail(email: user.getEmail());
        collaborator.updateName(name: user.getUserName());
        collaborator.updateHasAccepted(hasAccepted: true);
        break;
      }
    }
  }

  /// Deconstructs the current [CollaborationPage] object in a JSON format
  Map<String, dynamic> toJson() {
    return {
      "date": _date,
      "collaborators":
          _collaborators.map((collaborator) => collaborator.toJson()).toList(),
      "title": _title
    };
  }
}
