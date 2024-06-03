import 'package:flutter/material.dart';

class TaskTitle extends StatelessWidget {
  const TaskTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Text(
          'Your Tasks for the day',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        // ignore: avoid_unnecessary_containers
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: const Color.fromARGB(140, 158, 158, 158),
              borderRadius: BorderRadius.circular(20)),
          child: const Row(children: [
            Text(
              'Timeline',
              style: TextStyle(
                  color: Color.fromARGB(203, 0, 0, 0),
                  fontWeight: FontWeight.bold),
            ),
            Icon(Icons.keyboard_arrow_down_outlined)
          ]),
        ),
      ]),
    );
  }
}
