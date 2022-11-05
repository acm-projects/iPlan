import 'package:flutter/material.dart';

/// @author [SharunNaicker]
/// The [Task] object represents an the different aspects of the several tasks the user needs to complete to do the event
/// These forms of information include [_taskName], [_dueDate], and [_dueTime].
class Task implements Comparable<Task> {
  //The name of the event
  late String _taskName;

  //The date of when you need to complete a task by
  late DateTime _dueDate;

  //The time of when you need to finish a particular task by
  late TimeOfDay _dueTime;

  //Checking to see if the object is completed
  late bool _isComplete;

  // Constructs an Task object with parameters [name], [date], and [time]
  Task(
      {required String name, required DateTime date, required TimeOfDay time}) {
    _taskName = name;
    _dueDate = date;
    _dueTime = time;
    _isComplete = false;
  }

  /// @author [MatthewSheldon]
  /// Constructs a [Task] object from the passed json file
  Task.fromJson({required Map<String, dynamic> json}) {
    _taskName = json["name"];
    _dueDate = DateTime.parse(json["dueDate"]);
    _dueTime = _getTimeFromString(json["dueTime"]);
    _isComplete = json["isComplete"];
  }

  //Returns the name of the task
  String getTaskName() {
    return _taskName;
  }

  //Returns the date of the task
  DateTime getDueDate() {
    return _dueDate;
  }

  //Returns the time the task needs to be finished by
  TimeOfDay getDueTime() {
    return _dueTime;
  }

  bool getIsComplete() {
    return _isComplete;
  }

  bool updateIsComplete({required bool value}) {
    return _isComplete = value;
  }

  /// @author [MatthewSheldon]
  /// Helper method for [Task.fromJson] constructor that takes a [TimeOfDay]
  /// formatted [String] and returns the converted [TimeOfDay] equivalent object.
  TimeOfDay _getTimeFromString(String time) {
    List<String> split = time.split(":");
    return TimeOfDay(hour: int.parse(split[0]), minute: int.parse(split[1]));
  }

  /// Converts the current [Task] object into a json file formatted [Map]
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "name": _taskName,
      "dueDate": _dueDate.toString(),
      "dueTime": "${_dueTime.hour}:${_dueTime.minute}",
      "isComplete": _isComplete
    };
  }

  @override
  int compareTo(Task other) {
    int compare1 = _dueDate.compareTo(other.getDueDate());
    int compare2 = _dueTime.hour.compareTo(other.getDueTime().hour);
    int compare3 = _dueTime.minute.compareTo(other.getDueTime().minute);
    return compare1 == 0
        ? (compare2 == 0
            ? (compare3 == 0
                ? _taskName.compareTo(other.getTaskName())
                : compare3)
            : compare2)
        : compare1;
  }
}
