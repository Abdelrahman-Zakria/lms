class Term {
  final String id;
  final String name;
  final String? description;
  final String? image;
  final String classroomId;

  const Term({
    required this.id,
    required this.name,
    this.description,
    this.image,
    required this.classroomId,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Term &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.image == image &&
        other.classroomId == classroomId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        image.hashCode ^
        classroomId.hashCode;
  }
}

