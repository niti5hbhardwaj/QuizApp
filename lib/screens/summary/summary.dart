import 'package:flutter/material.dart';
import 'package:quiz_app/controllers/quiz_brain.dart';
import 'package:quiz_app/screens/chat_screen/chat_screen.dart';
import 'package:quiz_app/screens/summary/components/summary_card.dart';

class SummaryScreen extends StatelessWidget {
  static const id = 'summary_screen';
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        foregroundColor: Colors.blueGrey.shade900,
        backgroundColor: Colors.transparent,
        title: Text(
          "Explanations".toUpperCase(),
          style: TextStyle(
            color: Colors.blueGrey.shade900,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: QuizBrain.questions.length,
        itemBuilder: (context, index) {
          return SummaryCard(
            index: index,
            onPressed: () {
              Navigator.pushNamed(context, ChatScreen.id,
                  arguments: QuizBrain.questions[index].questionText);
            },
          );
        },
      ),
    );
  }
}
