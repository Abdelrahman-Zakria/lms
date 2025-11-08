class PathModel {
  final String id;
  final String name;
  final String? description;
  final String? image;
  final String classroomId;

  const PathModel({
    required this.id,
    required this.name,
    this.description,
    this.image,
    required this.classroomId,
  });

  factory PathModel.fromJson(Map<String, dynamic> json) {
    return PathModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      image: json['image'],
      classroomId: json['classroom_id']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'classroom_id': classroomId,
    };
  }
}
