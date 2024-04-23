import 'package:flutter/material.dart';
import 'package:remembrall/widget/remembrall.dart';
import 'package:remembrall/widget/tasks.dart';
// import 'package:flutter/widgets.dart';
// import 'package:remembrall/widget/custom_scaffold.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

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
                  fontWeight: FontWeight.bold),
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
}
