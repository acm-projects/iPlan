import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// @author [MatthewSheldon]
/// A class that handles the monitoring and requesting of contact permissions
/// via the [Permission] class from the [contacts_service] API. Additionally, 
/// [ContactPuller] is able to retrieve a list of [Contact] objects which is 
/// returned from the native OS's contacts app once contact permissions
/// have been granted by the user. 
class ContactPuller {
  /// Constructs a [ContactPuller] object after having ensured that all 
  /// dependencies are properly initialized via the [ensureInitialized] method.
  ContactPuller() {
    WidgetsFlutterBinding.ensureInitialized();
  }

  /// Uses the [Permission] class from the [permission_handler] api to 
  /// retrieve the current status of whether or not the user has allowed
  /// the app contact permissions. Returns the current status.
  Future<PermissionStatus> getCurrentContactPermissionStatus() async {
    return await Permission.contacts.status;
  }

  /// Uses the [Permission] class from the [permission_handler] api to
  /// request the user for the app to have contact permissions. Will fail to 
  /// print the native OS's prompt to the screen if the user has previously 
  /// denied permissions. If that is the case, then use the [openSettings] method.
  Future<Map<Permission, PermissionStatus>> requestContactPermissions() async {
    return await [Permission.contacts].request();
  }

  /// If contact permissions have been granted, then use the [ContactsService] 
  /// class from the [contacts_service] api to scrape all of the contacts from
  /// the user's native OS's contacts app. Otherwise, return an empty list.
  Future<List<Contact>> getContactsFromOS() async {
    if (await getCurrentContactPermissionStatus().isGranted) {
      return await ContactsService.getContacts();
    } else {
      return <Contact>[];
    }
  }

  /// Used to take the user to the settings page so that they can manually grant
  /// contact permissions. Should be used in place of the pop-up prompt after
  /// the first attempt.
  void openSettings() {
    openAppSettings();
  }
}