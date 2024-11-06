import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class StreakWidget extends StatefulWidget {
  final int initialStreak;

  const StreakWidget({super.key, this.initialStreak = 0});

  @override
  StreakWidgetState createState() => StreakWidgetState();
}

class StreakWidgetState extends State<StreakWidget> {
  late int currentStreak;

  @override
  void initState() {
    super.initState();
    loadStreak();
    scheduleDailyStreakCheck();
  }

  Future<void> loadStreak() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      currentStreak = prefs.getInt('currentStreak') ?? widget.initialStreak;
    });
  }

  Future<void> saveStreak() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentStreak', currentStreak);
  }

  void incrementStreak() {
    setState(() {
      currentStreak++;
    });
    saveStreak();
  }

  void resetStreak() {
    setState(() {
      currentStreak = 0;
    });
    saveStreak();
  }

  void scheduleDailyStreakCheck() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'streak_channel',
        title: 'Daily Streak Check',
        body: 'Time to update your streak!',
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: NotificationCalendar(
        hour: 9,
        minute: 0,
        second: 0,
        millisecond: 0,
        repeats: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.local_fire_department, color: Color.fromARGB(255, 245, 25, 9)),
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
