import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key, this.child});

  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      // AppBar
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/td4.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ), // Image.asset
          SafeArea(
            child: child!,
          ), // SafeArea
        ], // Stack
      ), // Scaffold
    );
  }
}
