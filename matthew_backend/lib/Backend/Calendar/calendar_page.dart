import 'package:flutter/material.dart';

import 'task.dart';

/// @author [SharunNaicker]
/// The [CalendarPage] class implements the use of classes like [Calendar_Widget]
/// and [Task] to allow the user to create tasks which have a designated
/// date they need to be completed by as well as a name for each task
class CalendarPage {
  /// The list of [Task] objects for the current event
  late List<Task> _tasks;

  /// Creates a [CalendarPage] object with the passed [title] and [date]
  /// parameters
  CalendarPage() {
    _tasks = <Task>[];
  }

  /// @author [MatthewSheldon]
  /// Constructs a [CalendarPage] object from the passed json file
  CalendarPage.fromJson({required Map<String, dynamic> json}) {
    List<dynamic> taskData = json["tasks"] as List<dynamic>;
    _tasks = taskData.map((task) => Task.fromJson(json: task)).toList();
  }

  List<Task> getTasks() {
    return _tasks;
  }

  void addTask(
      {required String title,
      required DateTime date,
      required TimeOfDay time}) {
    _tasks.add(Task(name: title, date: date, time: time));
  }

  void updateTask(Task element, bool value) {
    for (int i = 0; i < _tasks.length; i++) {
      if ((element.getTaskName() == _tasks[i].getTaskName()) &&
          (element.getDueDate() == _tasks[i].getDueDate()) &&
          (element.getDueTime() == _tasks[i].getDueTime())) {
        _tasks[i].updateIsComplete(value: value);
      }
    }
  }

  /// @author [MatthewSheldon]
  /// Converts the current [Event] object into a json file formatted [Map]
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "tasks": _tasks.map((task) => task.toJson()).toList()
    };
  }
}
