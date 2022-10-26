import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

import 'event.dart';
import '../User_Creation/user.dart';

/// @author [MatthewSheldon]
/// Used to create and join new or existing events. If the user is wanting to
/// create a new event, use [createEvent]. If the user is wanting to join
/// an existing event via an invite link, use [joinEventFromLink].
class EventCreator {
  /// Represents the number of characters in an event link
  static const eventLinkLength = 20;

  /// Code returned when [createEvent] or [joinEventFromLink] encountered no errors
  static const success = 0;

  /// Code returned when [createEvent] or [joinEventFromLink] could not retrieve
  /// the event file for the passed link
  static const eventFileFetchFailed = 1;

  /// Code returned when [createEvent] or [joinEventFromLink] could not update
  /// the event file for the passed link
  static const eventUpdateFailed = 2;

  /// Code returned when [createEvent] or [joinEventFromLink] could not update
  /// the user file for the passed [User] object
  static const userUpdateFailed = 3;

  //static Event createEvent() {}

  /// Given the passed [User] object, retrieve the cooresponding [Event]
  /// object from the cloud using the passed [link]. If the link is longer
  /// than the 20 characters associated with an event ID, then additionally
  /// update the Event's list of collaborators with the new [User] object.
  /// Returns the code and the updated [User] object if nothing critical failed.
  static Future<List<dynamic>> joinEventFromLink(
      {required User user, required String link}) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    List<dynamic> ans = <dynamic>[];
    String oldUserID = "";

    // If the length of the link does not equal just the length of the event ID...
    if (link.length != eventLinkLength) {
      // ...Then the user was directly invited, so additional overhead is needed
      oldUserID = link.substring(eventLinkLength);
      link = link.substring(0, eventLinkLength);
    }

    // Attempt to retrieve the json file for the event
    var json;
    try {
      json =
          await FirebaseFirestore.instance.collection("events").doc(link).get();
      user.addEventID(eventID: link);
    } catch (e) {
      ans[0] = eventFileFetchFailed;
      return ans;
    }

    // Create the event object from the json file
    Event event = Event.fromJson(json: json, link: link);
    // If the user was directly invited...
    if (link.length != eventLinkLength) {
      // Update the Collaborator object that temporarially was assigned to them
      event.updateCollaborator(oldUserID: oldUserID, user: user);
    } else {
      event.addCollaboratorFromUser(user: user);
    }

    // Attempt to update the event document to reflect the new or updated collaborator
    bool failed = await _updateEventDocumentInCloud(link: link, event: event);

    // If _updateEventDocumentInCloud failed, the return the proper error code
    if (failed) {
      ans[0] = eventUpdateFailed;
      return ans;
    }

    // Add the event id and event object to the user object
    user.addEventID(eventID: link);
    user.addEvent(event: event);

    // Attempt to update the user document to reflect the updated user
    failed = await _updateUserDocumentInCloud(user: user);

    // If _updateUserDocumentInCloud failed, return the proper error code; 
    // otherwise, return the success code and updated user object
    ans[0] = failed ? userUpdateFailed : success;
    ans[1] = user;
    return ans;
  }

  /// Attempt to update the passed event document described by [link]
  /// with the passed [Event] object described by [event]
  static Future<bool> _updateEventDocumentInCloud(
      {required String link, required Event event}) async {
    try {
      await FirebaseFirestore.instance
          .collection("events")
          .doc(link)
          .set(event.toJson());
    } catch (e) {
      print(e);
      return true; // Failed
    }
    return false; // Did not fail
  }

  /// Attempt to update the passed user document described by [user.getUserID]
  /// with the passed [User] object described by [user]
  static Future<bool> _updateUserDocumentInCloud({required User user}) async {
    try {
      await FirebaseFirestore.instance
          .collection("user id to events")
          .doc(user.getUserID())
          .update(user.toJson());
    } catch (e) {
      return true;
    }
    return false;
  }
}
