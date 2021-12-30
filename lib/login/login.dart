import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app1/services/auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              FontAwesomeIcons.fire,
              size: 200,
              color: Color(0xFFF57C00), //Firebase orange
            ),
            Center(
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'firequiz',
                    textStyle: const TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF57C00), //Firebase orange
                    ),
                    speed: const Duration(milliseconds: 200),
                  ),
                ],
                totalRepeatCount: 10,
                pause: const Duration(milliseconds: 1000),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              ),
            ),
            Flexible(
              child: LoginButton(
                color: Color(0xFFFFA000), // Firebase amber
                icon: FontAwesomeIcons.google,
                text: 'log in with Google',
                loginMethod: AuthService().googleLogin,
              ),
            ),
            LoginButton(
                color: Color(0xFFFFA000), // Firebase amber
                icon: FontAwesomeIcons.questionCircle,
                text: 'just checking out',
                loginMethod: AuthService().anonymousLogin,
              ),
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final Function loginMethod;

  const LoginButton(
      {Key? key,
      required this.color,
      required this.icon,
      required this.text,
      required this.loginMethod})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: ElevatedButton.icon(
          onPressed: () => loginMethod(),
          icon: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(20),
            backgroundColor: color,
          ),
          label: Text(
            text,
            textAlign: TextAlign.center,
          )),
    );
  }
}
