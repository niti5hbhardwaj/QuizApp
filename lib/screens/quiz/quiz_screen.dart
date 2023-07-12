import 'package:flutter/material.dart';
import '../../controllers/quiz_brain.dart';
import '../score/score_screen.dart';
import 'components/question_card.dart';

Color primaryColor = Colors.blueGrey.shade900;

class QuizScreen extends StatefulWidget {
  static const id = 'quiz_screen';
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final QuizBrain _quizBrain = QuizBrain();
  final _controller = PageController(initialPage: 0);

  void submitQuiz() {
    Navigator.pushReplacementNamed(
      context,
      ScoreScreen.id,
      arguments: {
        "score": _quizBrain.getNumberOfCorrectAnswers(),
        "total_questions": _quizBrain.getNumberOfQuestions()
      },
    );
  }

  void nextPage() {
    _controller.nextPage(
        duration: const Duration(milliseconds: 250), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    int totalNumberOfQuestions = _quizBrain.getNumberOfQuestions();
    int currentQuestionNumber = _quizBrain.getCurrentQuestionNumber();
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SizedBox(
                height: 81,
                width: double.infinity,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.blueGrey.shade900,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "Question $currentQuestionNumber",
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: primaryColor,
                              ),
                      children: [
                        TextSpan(
                          text: "/$totalNumberOfQuestions",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: primaryColor,
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
                        submitQuiz();
                      } else {
                        nextPage();
                      }
                    },
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStatePropertyAll(Colors.grey.shade300),
                    ),
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 670,
              child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: _controller,
                itemCount: _quizBrain.getNumberOfQuestions(),
                onPageChanged: (index) {
                  _quizBrain.updateTheQuestionNumber(index);
                  setState(() {
                    currentQuestionNumber =
                        _quizBrain.getCurrentQuestionNumber();
                    // print(currentQuestionNumber);
                  });
                },
                itemBuilder: (context, index) => QuestionCard(
                    question: _quizBrain.getQuestion(index),
                    controller: _controller,
                    quizBrain: _quizBrain),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            MaterialButton(
              onPressed: () {
                submitQuiz();
              },
              color: primaryColor,
              height: 60,
              minWidth: 250,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Text(
                "SUBMIT",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
