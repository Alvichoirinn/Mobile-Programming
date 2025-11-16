import 'user.dart';

void main() {
  // Object Dart ke JSON
  User user = User(
    id: 1,
    name: 'John Doe',
    email: 'john@example.com',
    createAt: DateTime.now(),
  );

  Map<String, dynamic> userJson = user.toJson();
  print('User JSON: $userJson');

  // JSON ke Object Dart
  Map<String, dynamic> jsonData = {
    'id': 2,
    'name': 'Jane Doe',
    'email': 'jane@example.com',
    'createAt': '2024-01-01T10:00:00.000Z',
  };

  User userFromJson = User.fromJson(jsonData);
  print('User from JSON: ${userFromJson.name}');
}