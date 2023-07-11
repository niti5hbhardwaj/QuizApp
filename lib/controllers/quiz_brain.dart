import '../data/question_bank.dart';
import '../models/question.dart';

class QuizBrain {
  int _currentQuestionNumber = 1;
  int _numberOfCorrectAnswers = 0;
  static List<Question> questions = [];

  QuizBrain() {
    questions = questionBank
        .map((question) => Question(
            id: question["id"],
            questionText: question["question_text"],
            answer: question["answer_index"],
            tempOptions: question["options"],
            explanation: question["explanation"]))
        .toList();
  }

  //TODO: make the list of questions a private member
  // static List<Question>

  int getNumberOfQuestions() {
    return questions.length;
  }

  Question getQuestion(int index) {
    return questions[index];
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
