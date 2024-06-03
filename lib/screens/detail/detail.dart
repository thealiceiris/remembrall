import 'package:flutter/material.dart';
import 'package:remembrall/models/task.dart';
import 'package:remembrall/screens/task_page.dart';
import 'package:remembrall/screens/rembot_screen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:remembrall/screens/detail/widgets/tasktitle.dart';

class DetailPage extends StatefulWidget {
  final Task task;

  const DetailPage({super.key, required this.task});

  @override
  DetailPageState createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    tasks = [widget.task];
  }

  void _addTask(Task task) {
    setState(() {
      tasks.add(task);
      tasks.sort((a, b) => (a.dateTime ?? DateTime.now())
          .compareTo(b.dateTime ?? DateTime.now()));
    });
  }

  void _updateTask(int index, Task updatedTask) {
    setState(() {
      tasks[index] = updatedTask;
      tasks.sort((a, b) => (a.dateTime ?? DateTime.now())
          .compareTo(b.dateTime ?? DateTime.now()));
    });
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void _toggleTaskCompletion(int index, bool? value) {
    setState(() {
      tasks[index].isfinished = value ?? false;
    });
  }

  int _getTasksLeft() {
    return tasks.where((task) => !task.isfinished).length;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, tasks);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildAppBar(context),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                padding: const EdgeInsets.only(top: 10),
                child: Stack(
                  children: [
                    _buildContent(),
                    _buildFloatingActionButton(context),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: _buildBottomNavigationBar(context),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: DateTime.now(),
          calendarFormat: CalendarFormat.week,
          selectedDayPredicate: (day) => isSameDay(day, DateTime.now()),
          onDaySelected: (selectedDay, focusedDay) {
            // Handle onDaySelected callback here
          },
        ),
        const TaskTitle(),
        const SizedBox(height: 20),
        if (tasks.isEmpty)
          const Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'No tasks yet',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Tap "+" to start schedule planning with Me',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          )
        else
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  child: ListTile(
                    leading: Checkbox(
                      value: task.isfinished,
                      onChanged: (value) => _toggleTaskCompletion(index, value),
                    ),
                    title: Text(
                      task.title ?? '',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        decoration:
                            task.isfinished ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    subtitle: Text(
                      task.dateTime?.toString() ?? '',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () async {
                            final updatedTask = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddTaskPage(
                                  onAddTask: (task) {
                                    _updateTask(index, task);
                                  },
                                ),
                              ),
                            );

                            if (updatedTask != null) {
                              _updateTask(index, updatedTask);
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteTask(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return Positioned(
      bottom: 80,
      right: 20,
      child: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskPage(
                onAddTask: (task) => _addTask(task),
              ),
            ),
          );
        },
        backgroundColor: const Color(0xFFE6B9F0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
        child: const Icon(
          Icons.add,
          size: 35,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: IconButton(
          onPressed: () {
            Navigator.pop(context, tasks);
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          iconSize: 30,
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(top: 16.0, right: 15.0),
          child: Icon(
            Icons.more,
            size: 40,
            color: Colors.white,
          ),
        ),
      ],
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${widget.task.title} tasks',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            'You have ${_getTasksLeft()} tasks left today!',
            style: const TextStyle(fontSize: 18, color: Colors.grey),
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) => BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'RemBot',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RemBotScreen()),
            );
          }
        },
      );
}
