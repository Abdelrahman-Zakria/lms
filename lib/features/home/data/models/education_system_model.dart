class EducationSystemModel {
  final String id;
  final String name;
  final String? description;
  final String? image;

  const EducationSystemModel({
    required this.id,
    required this.name,
    this.description,
    this.image,
  });

  factory EducationSystemModel.fromJson(Map<String, dynamic> json) {
    return EducationSystemModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
    };
  }
}
