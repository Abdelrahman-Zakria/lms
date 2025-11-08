class QuizResult {
  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;
  final int totalTime;
  final double score;
  final List<QuestionResult> questionResults;

  const QuizResult({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.totalTime,
    required this.score,
    required this.questionResults,
  });
}

class QuestionResult {
  final String questionId;
  final int selectedAnswer;
  final int correctAnswer;
  final bool isCorrect;
  final int attempts;
  final int timeSpent;
  final String? explanation;

  const QuestionResult({
    required this.questionId,
    required this.selectedAnswer,
    required this.correctAnswer,
    required this.isCorrect,
    required this.attempts,
    required this.timeSpent,
    this.explanation,
  });
}


