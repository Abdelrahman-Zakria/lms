class Lesson {
  final int id;
  final String title;
  final String? description;
  final String? content;
  final String? image;
  final String? videoUrl;
  final String? audioUrl;
  final String? duration;
  final String? difficulty;
  final String? status;
  final double? progress;
  final int? unitId;
  final String? unitName;
  final int? order;
  final Map<String, dynamic>? metadata;

  const Lesson({
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
    this.metadata,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Lesson && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Lesson(id: $id, title: $title)';
  }
}