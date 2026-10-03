class ButtonModel {
  final String id;
  final String name;
  final String image;
  ButtonModel({required this.id, required this.name, required this.image});

  ButtonModel copyWith({String? id, String? name, String? image}) {
    return ButtonModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'name': name, 'image': image};
  }

  factory ButtonModel.fromMap(Map<String, dynamic> map) {
    return ButtonModel(
      id: map['id'] as String,
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }
}
