import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quiz_app/screens/quiz_screen.dart';
import 'chat_api/chat_api.dart';

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
      body: Center(
        child: (isLoading)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SpinKitFoldingCube(
                    color: Colors.blueGrey.shade900,
                    size: 100,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Text(
                    "Loading Quiz Data",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.blueGrey.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            : MaterialButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await getQuestions();
                  setState(() {
                    isLoading = false;
                  });
                  if (context.mounted) {
                    Navigator.pushReplacementNamed(context, QuizScreen.id);
                  }
                },
                color: Colors.blueGrey.shade900,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                height: 50,
                minWidth: 150,
                elevation: 5,
                child: const Text(
                  "Start Quiz",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
      ),
    );
  }
}

// Future<void> getQuestions() async {
//   await Future.delayed(Duration(seconds: 2), () {
//     print("Hello");
//   });
// }
