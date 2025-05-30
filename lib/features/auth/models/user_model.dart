class UserModel {
  final String? uid;
  final String? name;
  final String? email;
  final String? photoUrl;
  final String? ipAddress;

  UserModel({this.uid, this.name, this.email, this.photoUrl, this.ipAddress});

  // Convert UserModel to Map (for saving to Firestore)
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'ipAddress': ipAddress,
    };
  }

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? photoUrl,
    String? ipAddress,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      ipAddress: ipAddress ?? this.ipAddress,
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] != null ? map['uid'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      photoUrl: map['photoUrl'] != null ? map['photoUrl'] as String : null,
      ipAddress: map['ipAddress'] != null ? map['ipAddress'] as String : null,
    );
  }
}
