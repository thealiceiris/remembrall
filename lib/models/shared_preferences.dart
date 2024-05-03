import 'package:shared_preferences/shared_preferences.dart';

class TaskManager {
  static const _streakCountKey = 'streak_count';
  static const _lastTaskCompletionDateKey = 'last_task_completion_date';

  static Future<int> getStreakCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_streakCountKey) ?? 0;
  }

  static Future<DateTime?> getLastTaskCompletionDate() async {
    final prefs = await SharedPreferences.getInstance();
    final lastTaskCompletionDateMillis = prefs.getInt(_lastTaskCompletionDateKey);
    return lastTaskCompletionDateMillis != null
        ? DateTime.fromMillisecondsSinceEpoch(lastTaskCompletionDateMillis)
        : null;
  }

  static Future<void> updateStreakCount() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now();
    final lastTaskCompletionDate = await getLastTaskCompletionDate();

    final streak = lastTaskCompletionDate == null ||
            today.difference(lastTaskCompletionDate).inDays > 1
        ? 1
        : (await getStreakCount()) + 1;

    await prefs.setInt(_streakCountKey, streak);
    await prefs.setInt(_lastTaskCompletionDateKey, today.millisecondsSinceEpoch);
  }

  static Future<void> resetStreakCount() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_streakCountKey, 0);
    await prefs.setInt(_lastTaskCompletionDateKey, 0);
  }
}