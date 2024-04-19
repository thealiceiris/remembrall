import 'package:flutter/material.dart';
import 'package:remembrall/screens/signin_screen.dart';
import 'package:remembrall/screens/signup_screen.dart';
// import 'package:remembrall/themes/theme.dart';
import 'package:remembrall/widget/custom_scaffold.dart';
import 'package:remembrall/widget/welcome_button.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          Flexible(
            flex: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 0,
              ),
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Welcome Back!\n',
                        style: TextStyle(
                            fontSize: 45.0,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 249, 247, 247),
                            fontFamily: 'Poppins',
                            shadows: [
                              Shadow(
                                color: Color.fromARGB(167, 161, 159, 159),
                                offset: Offset(0, 1.5),
                              )
                            ]),
                      ),
                      TextSpan(
                        text: 'Get started with Remembrall',
                        style: TextStyle(fontSize: 20.0,
                        fontFamily: 'Poppins',
                         shadows: [
                              Shadow(
                                color: Color.fromARGB(167, 161, 159, 159),
                                offset: Offset(0, 1.5),
                              )
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Flexible(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  children: [
                    Expanded(
                      child: WelcomeButton(
                        buttonText: 'Sign In',
                        onTap: SigninScreen(),
                        color: Colors.transparent,
                        textColor: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: WelcomeButton(
                        buttonText: 'Sign Up',
                        onTap: SignUpScreen(),
                        color: Color.fromARGB(255, 233, 206, 242),
                        textColor: Color.fromARGB(255, 141, 121, 179),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
