class User {
  final int id;
  String imageUrl;
  final int userId;
  final String username;
  final String email;
  final String role;

  User({
    required this.id,
    required this.imageUrl,
    required this.userId,
    required this.username,
    required this.email,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      imageUrl: json['imageUrl'] as String,
      userId: json['user'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['imageUrl'] = imageUrl;
    data['user'] = userId;
    data['username'] = username;
    data['email'] = email;
    data['role'] = role;
    return data;
  }
}
