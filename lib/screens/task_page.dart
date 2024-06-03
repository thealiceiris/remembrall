import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import '../models/task.dart'; // Adjust the import path according to your project structure

class AddTaskPage extends StatefulWidget {
  final Function(Task task) onAddTask;
  final Task? originalTask; // Add this field to store the original task data

  const AddTaskPage({super.key, required this.onAddTask, this.originalTask});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  late TextEditingController _titleController;
  TimeOfDay? newTaskTime;
  bool addReminder = false;

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the original task title if available
    _titleController = TextEditingController(
      text: widget.originalTask?.title ?? '',
    );
    // Set initial values based on the original task data if available
    if (widget.originalTask != null) {
      newTaskTime = widget.originalTask!.dateTime != null
          ? TimeOfDay.fromDateTime(widget.originalTask!.dateTime!)
          : null;
      addReminder = widget.originalTask?.reminder ?? false;
    }
    requestNotificationPermission();
  }

  void requestNotificationPermission() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

  void _handleAddTask() {
    if (_titleController.text.isNotEmpty && newTaskTime != null) {
      final now = DateTime.now();
      final newTaskDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        newTaskTime!.hour,
        newTaskTime!.minute,
      );

      final newTask = Task(
        title: _titleController.text,
        dateTime: newTaskDateTime,
        reminder: addReminder,
        left: 1,
        done: 0,
        progress: 0,
        bgcolor: Colors.blue, // Set default values
        iconColor: Colors.white,
        btnColor: Colors.blueAccent,
        textColor: Colors.black,
        btntxtColor: Colors.white,
      );

      widget.onAddTask(newTask);

      if (addReminder) {
        _scheduleNotification(newTask);
      }

      Navigator.pop(context, newTask);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please provide task title and time')),
      );
    }
  }

  void _scheduleNotification(Task task) {
    if (task.dateTime != null) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: task.dateTime!.millisecondsSinceEpoch.remainder(100000),
          channelKey: 'basic_channel',
          title: 'Reminder for ${task.title}',
          body: 'Your task "${task.title}" is scheduled for now.',
          icon: 'resource://drawable/nf_ic', 
          notificationLayout: NotificationLayout.Default,
        ),
        schedule: NotificationCalendar.fromDate(
          date: task.dateTime!,
          preciseAlarm: true,
          allowWhileIdle: true,
        ),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Task Title'),
              controller: _titleController,
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                const Text('Task Time:'),
                const SizedBox(width: 10.0),
                TextButton(
                  onPressed: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: newTaskTime ?? TimeOfDay.now(),
                    );

                    if (pickedTime != null) {
                      setState(() {
                        newTaskTime = pickedTime;
                      });
                    }
                  },
                  child: Text(
                    newTaskTime != null
                        ? "${newTaskTime!.format(context)}"
                        : 'Select Time',
                    style: TextStyle(
                      color: newTaskTime != null ? Colors.black : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Checkbox(
                  value: addReminder,
                  onChanged: (bool? value) {
                    setState(() {
                      addReminder = value ?? false;
                    });
                  },
                ),
                const Text('Add Reminder'),
              ],
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: _handleAddTask,
              child: const Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}
