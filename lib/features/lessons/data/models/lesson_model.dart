class LessonModel {
  final String id;
  final String title;
  final String? description;
  final String? content;
  final String? image;
  final String? videoUrl;
  final String? audioUrl;
  final int? duration;
  final String? difficulty;
  final String? status;
  final int? progress;
  final String? unitId;
  final String? unitName;
  final int? order;

  const LessonModel({
    required this.id,
    required this.title,
    this.description,
    this.content,
    this.image,
    this.videoUrl,
    this.audioUrl,
    this.duration,
    this.difficulty,
    this.status,
    this.progress,
    this.unitId,
    this.unitName,
    this.order,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      description: json['description'],
      content: json['content'],
      image: json['image'],
      videoUrl: json['video_url'],
      audioUrl: json['audio_url'],
      duration: json['duration'],
      difficulty: json['difficulty'],
      status: json['status'],
      progress: json['progress'],
      unitId: json['unit_id'],
      unitName: json['unit_name'],
      order: json['order'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'content': content,
      'image': image,
      'video_url': videoUrl,
      'audio_url': audioUrl,
      'duration': duration,
      'difficulty': difficulty,
      'status': status,
      'progress': progress,
      'unit_id': unitId,
      'unit_name': unitName,
      'order': order,
    };
  }
}
