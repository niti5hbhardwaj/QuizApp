import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quiz_app/screens/quiz_screen.dart';
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
      backgroundColor: backgroundColor,
      body: Center(
        child: (isLoading)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SpinKitFoldingCube(
                    color: foregroundColor,
                    size: 100,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Text(
                    "Loading Quiz Data",
                    style: TextStyle(
                      fontSize: 25,
                      color: foregroundColor,
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
    );
  }
}

Future<void> getQuestions() async {
  await Future.delayed(Duration(seconds: 2), () {
    print("Hello");
  });
}
