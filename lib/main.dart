import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/screens/About/about_the_app.dart';
import 'package:quiz_app/screens/chat_screen/chat_screen.dart';
import 'package:quiz_app/screens/error/lost_in_space.dart';
import 'package:quiz_app/screens/error/network_error_screen.dart';
import 'package:quiz_app/screens/loading/loading_screen.dart';
import 'package:quiz_app/screens/profile/profile.dart';
import 'package:quiz_app/screens/welcome/login/login_screen.dart';
import 'package:quiz_app/screens/quiz/quiz_screen.dart';
import 'package:quiz_app/screens/score/score_screen.dart';
import 'package:quiz_app/screens/welcome/signup/signup_screen.dart';
import 'package:quiz_app/screens/summary/summary.dart';
import 'package:quiz_app/screens/topic/topic_screen.dart';

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
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(
    //       systemNavigationBarColor: Colors.transparent,
    //       statusBarColor: Colors.grey.shade100),
    // );
    return MaterialApp(
      theme: ThemeData.light(),
      title: "QuizApp",
      debugShowCheckedModeBanner: false,
      initialRoute: (FirebaseAuth.instance.currentUser != null)
          ? TopicScreen.id
          : LoginScreen.id,
      // initialRoute: TopicScreen.id,
      routes: {
        LoginScreen.id: (context) => const LoginScreen(),
        SignUpScreen.id: (context) => const SignUpScreen(),
        TopicScreen.id: (context) => const TopicScreen(),
        ProfileScreen.id: (context) => const ProfileScreen(),
        AboutTheApp.id: (context) => const AboutTheApp(),
        LoadingScreen.id: (context) => const LoadingScreen(),
        LostInSpace.id: (context) => const LostInSpace(),
        NetworkErrorScreen.id: (context) => const NetworkErrorScreen(),
        QuizScreen.id: (context) => const QuizScreen(),
        ScoreScreen.id: (context) => const ScoreScreen(),
        SummaryScreen.id: (context) => const SummaryScreen(),
        ChatScreen.id: (context) => const ChatScreen(),
      },
    );
  }
}
