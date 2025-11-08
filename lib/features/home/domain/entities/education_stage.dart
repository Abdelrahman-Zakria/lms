class EducationStage {
  final String id;
  final String name;
  final String? description;
  final String? image;
  final String systemId;

  const EducationStage({
    required this.id,
    required this.name,
    this.description,
    this.image,
    required this.systemId,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EducationStage &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.image == image &&
        other.systemId == systemId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        image.hashCode ^
        systemId.hashCode;
  }
}

