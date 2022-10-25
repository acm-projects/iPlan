/// @author [SharunNaicker]
/// The [Task] object represents an the different aspects of the several tasks the user needs to complete to do the event
/// These forms of information include [_taskName], [_dueDate], and [_dueTime].

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

//can be replaced with backend task class, , day, time, isComplete


class Task {

  //The name of the event
  late String _taskName;

  //The date of when you need to complete a task by
  late DateTime _dueDate;

  //The time of when you need to finish a particular task by
  late DateTime _dueTime;

  //Checking to see if the object is completed
  late bool _isComplete;

  // Constructs an Task object with parameters [name], [date], and [time]
  Task({required String name, required DateTime startTime, required bool isComplete, required DateTime date}) {
    _taskName = name;
    _dueDate = startTime;
    _dueTime = startTime;
    _isComplete = false;
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
  DateTime getDueTime() {
    return _dueTime;
  }

  bool getIsComplete() {
    return _isComplete;
  }

  /// Deconstructs the current [Task] object
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "name": _taskName,
      "dueDate": _dueDate,
      "dueTime": _dueTime,
      "isComplete": _isComplete
    };
  }
}
