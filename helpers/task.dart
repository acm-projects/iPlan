class Task {
  String title;
  bool isComplete = false;
  DateTime day;
  String time;

  Task({required this.title, required this.day, required this.time});

  String toString() => this.title;
}