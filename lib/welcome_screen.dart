import 'package:flutter/material.dart';
import 'package:quiz_app/chat_api/chat_api.dart';
import 'package:quiz_app/screens/quiz_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static const id = 'welcome_screen';
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () async {
            showDialog(
              context: context,
              builder: (context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
            await getQuestions();
            if (context.mounted) {
              Navigator.pushReplacementNamed(context, QuizScreen.id);
            }
          },
          child: const Text("Start Quiz"),
        ),
      ),
    );
  }
}
