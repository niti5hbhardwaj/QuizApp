import 'package:flutter/material.dart';
import 'package:quiz_app/controllers/quiz_brain.dart';
import '../../../models/question.dart';
import '../../score/score_screen.dart';
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

  void checkAnswerAndMoveForward(index) async {
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
            "total_questions": widget.quizBrain.getNumberOfQuestions()
          },
        );
      }
    } else {
      widget.controller.nextPage(
          duration: const Duration(milliseconds: 250), curve: Curves.ease);
    }
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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 10,
              spreadRadius: 4,
              offset: Offset.fromDirection(1, 7),
            ),
          ],
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
                color: Colors.blueGrey.shade900,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 12.5,
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(
                  overscroll: false,
                ),
                child: ListView(
                  children: [
                    ...List.generate(
                      widget.question.options.length,
                      (index) => Option(
                        optionText: widget.question.options[index],
                        index: index,
                        color: getCorrectColor(index),
                        onPressed: () {
                          (!answered)
                              ? checkAnswerAndMoveForward(index)
                              : () {};
                        },
                        icon: getCorrectIcon(index),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
