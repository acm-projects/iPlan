import 'dart:collection';
import 'package:contacts_service/contacts_service.dart';

/// @author [MatthewSheldon]
/// A class that handles the mapping of [String] names to [Contact] contact information
/// Has methods to return lists of names that contain a substring, begin with a prefix,
/// and return the appropriate [Contact] class information. When constructed, requires
/// the list of contacts that are a part of the user's native OS contacts app.
class ContactMap {
  /// The mapping of [String] names to [Contact] contacts.
  late HashMap<String, Contact> _nameToContact;

  /// Constructs a [ContactMap] object with the required passed parameter [contacts]
  /// which are the list of [Contact] objects that the user wishes to query over.
  ContactMap({required List<Contact> contacts}) {
    _nameToContact = HashMap<String, Contact>();
    for (Contact contact in contacts) {
      _nameToContact["${contact.displayName}"] = contact;
    }
  }

  /// Returns a list of [String] names, all of which are both contained within
  /// the [_nameToContact] map and begin with the passed [prefix].
  List<String> getNamesWithPrefix({required String prefix}) {
    List<String> namesWithPrefix = <String>[];
    for (String currName in _nameToContact.keys.toList()..sort()) {
      if (currName.substring(0, prefix.length) == prefix) {
        namesWithPrefix.add(currName);
      }
    }
    return namesWithPrefix;
  }

  /// Returns a list of [String] names, all of which are both contained within
  /// the [_nameToContact] map and contain the passed [substring].
  List<String> getNamesThatContain({required String substring}) {
    List<String> namesThatContain = <String>[];
    for (String currName in _nameToContact.keys.toList()..sort()) {
      if (currName.contains(substring)) {
        namesThatContain.add(currName);
      }
    }
    return namesThatContain;
  }

  /// Returns the [Contact] object that [name] maps to in [_nameToContact].
  Contact getContactFromName({required String name}) {
    return _nameToContact[name]!;
  }

  /// Returns a list of [Contact] objects which map to the passed list of [names]
  List<Contact> getContactsFromNames({required List<String> names}) {
    List<Contact> contacts = <Contact>[];
    for (String name in names) {
      contacts.add(_nameToContact[name]!);
    }
    return contacts;
  }
}