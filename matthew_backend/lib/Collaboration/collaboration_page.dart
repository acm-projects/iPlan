import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

import '../page_type.dart';
import 'Contact_Search/contact_mapper.dart';
import 'Contact_Search/contact_puller.dart';
import 'collaborator.dart';

///
class CollaborationPage {
  /// The list of [Collaborator] objects for the current event
  late List<Collaborator> _collaborators;

  /// The mapping between names of contacts and [Contact] objects
  late ContactMap _contactMap;

  /// The tool used to request contact permissions and scrape the user's contacts
  late ContactPuller _contactPuller;

  /// The invite link that can be sent to users to allow them to collaborate as well
  late String _inviteLink;

  /// The title of the event
  late String _title;

  /// The date of the event
  late String _date;

  late bool _contactPermissionsEnabled;

  /// Creates a [CollaborationPage] object with the passed [title] and [date]
  /// parameters. The invite link will be created as time goes on.
  CollaborationPage({required String title, required String date}) {
    _title = title;
    _date = date;
  }

  /// Used by the [CollaborationPage] constructor to mitigate the issue of
  /// asynchronous methods and constructor conflicts. Finished initializing
  /// the [ContactPuller] and [ContactMap] objects.
  Future<bool> constructorHelperMethod() async {
    WidgetsFlutterBinding.ensureInitialized();
    _contactPuller = ContactPuller();
    _contactPuller.requestContactPermissions();
    PermissionStatus permissionStatus =
        await _contactPuller.getCurrentContactPermissionStatus();
    print(permissionStatus.isGranted);
    if (permissionStatus.isGranted) {
      print("permission granted");
      _contactPermissionsEnabled = true;
      List<Contact> contacts = await _contactPuller.getContactsFromOS();
      _contactMap = ContactMap(contacts: contacts);
      print("map initialized");
    } else {
      print("permission not granted");
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
    return _collaborators;
  }

  /// Returns a list of names that match the [substring] parameter.
  Future<List<String>> getNamesFromSearch({required String substring}) async {
    if (await _contactPuller.getCurrentContactPermissionStatus().isGranted) {
      return _contactMap.getNamesThatContain(substring: substring);
    } else {
      return <String>[];
    }
  }

  /// Returns a list of Contacts that match the [substring] parameter.
  Future<List<Contact>> getContactsFromSearch(
      {required String substring}) async {
    return _contactMap.getContactsFromNames(
        names: await getNamesFromSearch(substring: substring));
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

  void addCollaborator({required Contact contact, required bool useEmail}) {
    if (useEmail) {
      List<Item> emails = contact.emails!;
      _collaborators.add(
          Collaborator(name: contact.displayName!, email: emails[0].value!));
    } else {
      List<Item> phoneNumbers = contact.phones!;
      _collaborators.add(Collaborator(
          name: contact.displayName!, phoneNumber: phoneNumbers[0].value!));
    }
  }
}
