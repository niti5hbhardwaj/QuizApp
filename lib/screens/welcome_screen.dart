import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/screens/loading_screen.dart';
import 'package:quiz_app/screens/quiz_screen.dart';
import 'package:animations/animations.dart';
// import 'chat_api/chat_api.dart';

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
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 50,
            ),
            OpenContainer(
              transitionDuration: const Duration(milliseconds: 500),
              openBuilder: (context, closedContainer) => const LoadingScreen(),
              openShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              closedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              closedColor: foregroundColor,
              closedBuilder: (context, openContainer) => MaterialButton(
                onPressed: () async {
                  openContainer();
                  await getQuestions();
                  if (context.mounted) {
                    Navigator.pushReplacementNamed(context, QuizScreen.id);
                  }
                },
                color: foregroundColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                height: 50,
                minWidth: 150,
                elevation: 5,
                child: Text(
                  "Start Quiz",
                  style: TextStyle(
                    fontSize: 20,
                    color: backgroundColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> getQuestions() async {
  await Future.delayed(const Duration(seconds: 3), () {
    print("Hello");
  });
}
