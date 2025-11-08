class Classroom {
  final String id;
  final String name;
  final String? description;
  final String? image;
  final String stageId;

  const Classroom({
    required this.id,
    required this.name,
    this.description,
    this.image,
    required this.stageId,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Classroom &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.image == image &&
        other.stageId == stageId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        image.hashCode ^
        stageId.hashCode;
  }
}

