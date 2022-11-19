import 'package:flutter/material.dart';

/// @author [SharunNaicker]
/// The [ItineraryItem] object represents an individual event contained
/// within a [ItineraryPage] object
/// Each [ItineraryItem] will have a start-time, circle-icon, and a name description
class ItineraryItem {
  /// @author [SharunNaicker]
  /// The name of the itinerary item
  late String _itineraryItemDescription;

  /// @author [SharunNaicker]
  /// The time for the itinerary item
  late TimeOfDay _itineraryItemTime;

  /// @author [SharunNaicker]
  ///The required parameters needed to create an itinerary task
  ItineraryItem({required TimeOfDay time, required String description}) {
    _itineraryItemTime = time;
    _itineraryItemDescription = description;
  }

  /// @author [MatthewSheldon]
  /// Constructs a [ItineraryItem] object from the passed [json] file
  ItineraryItem.fromJson({required Map<String, dynamic> json}) {
    _itineraryItemDescription = json["name"];
    _itineraryItemTime = _getTimeFromString(json["time"]);
  }

  /// @author [SharunNaicker]
  ///getters for the name and the time
  String getItemName() {
    return _itineraryItemDescription;
  }

  /// @author [SharunNaicker]
  TimeOfDay getItemTime() {
    return _itineraryItemTime;
  }

  /// @author [MatthewSheldon]
  /// Helper method for [ItineraryItem.fromJson] constructor that takes a [TimeOfDay]
  /// formatted [String] and returns the converted [TimeOfDay] equivalent object.
  TimeOfDay _getTimeFromString(String time) {
    List<String> split = time.split(":");
    return TimeOfDay(hour: int.parse(split[0]), minute: int.parse(split[1]));
  }

  /// @author [SharunNaicker]
  /// Converts the current [ItineraryItem] object into a json file formatted [Map]
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "name": _itineraryItemDescription,
      "time": "${_itineraryItemTime.hour}:${_itineraryItemTime.minute}"
    };
  }
}
