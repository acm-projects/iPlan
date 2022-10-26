import '../Collaboration/collaboration_page.dart';

/// @author [MatthewSheldon]
/// Class used for housing all of the different pages, as well as constructing
/// from and deconstructing into a json file that is sent to the cloud.
class Event {
  /// The event id for this [Event] object
  late String _link;

  /// The [FinancePage] object for this [Event] object
  //late FinancePage _financePage;

  /// The [CalendarPage] object for this [Event] object
  //late CalendarPage _calendarPage;

  /// The [ItineraryPage] object for this [Event] object
  //late ItineraryPage _itineraryPage;

  /// The [CollaborationPage] object for this [Event] object
  late CollaborationPage _collaborationPage;

  /// Constructs an [Event] object from the passed json file and event id (link)
  Event.fromJson({required Map<String, dynamic> json, required String link}) {
    _link = link;
    // _financePage = FinancePage.fromJson(json: json["financePage"]);
    // _calendarPage = CalendarPage.fromJson(json: json["calendarPage"]);
    // _itineraryPage = ItineraryPage.fromJson(json: json["itineraryPage"]);
    _collaborationPage =
        CollaborationPage.fromJson(json: json["collaborationPage"], link: link);
  }

  /// Returns this [Event] object's [_link]
  String getLink() {
    return _link;
  }

  /// Returns this [Event] object's [FinancePage] object
  // FinancePage getFinancePage() {
  //   return _financePage;
  // }

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

  /// Convers the current [Event] object into a json file formatted map
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "financePage": "{}",
      "calendarPage": "{}",
      "itineraryPage": "{}",
      "collaborationPage": _collaborationPage.toJson()
    };
  }
}
