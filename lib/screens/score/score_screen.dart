import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
      backgroundColor: Colors.grey.shade900,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (score! > 7)
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
                    color: Colors.grey,
                    fontSize: 100,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${score * 10}/${numberOfQuestions! * 10}",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.grey,
                    fontSize: 55,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
