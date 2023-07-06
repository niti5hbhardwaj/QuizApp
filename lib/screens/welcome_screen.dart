import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/screens/topic/topic_screen.dart';

Color backgroundColor = Colors.white;
Color foregroundColor = Colors.grey.shade900;

class WelcomeScreen extends StatefulWidget {
  static const id = 'welcome_screen';
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              "assets/animations/splash_screen_animation.json",
              height: 300,
              fit: BoxFit.contain,
            ),
            const SizedBox(
              height: 50,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, TopicScreen.id);
              },
              color: foregroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              height: 50,
              minWidth: 160,
              elevation: 5,
              child: Text(
                "Take a Quiz",
                style: TextStyle(
                  fontSize: 20,
                  color: backgroundColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
