class ClassroomModel {
  final String id;
  final String name;
  final String? description;
  final String? image;
  final String stageId;

  const ClassroomModel({
    required this.id,
    required this.name,
    this.description,
    this.image,
    required this.stageId,
  });

  factory ClassroomModel.fromJson(Map<String, dynamic> json) {
    return ClassroomModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      image: json['image'],
      stageId: json['stage_id']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'stage_id': stageId,
    };
  }
}
