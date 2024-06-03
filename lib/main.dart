// ignore_for_file: unused_import

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:remembrall/firebase_options.dart';
import 'package:remembrall/onboarding/onboarding_view.dart';
import 'package:remembrall/screens/profile_screen.dart';
import 'package:remembrall/screens/splashscreen.dart';
// import 'package:remembrall/screens/profilescreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Awesome Notifications
  AwesomeNotifications().initialize(
    'resource://drawable/nf_ic',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
        playSound: true,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        enableLights: true,
        enableVibration: true,
        vibrationPattern: lowVibrationPattern,
      
      )
    ],
    debug: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Remembrall',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const OnboardingView(),
      routes: {
        '/profile': (context) =>
            const ProfileScreen(), // Define the route to the ProfileScreen
      },
    );
  }
}
