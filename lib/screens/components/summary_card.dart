import 'package:flutter/material.dart';

import '../../controllers/quiz_brain.dart';

class SummaryCard extends StatelessWidget {
  final int index;
  final VoidCallback onPressed;
  const SummaryCard({
    super.key,
    required this.index,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            spreadRadius: 4,
            offset: Offset.fromDirection(1, 7),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Q: ${QuizBrain.questions[index].questionText}",
            style: TextStyle(
              color: Colors.blueGrey.shade900,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "A: ${QuizBrain.questions[index].options[QuizBrain.questions[index].answer]}",
            style: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text.rich(
            TextSpan(
              text: "Explanation: ",
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              children: [
                TextSpan(
                  text: QuizBrain.questions[index].explanation,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Still have a doubt?",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              MaterialButton(
                color: Colors.blue.shade300,
                onPressed: onPressed,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Text(
                  "Ask ChatGPT",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
