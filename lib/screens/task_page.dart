import 'package:flutter/material.dart';
import 'package:remembrall/models/task.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class AddTaskPage extends StatefulWidget {
  final Function(Task task) onAddTask;

  const AddTaskPage({super.key, required this.onAddTask});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  String newTaskTitle = '';
  DateTime? newTaskDateTime;
  bool addReminder = false;

  void _handleAddTask() {
    if (newTaskTitle.isNotEmpty && newTaskDateTime != null) {
      final newTask = Task(
        title: newTaskTitle,
        dateTime: newTaskDateTime,
        reminder: addReminder,
        left: 1,
        done: 0,
        progress: 0,
      );

      widget.onAddTask(newTask);

      if (addReminder) {
        _scheduleNotification(newTask);
      }

      Navigator.pop(context, newTask);
    }
  }

  void _scheduleNotification(Task task) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: task.dateTime!.millisecondsSinceEpoch.remainder(100000),
        channelKey: 'basic_channel',
        title: 'Reminder for ${task.title}',
        body: 'Your task "${task.title}" is scheduled for now.',
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: NotificationCalendar.fromDate(
        date: task.dateTime!,
        preciseAlarm: true,
        allowWhileIdle: true,
      ),
    );
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
              onChanged: (value) => setState(() => newTaskTitle = value),
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
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      setState(() {
                        newTaskDateTime = DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          pickedTime.hour,
                          pickedTime.minute,
                        );
                      });
                    }
                  },
                  child: Text(
                    newTaskDateTime != null
                        ? "${newTaskDateTime!.hour}:${newTaskDateTime!.minute}"
                        : 'Select Time',
                    style: TextStyle(
                      color:
                          newTaskDateTime != null ? Colors.black : Colors.grey,
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
    