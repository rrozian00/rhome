class ButtonModel {
  final int? id;
  final String name;
  final String image;
  ButtonModel({this.id, required this.name, required this.image});

  ButtonModel copyWith({int? id, String? name, String? image}) {
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
      id: map['id'] as int,
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }
}
