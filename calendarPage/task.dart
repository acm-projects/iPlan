class Task {
  String title;
  bool isComplete = false;
  DateTime day;

  Task({required this.title, required this.day});

  String toString() => this.title;
}