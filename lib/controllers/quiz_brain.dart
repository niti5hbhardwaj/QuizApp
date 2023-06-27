import '../data/question_bank.dart';
import '../models/question.dart';

class QuizBrain {
  int _currentQuestionNumber = 1;
  int _numberOfCorrectAnswers = 0;

  static final List<Question> _questions = sampleData
      .map((question) => Question(
          id: question["id"],
          questionText: question["question_text"],
          answer: question["answer_index"],
          tempOptions: question["options"]))
      .toList();

  int getNumberOfQuestions() {
    return _questions.length;
  }

  Question getQuestion(int index) {
    return _questions[index];
  }

  int getCurrentQuestionNumber() {
    return _currentQuestionNumber;
  }

  int getNumberOfCorrectAnswers() {
    return _numberOfCorrectAnswers;
  }

  void updateNumberOfCorrectAnswers() {
    _numberOfCorrectAnswers += 1;
  }

  void updateTheQuestionNumber(int index) {
    _currentQuestionNumber = index + 1;
  }
}
