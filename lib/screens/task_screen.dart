// File: task_screen.dart
// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:remembrall/screens/profile_screen.dart';
import 'package:remembrall/widget/remembrall.dart';
import 'package:remembrall/widget/tasks.dart';
import 'package:remembrall/screens/rembot_screen.dart';
import 'package:remembrall/screens/streak.dart'; // Make sure this path matches where you save the streak_widget.dart

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Remembrall(),
          const Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(right: 20, top: 20),
              child: StreakWidget(
                  initialStreak:
                      0), // Pass the initial streak dynamically if needed
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            child: const Text(
              'Tasks Categories',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Tasks(), // Assuming this widget handles the task list
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  AppBar _buildAppBar() => AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Hi there!',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Icon(Icons.more_vert, color: Colors.black, size: 24),
        ],
      );

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
          if (index == 0) {
            //handle the home tap
          } else if (index == 1) {
            //handle the RemBot tap
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RemBotScreen()),
            );
          } else if (index == 2) {
            //handle the profile tap
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          }
        },
      );
}
