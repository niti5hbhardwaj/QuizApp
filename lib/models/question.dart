class Question {
  final int id, answer;
  final String questionText, explanation;
  final List<dynamic> tempOptions;
  late List<String> options;

  Question({
    required this.id,
    required this.questionText,
    required this.answer,
    required this.tempOptions,
    required this.explanation,
  }) {
    options = tempOptions.map((option) => option.toString()).toList();
  }
}
