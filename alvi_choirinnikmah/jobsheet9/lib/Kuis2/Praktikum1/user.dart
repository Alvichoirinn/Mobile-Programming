class  User {
  final int id;
  final String name;
  final String email;
  final DateTime createAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.createAt,
  });

  // Konversi dari JSON ke Object Dart
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      createAt: DateTime.parse(json['createAt']),
    );
  }

  // Konversi dari Object Dart ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'createAt': createAt.toIso8601String(),
    };
  }
}