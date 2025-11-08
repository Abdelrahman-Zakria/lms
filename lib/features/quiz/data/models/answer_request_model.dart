class AnswerRequestModel {
  final int answerTime;
  final int answerNum;
  final String questionId;
  final bool isLast;

  const AnswerRequestModel({
    required this.answerTime,
    required this.answerNum,
    required this.questionId,
    required this.isLast,
  });

  factory AnswerRequestModel.fromJson(Map<String, dynamic> json) {
    return AnswerRequestModel(
      answerTime: json['answer_time'] ?? 0,
      answerNum: json['answer_num'] ?? 0,
      questionId: json['question_id']?.toString() ?? '',
      isLast: json['is_last'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'answer_time': answerTime,
      'answer_num': answerNum,
      'question_id': questionId,
      'is_last': isLast,
    };
  }
}
