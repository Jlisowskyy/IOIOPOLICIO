class QuizQuestionModel {
  final String question;
  final List<String> options;
  final int correctOptionIndex;

  const QuizQuestionModel({
    required this.question,
    required this.options,
    required this.correctOptionIndex,
  });
}
