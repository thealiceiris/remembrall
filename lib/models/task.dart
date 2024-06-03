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
  bool isfinished;
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
      this.isfinished = false,
      this.done,
      this.desc});

  get tasks => null;

 
}
