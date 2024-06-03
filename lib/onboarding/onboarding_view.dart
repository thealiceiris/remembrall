import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:remembrall/screens/signin_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.purpleAccent.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: PageView(
          controller: pageController,
          children: const [
            PageOne(),
            PageTwo(),
            PageThree(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (pageController.page == 2) {
            // Navigate to the main app screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SigninScreen()),
            );
          } else if (pageController.page == 1) {
            pageController.animateToPage(
              2,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          } else if (pageController.page == 0) {
            pageController.animateToPage(
              1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Welcome to the Jeremy Buddies eHMS!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                  ),
            ).animate(effects: [
              const FadeEffect(delay: Duration(milliseconds: 300)),
            ]),
            const SizedBox(height: 16),
            const Text(
              '👋',
              style: TextStyle(fontSize: 48),
            ),
          ],
        ),
      ),
    );
  }
}

class PageTwo extends StatelessWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Health and Monitoring',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                  ),
            ).animate(effects: [
              const FadeEffect(delay: Duration(milliseconds: 300)),
            ]),
            const SizedBox(height: 16),
            const Text(
              '💙',
              style: TextStyle(fontSize: 48),
            ),
          ],
        ),
      ),
    );
  }
}

class PageThree extends StatelessWidget {
  const PageThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                    ),
                children: [
                  const TextSpan(text: 'Visit our website for more'),
                  TextSpan(
                    text: 'Jeremy Buddies Dot Co Dot UK',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.lightBlueAccent,
                        ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launchUrl(
                          Uri.parse('https://jeremyscarebuddies.co.uk'),
                        );
                      },
                  ),
                ],
              ),
            ).animate(effects: [
              const FadeEffect(delay: Duration(milliseconds: 300)),
            ]),
            const SizedBox(height: 16),
            const Text(
              '🍹',
              style: TextStyle(fontSize: 48),
            ),
          ],
        ),
      ),
    );
  }
}
