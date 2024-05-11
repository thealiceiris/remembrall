import 'package:flutter/material.dart';

class AddTaskPage extends StatefulWidget {
  final Function(String title, DateTime dateTime) onAddTask; // Callback to pass new task data

  const AddTaskPage({super.key, required this.onAddTask});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  String newTaskTitle = '';
  DateTime? newTaskDateTime;

  void _handleAddTask() {
    // Validate user input (optional)
    if (newTaskTitle.isNotEmpty && newTaskDateTime != null) {
      widget.onAddTask(newTaskTitle, newTaskDateTime!); // Call callback with task data
      Navigator.pop(context); // Close the AddTaskPage
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add some padding
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
                    // Show DateTimePicker to select time
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    ); // Use showTimePicker for time selection
                    if (pickedTime != null) {
                      setState(() => newTaskDateTime = DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          pickedTime.hour,
                          pickedTime.minute));
                    }
                  },
                  child: Text(
                    newTaskDateTime?.toString() ?? 'Select Time',
                    style: TextStyle(
                      color: newTaskDateTime != null ? Colors.black : Colors.grey,
                    ),
                  ),
                ),
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
