import 'task.dart';
import 'calendar.dart';
import 'main.dart';

import '../page_type.dart';

/// @author [SharunNaicker]
/// The [CalendarPage] class implements the use of classes like [Calendar]
/// and [Task] to allow the user to create tasks which have a designated
/// date they need to be completed by as well as a name for each task
/// TODO: implement the link creation, compression, and expansion once other
/// classes have been created.


class CalendarPage {
  /// The list of [Task] objects for the current event
  late List<Task> _tasks;

  /// The title of the event
  late String _title;

  /// The date of the event
  late DateTime _date;

  /// The check to see if a task has been finished or not
  late bool _isComplete;

  /// Creates a [CalendarPage] object with the passed [title] and [date]
  /// parameters
  CalendarPage({required String title, required DateTime date, required DateTime time,required bool isComplete }) {
    _title = title;
    _date = date;
    // _time = time;
    _tasks = <Task>[];
    _isComplete = isComplete;
  }

  /// Returns a [PageType] object representing the page that the user should
  /// be returned to given that they are currently on the Collaboration Page
  PageType backButton() {
    return PageType.homeScreen;
  }

  /// Returns the [_title] of the event
  String getTitle() {
    return _title;
  }

  // DateTime getTime() {
  //   return _time;
  // }

  /// Returns the [_date] of the event
  DateTime getDate() {
    return _date;
  }
  bool getIsComplete() {
    return _isComplete;
  }

  void addTask(
      {required String title,
       required DateTime date,
        required DateTime time,
       required bool isComplete}) {
    _tasks.add(Task(
      name: title,
      date: date,
      startTime: date,
      isComplete: isComplete));
  }
}
