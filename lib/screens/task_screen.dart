import 'package:flutter/material.dart';
import 'package:remembrall/widget/remembrall.dart';
import 'package:remembrall/widget/tasks.dart';
import 'package:remembrall/screens/rembot_screen.dart';

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
          Container(
            padding: const EdgeInsets.all(15),
            child: const Text(
              'Tasks',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Tasks(),
          )
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  AppBar _buildAppBar() => AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Row(
          children: [
            SizedBox(
              width: 40,
            ),
            Text(
              'Hi there!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: const [
          Icon(
            Icons.more_vert,
            color: Colors.black,
            size: 40,
          )
        ],
      );

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          height: 100,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(62, 158, 158, 158),
                spreadRadius: 5,
                blurRadius: 10,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  label: 'Home',
                  icon: Icon(
                    Icons.home_rounded,
                    size: 25,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'RemBot',
                  icon: Icon(
                    Icons.chat_rounded,
                    size: 25,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Profile',
                  icon: Icon(
                    Icons.person_rounded,
                    size: 25,
                  ),
                ),
              ],
              onTap: (index) {
                if (index == 1) { // Check if RemBot item is tapped (index 1)
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RemBotScreen()),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
