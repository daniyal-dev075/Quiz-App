class UserModel {
  final String name;
  final String email;
  final String profilePic;

  UserModel({
    required this.name,
    required this.email,
    required this.profilePic,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      profilePic: map['profilePic'] ?? '',
    );
  }
}
