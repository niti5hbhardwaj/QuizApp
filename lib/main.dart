import 'package:flutter/material.dart';
import 'package:quiz_app/screens/loading_screen.dart';
import 'package:quiz_app/screens/quiz_screen.dart';
import 'package:quiz_app/screens/score/score_screen.dart';
import 'package:quiz_app/screens/topic_screen.dart';
import 'package:quiz_app/screens/welcome_screen.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      title: "QuizApp",
      debugShowCheckedModeBanner: false,
      initialRoute: TopicScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        TopicScreen.id: (context) => const TopicScreen(),
        QuizScreen.id: (context) => const QuizScreen(),
        ScoreScreen.id: (context) => const ScoreScreen(),
        LoadingScreen.id: (context) => const LoadingScreen(),
      },
    );
  }
}
