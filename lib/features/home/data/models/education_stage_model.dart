class EducationStageModel {
  final String id;
  final String name;
  final String? description;
  final String? image;
  final String systemId;

  const EducationStageModel({
    required this.id,
    required this.name,
    this.description,
    this.image,
    required this.systemId,
  });

  factory EducationStageModel.fromJson(Map<String, dynamic> json) {
    return EducationStageModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      image: json['image'],
      systemId: json['system_id']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'system_id': systemId,
    };
  }
}
