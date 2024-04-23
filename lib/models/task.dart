import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Task {
  IconData? iconData;
  String? title;
  Color? bgcolor,
      iconColor,
      btnColor,
      textColor,
      btntxtColor; // Added textColor property
  bool isLast;
  num? progress, left, done;

  Task({
    this.iconData,
    this.title,
    this.bgcolor,
    this.iconColor,
    this.btnColor,
    this.btntxtColor,
    this.textColor, // Added textColor parameter
    this.isLast = false,
    this.progress,
    this.left,
    this.done,
  });

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
