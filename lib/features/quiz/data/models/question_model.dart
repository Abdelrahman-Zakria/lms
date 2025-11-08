class QuestionModel {
  final String id;
  final String question;
  final String? image;
  final List<String> options;
  final int correctAnswer;
  final String? explanation;
  final int? timeLimit;

  const QuestionModel({
    required this.id,
    required this.question,
    this.image,
    required this.options,
    required this.correctAnswer,
    this.explanation,
    this.timeLimit,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    // API fields mapping
    final String questionText = (json['ques_text'] ?? json['question'] ?? '').toString();
    final String? imageUrl = json['image'] ?? json['ques_file_api'];

    // Build options list from select_1_text .. select_4_text (fallback to 'options')
    final List<String> options = <String?>[
      json['select_1_text']?.toString(),
      json['select_2_text']?.toString(),
      json['select_3_text']?.toString(),
      json['select_4_text']?.toString(),
    ].whereType<String>().toList();

    final int correctIndex = () {
      final dynamic raw = json['correct_select'] ?? json['correct_answer'];
      if (raw == null) return 0;
      final String s = raw.toString();
      final int? oneBased = int.tryParse(s);
      if (oneBased != null) return (oneBased - 1).clamp(0, 3);
      final int? zeroBased = int.tryParse(s);
      return (zeroBased ?? 0).clamp(0, 3);
    }();

    return QuestionModel(
      id: json['id']?.toString() ?? '',
      question: questionText,
      image: imageUrl?.toString(),
      options: options,
      correctAnswer: correctIndex,
      explanation: json['description_text']?.toString() ?? json['explanation']?.toString(),
      timeLimit: (json['time_limit'] is int) ? json['time_limit'] as int : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'image': image,
      'options': options,
      'correct_answer': correctAnswer,
      'explanation': explanation,
      'time_limit': timeLimit,
    };
  }
}
