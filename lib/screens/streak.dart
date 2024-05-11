import 'package:flutter/material.dart';

class StreakWidget extends StatefulWidget {
  final int initialStreak;

  // ignore: use_super_parameters
  const StreakWidget({Key? key, this.initialStreak = 0}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _StreakWidgetState createState() => _StreakWidgetState();
}

class _StreakWidgetState extends State<StreakWidget> {
  late int currentStreak;

  @override
  void initState() {
    super.initState();
    currentStreak = widget.initialStreak;  // Initialize streak from the passed initial value
  }

  void incrementStreak() {
    setState(() {
      currentStreak++;  // Increment streak count
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blue,  // Change as needed
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),  // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.local_fire_department, color: Colors.red),
          const SizedBox(width: 10),
          Text(
            'Streak: $currentStreak days',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}