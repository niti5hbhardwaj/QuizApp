import 'package:flutter/material.dart';
import 'package:quiz_app/controllers/quiz_brain.dart';
import 'package:quiz_app/screens/components/summary_card.dart';

class SummaryScreen extends StatelessWidget {
  static const id = 'summary_screen';
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Explanations".toUpperCase()),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: QuizBrain.questions.length,
        itemBuilder: (context, index) {
          return SummaryCard(index: index);
        },
      ),
    );
  }
}
