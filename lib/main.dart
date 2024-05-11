import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:remembrall/firebase_options.dart';
import 'package:remembrall/screens/splashscreen.dart';

// import 'package:remembrall/widget/welcome_button.dart';

Future<void> main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
 );
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
      home: const SplashScreen(),
    );
  }
}
