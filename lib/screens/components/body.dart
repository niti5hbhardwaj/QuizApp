import 'package:flutter/material.dart';
import 'package:quiz_app/screens/components/question_card.dart';
import '../../controllers/quiz_brain.dart';
import '../score/score_screen.dart';

class QuestionBody extends StatefulWidget {
  const QuestionBody({super.key});
  @override
  State<QuestionBody> createState() => _QuestionBodyState();
}

class _QuestionBodyState extends State<QuestionBody> {
  final QuizBrain _quizBrain = QuizBrain();
  final _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    int totalNumberOfQuestions = _quizBrain.getNumberOfQuestions();
    int currentQuestionNumber = _quizBrain.getCurrentQuestionNumber();
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Question $currentQuestionNumber",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.grey.shade300,
                        ),
                    children: [
                      TextSpan(
                        text: "/$totalNumberOfQuestions",
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: Colors.grey.shade300,
                                  fontSize: 15,
                                ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (_controller.page! + 1 ==
                        _quizBrain.getNumberOfQuestions()) {
                      if (context.mounted) {
                        Navigator.pushReplacementNamed(
                          context,
                          ScoreScreen.id,
                          arguments: {
                            "score": _quizBrain.getNumberOfCorrectAnswers(),
                            "total_questions": _quizBrain.getNumberOfQuestions()
                          },
                        );
                      }
                    } else {
                      _controller.nextPage(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.ease);
                    }
                  },
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: _controller,
              itemCount: _quizBrain.getNumberOfQuestions(),
              onPageChanged: (index) {
                _quizBrain.updateTheQuestionNumber(index);
                setState(() {
                  currentQuestionNumber = _quizBrain.getCurrentQuestionNumber();
                  // print(currentQuestionNumber);
                });
              },
              itemBuilder: (context, index) => QuestionCard(
                  question: _quizBrain.getQuestion(index),
                  controller: _controller,
                  quizBrain: _quizBrain),
            ),
          ),
        ],
      ),
    );
  }
}
