import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/screens/score/components/util_functions.dart';
import 'package:quiz_app/screens/summary/summary.dart';
import 'package:quiz_app/screens/topic/topic_screen.dart';

Color foregroundColor = Colors.blueGrey.shade900;
Color backgroundColor = Colors.grey.shade100;

class ScoreScreen extends StatelessWidget {
  static const id = 'score_screen';
  const ScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, int>;
    int? score = arguments["score"];
    int? numberOfQuestions = arguments["total_questions"];
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (score! / numberOfQuestions! > 0.7)
                ? Lottie.asset("assets/animations/score_screen_animation.json",
                    repeat: false)
                : const SizedBox(
                    height: 0,
                  ),
            const SizedBox(
              height: 60,
            ),
            Text(
              "Score",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: foregroundColor,
                    fontSize: 100,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${score * 10}/${numberOfQuestions * 10}",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: foregroundColor,
                    fontSize: 55,
                  ),
            ),
            const SizedBox(
              height: 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  height: 55,
                  minWidth: 160,
                  color: foregroundColor,
                  onPressed: () {
                    updateScore(score!);
                    Navigator.pushNamedAndRemoveUntil(
                        context, TopicScreen.id, (route) => false);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    "Take another quiz",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                MaterialButton(
                  height: 55,
                  minWidth: 160,
                  color: foregroundColor,
                  onPressed: () {
                    Navigator.pushNamed(context, SummaryScreen.id);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    "Check Solutions",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
