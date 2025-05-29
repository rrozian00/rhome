class IpModel {
  final String? id;
  final String? ipAddress;
  IpModel({this.id, required this.ipAddress});

  IpModel copyWith({String? id, String? ipAddress}) {
    return IpModel(id: id ?? this.id, ipAddress: ipAddress ?? this.ipAddress);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'ipAddress': ipAddress};
  }

  factory IpModel.fromMap(Map<String, dynamic> map) {
    return IpModel(
      id: map['id'] as String,
      ipAddress: map['ipAddress'] as String,
    );
  }
}
