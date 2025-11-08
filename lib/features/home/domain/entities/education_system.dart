class EducationSystem {
  final String id;
  final String name;
  final String? description;
  final String? image;

  const EducationSystem({
    required this.id,
    required this.name,
    this.description,
    this.image,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EducationSystem &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ description.hashCode ^ image.hashCode;
  }
}

