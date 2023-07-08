import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/screens/chat_screen/chat_screen.dart';
import 'package:quiz_app/screens/error_screen.dart';
import 'package:quiz_app/screens/loading_screen.dart';
import 'package:quiz_app/screens/welcome/login/login_screen.dart';
import 'package:quiz_app/screens/quiz_screen.dart';
import 'package:quiz_app/screens/score/score_screen.dart';
import 'package:quiz_app/screens/welcome/signup/signup_screen.dart';
import 'package:quiz_app/screens/summary.dart';
import 'package:quiz_app/screens/topic/topic_screen.dart';
import 'package:quiz_app/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: []);
    return MaterialApp(
      theme: ThemeData.light(),
      title: "QuizApp",
      debugShowCheckedModeBanner: false,
      initialRoute: (FirebaseAuth.instance.currentUser != null)
          ? TopicScreen.id
          : LoginScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        TopicScreen.id: (context) => const TopicScreen(),
        LoadingScreen.id: (context) => const LoadingScreen(),
        BrokenLinkScreen.id: (context) => const BrokenLinkScreen(),
        QuizScreen.id: (context) => const QuizScreen(),
        ScoreScreen.id: (context) => const ScoreScreen(),
        SummaryScreen.id: (context) => const SummaryScreen(),
        ChatScreen.id: (context) => const ChatScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        SignUpScreen.id: (context) => const SignUpScreen(),
      },
    );
  }
}
