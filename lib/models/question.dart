class Question {
  final int id, answer;
  final String questionText;
  final List<dynamic> tempOptions;
  late List<String> options;

  Question(
      {required this.id,
      required this.questionText,
      required this.answer,
      required this.tempOptions}) {
    options = tempOptions.map((option) => option.toString()).toList();
  }
}
