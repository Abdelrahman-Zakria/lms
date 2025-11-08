class Subject {
  final int id;
  final String name;
  final String? description;
  final String? image;
  final String? difficulty;
  final String? status;
  final double? progress;
  final bool? isSubscribe;
  final Map<String, dynamic>? metadata;

  const Subject({
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Subject && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Subject(id: $id, name: $name)';
  }
}