import 'package:flutter/material.dart';

import '../Collaboration/collaboration_page.dart';
import '../Finance/finance_page.dart';
import '../User_Creation/user.dart';

/// @author [MatthewSheldon]
/// Class used for housing all of the different pages, as well as constructing
/// from and deconstructing into a json file that is sent to the cloud.
class Event {
  /// The event id for this [Event] object
  late String _link;

  /// The name of this [Event] object
  late String _eventName;

  /// The date of this [Event] object
  late DateTime _date;

  /// The start time of this [Event] object
  late TimeOfDay _startTime;

  /// The end time of this [Event] object
  late TimeOfDay _endTime;

  /// The [FinancePage] object for this [Event] object
  late FinancePage _financePage;

  /// The [CalendarPage] object for this [Event] object
  //late CalendarPage _calendarPage;

  /// The [ItineraryPage] object for this [Event] object
  //late ItineraryPage _itineraryPage;

  /// The [CollaborationPage] object for this [Event] object
  late CollaborationPage _collaborationPage;

  /// Constructs an [Event] object from the passed [eventID], [title], and [date]
  /// and adds the [user] to the event.
  Event(
      {required String eventID,
      required User user,
      required String title,
      required DateTime date,
      required TimeOfDay startTime,
      required TimeOfDay endTime,
      required double budget}) {
    _link = eventID;
    _eventName = title;
    _date = date;
    _startTime = startTime;
    _endTime = endTime;

    _financePage = FinancePage(totalBudget: budget);
    _collaborationPage = CollaborationPage(
        title: title, date: _convertDateTimeToString(), link: eventID);
    _collaborationPage.addCollaboratorFromUser(user: user);
  }

  /// Constructs an [Event] object from the passed json file and event id (link)
  Event.fromJson({required Map<String, dynamic> json, required String link}) {
    _link = link;
    _eventName = json["eventName"];
    _date = DateTime.parse(json["date"]);
    _startTime = _getTimeFromString(json["startTime"]);
    _endTime = _getTimeFromString(json["endTime"]);

    _financePage = FinancePage.fromJson(json: json["financePage"]);
    // _calendarPage = CalendarPage.fromJson(json: json["calendarPage"]);
    // _itineraryPage = ItineraryPage.fromJson(json: json["itineraryPage"]);
    _collaborationPage =
        CollaborationPage.fromJson(json: json["collaborationPage"], link: link);
  }

  /// Helper method for [Event] constructor that takes the [_date] of the event
  /// and returns the converted [String] equivalent in the form "Month ##, ####"
  String _convertDateTimeToString() {
    List<String> months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return "${months[_date.month - 1]} ${_date.day}, ${_date.year}";
  }

  /// Helper method for [Event.fromJson] constructor that takes a [TimeOfDay] 
  /// formatted [String] and returns the converted [TimeOfDay] equivalent object.
  TimeOfDay _getTimeFromString(String time) {
    List<String> split = time.split(":");
    return TimeOfDay(hour: int.parse(split[0]), minute: int.parse(split[1]));
  }

  /// Returns this [Event] object's [_eventName]
  String getEventName() {
    return _eventName;
  }

  /// Returns this [Event] object's [_date]
  DateTime getDate() {
    return _date;
  }

  /// Returns this [Event] object's [_startTime]
  TimeOfDay getStartTime() {
    return _startTime;
  }

  /// Returns this [Event] object's [_endTime]
  TimeOfDay getEndTime() {
    return _startTime;
  }

  /// Returns this [Event] object's [_link]
  String getLink() {
    return _link;
  }

  /// Returns this [Event] object's [FinancePage] object
  FinancePage getFinancePage() {
    return _financePage;
  }

  /// Returns this [Event] object's [CalendarPage] object
  // CalendarPage getCalendarPage() {
  //   return _calendarPage;
  // }

  /// Returns this [Event] object's [ItineraryPage] object
  // ItineraryPage getItineraryPage() {
  //   return _itineraryPage;
  // }

  /// Returns this [Event] object's [CollaborationPage] object
  CollaborationPage getCollaborationPage() {
    return _collaborationPage;
  }

  /// Converts the current [Event] object into a json file formatted [Map]
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "eventName": _eventName,
      "date": _date.toString(),
      "startTime": "${_startTime.hour}:${_startTime.minute}",
      "endTime": "${_endTime.hour}:${_endTime.minute}",
      "financePage": _financePage.toJson(),
      //"calendarPage": _calendarPage.toJson();
      "calendarPage": {},
      //"itineraryPage": _itineraryPage.toJson();
      "itineraryPage": {},
      "collaborationPage": _collaborationPage.toJson()
    };
  }

  /// Updates the list of collaborators by replacing the place holder [Collaborator]
  /// object described by [oldUserID] with the actual [User] object described by [user]
  void updateCollaborator({required String oldUserID, required User user}) {
    _collaborationPage.updateCollaborator(oldUserID: oldUserID, user: user);
  }

  /// Adds the [User] object described by [user] as a [Collaborator] object
  /// in the event's list of collaborators
  void addCollaboratorFromUser({required User user}) {
    _collaborationPage.addCollaboratorFromUser(user: user);
  }
}
