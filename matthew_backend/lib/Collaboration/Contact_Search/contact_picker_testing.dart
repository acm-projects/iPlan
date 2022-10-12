import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stopwatch stopwatch = Stopwatch();
  stopwatch.start();
  print("Program started\n");

  print("Requesting permission for access to contacts\n");
  PermissionStatus? contactPermission = await Permission.contacts.status;
  if (contactPermission!.isDenied) {
    print("Contact permissions are required to use the collaboration feature. \nPlease allow contact permissions.");
    Map<Permission, PermissionStatus> status = await [Permission.contacts].request();
    contactPermission = status[Permission.contacts];
  }

  contactPermission = await Permission.contacts.status;
  if (contactPermission!.isDenied) {
    print("In order to use the Collaborate feature of this app, please enable contact permissions");
    openAppSettings();
  } else if (contactPermission!.isGranted) {
    print("Accessing all contacts on the current devide\n");
    List<Contact> contacts = await ContactsService.getContacts();
    print("Printing all contacts including name, email, and phone number\n");
    for (Contact curr in contacts) {
      print("${curr.displayName}${curr.company == null ? "" : " (${curr.company})"}:\n");
      List<Item>? emails = curr.emails;
      if (emails!.isNotEmpty) {
        print("\tEmails:\n");
        for (int i = 0; i < emails.length; i++) {
          print("\t\t-> ${emails[i].value}\n");
        }
      }
      List<Item>? phoneNumbers = curr.phones;
      if (phoneNumbers!.isNotEmpty) {
        print("\tPhone Numbers:\n");
        for (int i = 0; i < phoneNumbers.length; i++) {
          print("\t\t-> ${phoneNumbers[i].value}\n");
        }
      }
      List<PostalAddress>? addresses = curr.postalAddresses;
      if (addresses!.isNotEmpty) {
        print("\tAddresses:\n");
        for (int i = 0; i < addresses.length; i++) {
          print("\t\t-> ${addresses[i].toString().trim().replaceAll("\n", " ")}\n");
        }
      }
    }
  }

  stopwatch.stop();
  print("Program finished in ${stopwatch.elapsed} seconds");
}
