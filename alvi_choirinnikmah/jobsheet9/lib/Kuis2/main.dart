import 'user.dart';
// import 'package:pjson/contoh2/user.dart';

void main() {
  print('=== DEBUG: Check JSON Structure ===');

  // Object Dart ke JSON
  User user = User(
    id: 1,
    name: 'John Doe',
    email: 'john@example.com',
    createAt: DateTime.now(),
  );

  Map<String, dynamic> userJson = user.toJson();
  print('User.toJson() result: $userJson');
  print('Field names: ${userJson.keys.toList()}');

  print('\n=== TEST: Json to Object ===');
  // print('User JSON: $userJson'); 

  // JSON ke Object Dart (GUNAKAN FIELD NAMES YANG SAMA DENGAN toJson() RESULT)
  Map<String, dynamic> jsonData = {
    'id': 2,
    'name': 'Jane Doe',
    'email': 'jane@example.com',
    'createAt': '2024-01-01T10:00:00.000Z', // Perhatikan casing!
  };

  // Debug: Print JSON structure
  print('JSON data to parse: $jsonData');
  print('JSON keys: ${jsonData.keys.toList()}');
  print('id: ${jsonData['id']} (type: ${jsonData['id'].runtimeType})');
  print('name: ${jsonData['name']} (type: ${jsonData['name'].runtimeType})');
  print('email: ${jsonData['email']} (type: ${jsonData['email'].runtimeType})');
  print(
    'creteAt: ${jsonData['creteAt']} (type: ${jsonData['creteAt'].runtimeType})'
  );
  // User userFromJson = User.fromJson(jsonData);
  // print('User from JSON: ${userFromJson.name}');

  try {
    User userFromJson = User.fromJson(jsonData);
    print('✅SUCCES: User from JSON: $userFromJson');
  } catch (e, stack) {
    print('❌ ERROR: $e');
    print('Stack trace: $stack');
  }

  print ('\n=== TEST: Handle Missing Fields ===');

  // Test dengan missing fields 
  Map<String, dynamic> incompleteJson = {
    'id' : 3,
    // 'name' : missing
    'email' : 'test@example.com',
    // createdAt : missing
  };

  try {
    User userFromIncomplete = User.fromJson(incompleteJson);
    print('User from incomplete JSON: $userFromIncomplete');
  } catch (e, stack) {
    print(e);
    print('Error with incomplete JSON: $e');
  }
}