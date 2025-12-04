import 'package:flutter_test/flutter_test.dart';
import 'package:cashflow_app/models/user.dart';

void main() {
  group('User Model Tests', () {
    final user = User(
      id: 'u1',
      firstName: 'John',
      lastName: 'Doe',
      username: 'johndoe',
      password: 'password123',
    );

    test('should create a valid User instance', () {
      expect(user.id, 'u1');
      expect(user.firstName, 'John');
      expect(user.lastName, 'Doe');
      expect(user.username, 'johndoe');
      expect(user.password, 'password123');
    });

    test('toMap should return a valid map', () {
      final map = user.toMap();

      expect(map['id'], 'u1');
      expect(map['firstName'], 'John');
      expect(map['lastName'], 'Doe');
      expect(map['username'], 'johndoe');
      expect(map['password'], 'password123');
    });

    test('fromMap should return a valid User object', () {
      final map = {
        'id': 'u1',
        'firstName': 'John',
        'lastName': 'Doe',
        'username': 'johndoe',
        'password': 'password123',
      };

      final result = User.fromMap(map);

      expect(result.id, user.id);
      expect(result.firstName, user.firstName);
      expect(result.lastName, user.lastName);
      expect(result.username, user.username);
      expect(result.password, user.password);
    });
  });
}
