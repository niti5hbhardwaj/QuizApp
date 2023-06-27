import 'package:flutter/material.dart';
import 'package:quiz_app/controllers/quiz_brain.dart';
import '../../models/question.dart';
import '../score/score_screen.dart';
import 'option.dart';

class QuestionCard extends StatefulWidget {
  final Question question;
  final PageController controller;
  final QuizBrain quizBrain;
  const QuestionCard(
      {super.key,
      required this.question,
      required this.controller,
      required this.quizBrain});
  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  bool answered = false;
  late int selectedOption;

  Future<void> checkAnswer(int selectedOption) async {
    if (selectedOption == widget.question.answer) {
      widget.quizBrain.updateNumberOfCorrectAnswers();
    }
    setState(() {
      answered = true;
    });
    await Future.delayed(const Duration(seconds: 1), () {});
  }

  Color getCorrectColor(int index) {
    if (answered) {
      if (index == widget.question.answer) {
        return Colors.green;
      } else if (index == selectedOption &&
          selectedOption != widget.question.answer) {
        return Colors.red;
      }
    }
    return Colors.grey;
  }

  IconData? getCorrectIcon(int index) {
    if (answered) {
      if (index == widget.question.answer) {
        return Icons.check;
      } else if (index == selectedOption &&
          selectedOption != widget.question.answer) {
        return Icons.close;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 12.5,
          ),
          Text(
            widget.question.questionText,
            style: TextStyle(
              color: Colors.grey.shade900,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 12.5,
          ),
          ...List.generate(
            widget.question.options.length,
            (index) => Option(
              optionText: widget.question.options[index],
              index: index,
              color: getCorrectColor(index),
              onPressed: () async {
                selectedOption = index;
                await checkAnswer(index);
                if (widget.controller.page! + 1 ==
                    widget.quizBrain.getNumberOfQuestions()) {
                  if (context.mounted) {
                    Navigator.pushReplacementNamed(
                      context,
                      ScoreScreen.id,
                      arguments: {
                        "score": widget.quizBrain.getNumberOfCorrectAnswers(),
                        "total_questions":
                            widget.quizBrain.getNumberOfQuestions()
                      },
                    );
                  }
                } else {
                  widget.controller.nextPage(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.ease);
                }
              },
              icon: getCorrectIcon(index),
            ),
          ),
        ],
      ),
    );
  }
}
