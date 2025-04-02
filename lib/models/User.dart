class User {
  final int id;
  final String userName;
  final String email;
  final String token;

  User({
    required this.id,
    required this.userName,
    required this.email,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userName: json['userName'],
      email: json['email'],
      token: json['token'],
    );
  }
}
