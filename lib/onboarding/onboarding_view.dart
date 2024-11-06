import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:remembrall/screens/splashscreen.dart';
import 'package:url_launcher/url_launcher.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFD6C2E9), // Pastel purple color
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/images/adhd.png', // Add your image here
                  height: 250, // Adjust the height of the image as needed
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const Text(
                    'Welcome to Remembrall!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat', // Use a custom font
                    ),
                  ).animate(effects: [
                    const FadeEffect(delay: Duration(milliseconds: 300)),
                  ]),
                  const SizedBox(height: 16),
                  const Text(
                    'Remembrall is an app that helps in ADHD management. '
                    'ADHD is a neurodevelopmental disorder that impacts daily functioning '
                    'and quality of life.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Roboto', // Use a custom font
                    ),
                  ).animate(effects: [
                    const FadeEffect(delay: Duration(milliseconds: 300)),
                  ]),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity, // Make the button width infinite
                    child: ElevatedButton(
                      onPressed: () {
                        launchUrl(Uri.parse(
                            'https://www.helpguide.org/articles/add-adhd/managing-adult-adhd-attention-deficit-disorder.htm'));
                      },
                      child: const Text(
                        'Learn more: Managing ADHD',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity, // Make the button width infinite
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to the main app screen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SplashScreen()),
                        );
                      },
                      child: const Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
