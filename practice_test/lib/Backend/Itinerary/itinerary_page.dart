import 'package:flutter/material.dart';
import 'package:practice_test/main.dart';
import 'itinerary_item.dart';

/// @author [SharunNaicker]
/// The [ItineraryPage] class implements the use of classes like [ItineraryItem]
/// to display to the user which tasks they have on their itinerary before the event has
/// started and during the event
class ItineraryPage {
  /// @author [SharunNaicker]
  /// The times and the task before the event begins
  /// The individual lists for before/during for both the tasks(description in the front-end) and time
  late List<ItineraryItem> _tasksBefore;

  /// @author [SharunNaicker]
  /// The times and the task during the event
  late List<ItineraryItem> _tasksDuring;

  /// @author [SharunNaicker]
  /// Hard coded the value for the time to make it to compare
  late TimeOfDay _eventStartTime;

  /// @author [SharunNaicker]
  /// The constructor for the ItineraryPage
  ItineraryPage({required TimeOfDay eventStartTime}) {
    _eventStartTime = eventStartTime;
    _tasksBefore = <ItineraryItem>[];
    _tasksDuring = <ItineraryItem>[];
  }

  /// @author [MatthewSheldon]
  /// Constructs a [ItineraryPage] object from the passed [json] file
  ItineraryPage.fromJson(
      {required TimeOfDay eventStartTime, required Map<String, dynamic> json}) {
    _eventStartTime = eventStartTime;
    List<dynamic> data = json["tasksBefore"];
    _tasksBefore =
        data.map((json) => ItineraryItem.fromJson(json: json)).toList();
    data = json["tasksDuring"];
    _tasksDuring =
        data.map((json) => ItineraryItem.fromJson(json: json)).toList();
  }

  /// @author [SharunNaicker]
  /// Getter for the event start time
  TimeOfDay getEventStartTime() {
    return _eventStartTime;
  }

  /// @author [SharunNaicker]
  List<ItineraryItem> getTasksBefore() {
    return _tasksBefore;
  }

  /// @author [SharunNaicker]
  List<ItineraryItem> getTasksDuring() {
    return _tasksDuring;
  }

  /// @author [SharunNaicker]
  /// Method that compares which list to add the time/task and how to add it
  void addItineraryItem(
      {required TimeOfDay time, required String description}) {
    bool added = false;
    int beforeLength = _tasksBefore.length;
    int duringLength = _tasksDuring.length;
    if (time.hour < _eventStartTime.hour ||
        (time.hour == _eventStartTime.hour &&
            time.minute < _eventStartTime.minute)) {
      int count = 0;
      while (added == false && count < beforeLength) {
        if (time.hour < _tasksBefore[count].getItemTime().hour ||
            (time.hour == _tasksBefore[count].getItemTime().hour &&
                time.minute < _tasksBefore[count].getItemTime().minute)) {
          _tasksBefore.insert(
              count, ItineraryItem(time: time, description: description));
          added = true;
        }
        count++;
      }
      if (!added) {
        _tasksBefore.add(ItineraryItem(time: time, description: description));
      }
    } else {
      int count = 0;
      while (added == false && count < duringLength) {
        if (time.hour < _tasksDuring[count].getItemTime().hour ||
            (time.hour == _tasksDuring[count].getItemTime().hour &&
                time.minute < _tasksDuring[count].getItemTime().minute)) {
          _tasksDuring.insert(
              count, ItineraryItem(time: time, description: description));
          added = true;
        }
        count++;
      }
      if (!added) {
        _tasksDuring.add(ItineraryItem(time: time, description: description));
      }
    }
  }

  /// @author [MatthewSheldon]
  /// Removes the passed task from the list of tasks.
  /// Used Strictly for the purposes of testing
  bool removeTask({required bool isBefore, required String taksName}) {
    for (int i = 0;
        i < (isBefore ? _tasksBefore.length : _tasksDuring.length);
        i++) {
      if ((isBefore ? _tasksBefore : _tasksDuring)[i].getItemName() ==
          taksName) {
        (isBefore ? _tasksBefore : _tasksDuring).removeAt(i);
        return true;
      }
    }
    return false;
  }

  /// @author [MatthewSheldon]
  /// Converts the current [ItineraryPage] object into a json file formatted [Map]
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "tasksBefore": _tasksBefore.map((task) => task.toJson()).toList(),
      "tasksDuring": _tasksDuring.map((task) => task.toJson()).toList()
    };
  }
}
