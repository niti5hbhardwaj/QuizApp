import 'package:flutter/material.dart';

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
            Text(
              "Score",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.grey,
                    fontSize: 35,
                  ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "${score! * 10}/ ${numberOfQuestions! * 10}",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.grey,
                    fontSize: 35,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
