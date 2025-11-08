class SubjectModel {
  final String id;
  final String name;
  final String? description;
  final String? image;
  final String? difficulty;
  final String? status;
  final int? progress;
  final bool? isSubscribe;
  final Map<String, dynamic>? metadata;

  const SubjectModel({
    required this.id,
    required this.name,
    this.description,
    this.image,
    this.difficulty,
    this.status,
    this.progress,
    this.isSubscribe,
    this.metadata,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    final int lessonsCount = (json['lessons_count'] is int) ? json['lessons_count'] : 0;
    final int finishesLessonsCount = (json['finishesLessons_count'] is int) ? json['finishesLessons_count'] : 0;
    final int? computedProgress = lessonsCount > 0
        ? ((finishesLessonsCount / lessonsCount) * 100).round()
        : 0;

    return SubjectModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      image: json['img'],
      difficulty: json['difficulty'],
      status: json['type']?.toString(),
      progress: computedProgress,
      isSubscribe: json['is_subscribe'] == true || json['is_subscribe'] == 1,
      metadata: Map<String, dynamic>.from(json),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'difficulty': difficulty,
      'status': status,
      'progress': progress,
      'metadata': metadata,
    };
  }
}
