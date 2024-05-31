import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

class Task {
  IconData? iconData;
  String? title;
  DateTime? dateTime;
  Color? bgcolor,
      iconColor,
      btnColor,
      textColor,
      btntxtColor; // Added textColor property
  bool isLast;
  bool isCompleted;
  bool reminder;
  num? progress, left, done;
  List<Map<String, dynamic>>? desc;

  Task(
      {this.iconData,
      this.title,
      this.dateTime,
      this.bgcolor,
      this.iconColor,
      this.btnColor,
      this.btntxtColor,
      this.textColor, // Added textColor parameter
      this.isLast = false,
      this.reminder = false,
      this.progress,
      this.left,
      this.isCompleted = false,
      this.done,
      this.desc});

  get tasks => null;

  static List<Task> getTasks() {
    return [
      Task(
        iconData: Icons.person_rounded,
        title: 'Personal',
        bgcolor: const Color.fromARGB(213, 255, 245, 157),
        iconColor: const Color.fromARGB(255, 242, 227, 95),
        btnColor: const Color.fromARGB(255, 242, 227, 95),
        textColor: Colors.black, // Set a contrasting color for button text
        btntxtColor: Colors.black,
        isLast: false,
        progress: 0.5,
        left: 0,
        done: 0,
      ),
      Task(
        iconData: Icons.book_rounded,
        title: 'School',
        bgcolor: const Color.fromARGB(255, 236, 165, 165),
        iconColor: const Color.fromARGB(255, 243, 118, 118),
        btnColor: const Color.fromARGB(255, 243, 118, 118),
        textColor: Colors.black, // Set a contrasting color for button text
        btntxtColor: Colors.black,
        isLast: false,
        progress: 0.5,
        left: 0,
        done: 0,
      ),
      Task(
        iconData: Icons.cases_rounded,
        title: 'Work',
        bgcolor: const Color.fromARGB(210, 136, 139, 232),
        iconColor: const Color.fromARGB(210, 112, 116, 235),
        btnColor: const Color.fromARGB(210, 141, 144, 229),
        textColor: Colors.black, // Set a contrasting color for button text
        btntxtColor: Colors.black,
        isLast: false,
        progress: 0.5,
        left: 0,
        done: 0,
      ),
      Task(
        iconData: Icons.book_rounded,
        title: 'School',
        bgcolor: const Color.fromARGB(255, 165, 236, 204),
        iconColor: const Color.fromARGB(255, 101, 244, 179),
        btnColor: const Color.fromARGB(255, 125, 205, 169),
        textColor: Colors.black, // Set a contrasting color for button text
        btntxtColor: Colors.black,
        isLast: false,
        progress: 0.5,
        left: 0,
        done: 0,
      ),
      Task(
        iconData: Icons.local_hospital_rounded,
        title: 'Health',
        bgcolor: const Color.fromARGB(210, 144, 202, 249),
        iconColor: const Color.fromARGB(210, 100, 179, 245),
        btnColor: const Color.fromARGB(242, 100, 180, 245),
        textColor: Colors.black, // Set a contrasting color for button text
        btntxtColor: Colors.black,
        isLast: false,
        progress: 0.5,
        left: 0,
        done: 0,
      ),
      Task(isLast: true)
    ];
  }
}
