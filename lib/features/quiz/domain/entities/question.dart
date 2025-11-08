class Question {
  final String id;
  final String question;
  final String? image;
  final List<String> options;
  final int correctAnswer;
  final String? explanation;
  final int? timeLimit;

  const Question({
    required this.id,
    required this.question,
    this.image,
    required this.options,
    required this.correctAnswer,
    this.explanation,
    this.timeLimit,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Question &&
        other.id == id &&
        other.question == question &&
        other.image == image &&
        other.options == options &&
        other.correctAnswer == correctAnswer &&
        other.explanation == explanation &&
        other.timeLimit == timeLimit;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        question.hashCode ^
        image.hashCode ^
        options.hashCode ^
        correctAnswer.hashCode ^
        explanation.hashCode ^
        timeLimit.hashCode;
  }
}


