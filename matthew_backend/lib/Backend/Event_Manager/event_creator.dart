import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'event.dart';
import '../User_Creation/user.dart';
import '../Authentication/update_files.dart';

/// @author [MatthewSheldon]
/// Used to create and join new or existing events. If the user is wanting to
/// create a new event, use [createEvent]. If the user is wanting to join
/// an existing event via an invite link, use [joinEventFromLink].
class EventCreator {
  /// Represents the number of characters in an event link
  static const eventLinkLength = 20;

  /// Code returned when [createEvent] or [joinEventFromLink] encountered no errors
  static const success = 0;

  /// Code returned when [joinEventFromLink] could not retrieve
  /// the event file for the passed link
  static const eventFileFetchFailed = 1;

  /// Code returned when [createEvent] or [joinEventFromLink] could not update
  /// the event file for the passed link
  static const eventUpdateFailed = 2;

  /// Code returned when [createEvent] or [joinEventFromLink] could not update
  /// the user file for the passed [User] object
  static const userUpdateFailed = 3;

  /// Code returned when [createEvent] could not successfully create a new
  /// event file in the "events" collection.
  static const eventCreationFailed = 4;

  /// Attempts to create a new [Event] object from the passed [eventName] and [date]
  /// and add it to the passed [user] object's list of events. If the event creation,
  /// updating of the event file, or updating of the user file fails, an error
  /// code will be returned. If the operation is successful, then [EventCreator.success]
  /// will be returned along with the [Event] object created.
  static Future<List<dynamic>> createEvent(
      {required String eventName,
      required double budget,
      required DateTime date,
      required TimeOfDay startTime,
      required TimeOfDay endTime,
      required User user}) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    List<dynamic> ans = <dynamic>[];
    String eventID = "";

    // Attempt to create a new event document in the collection "events" in the cloud
    try {
      eventID = await FirebaseFirestore.instance.collection("events").doc().id;
    } catch (e) {
      // The operation failed
      print(e);
      ans.add(eventCreationFailed);
      return ans;
    }

    // Create a new event object
    Event event = Event(
        eventID: eventID,
        user: user,
        title: eventName,
        date: date,
        startTime: startTime,
        endTime: endTime,
        budget: budget);

    // Add the event and event ID to the User object
    user.addEvent(event: event);
    user.addEventID(eventID: eventID);

    // Attempt to update the event file
    bool failed = await UpdateFiles.updateEventFile(
        documentID: eventID, json: event.toJson());

    // If the event failed to be updated, then all progress will be lost
    if (failed) {
      // Delete the document from the system and try again
      await FirebaseFirestore.instance
          .collection("events")
          .doc(eventID)
          .delete();
      ans.add(eventUpdateFailed);
      return ans;
    }

    // Attempt to update the user file
    failed = await UpdateFiles.updateUserFile(
        documentID: user.getUserID(), json: user.toJson());

    // If we failed to update the user file, then no one will ever access this
    // event object in the system.
    if (failed) {
      // Delete the document from the system and try again
      await FirebaseFirestore.instance
          .collection("events")
          .doc(eventID)
          .delete();
      ans.add(userUpdateFailed);
      return ans;
    }

    // Otherwise, the event was successfully created
    ans.add(success);
    ans.add(event);
    return ans;
  }

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
      await FirebaseFirestore.instance
          .collection("events")
          .doc(link)
          .get()
          .then((doc) => json = doc.data() as Map<String, dynamic>);
    } catch (e) {
      ans.add(eventFileFetchFailed);
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
    bool failed = await UpdateFiles.updateEventFile(
        documentID: link, json: event.toJson());

    // If updateEventFile failed, the return the proper error code
    if (failed) {
      ans.add(eventUpdateFailed);
      return ans;
    }

    // Add the event id and event object to the user object
    user.addEventID(eventID: link);
    user.addEvent(event: event);

    // Attempt to update the user document to reflect the updated user
    failed = await UpdateFiles.updateUserFile(
        documentID: user.getUserID(), json: user.toJson());

    // If updateUserFile failed, return the proper error code;
    // otherwise, return the success code and updated user object
    ans.add(failed ? userUpdateFailed : success);
    ans.add(user);
    return ans;
  }
}
