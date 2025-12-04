import 'package:flutter_test/flutter_test.dart';
import 'package:cashflow_app/utils/validators.dart';

void main() {
  group('Validators Tests', () {
    group('validateEmail', () {
      test('should return error for empty email', () {
        expect(Validators.validateEmail(''), 'Email is required');
        expect(Validators.validateEmail(null), 'Email is required');
      });

      test('should return error for invalid email format', () {
        expect(
          Validators.validateEmail('invalid-email'),
          'Enter a valid email',
        );
        expect(Validators.validateEmail('test@'), 'Enter a valid email');
        expect(Validators.validateEmail('@test.com'), 'Enter a valid email');
      });

      test('should return null for valid email', () {
        expect(Validators.validateEmail('test@example.com'), null);
        expect(Validators.validateEmail('user.name@domain.co.uk'), null);
      });
    });

    group('validateUsername', () {
      test('should return error for empty username', () {
        expect(Validators.validateUsername(''), 'Username is required');
        expect(Validators.validateUsername(null), 'Username is required');
      });

      test('should return error for short username', () {
        expect(
          Validators.validateUsername('ab'),
          'Username must be at least 3 characters',
        );
      });

      test('should return null for valid username', () {
        expect(Validators.validateUsername('abc'), null);
        expect(Validators.validateUsername('username123'), null);
      });
    });

    group('validatePassword', () {
      test('should return error for empty password', () {
        expect(Validators.validatePassword(''), 'Password is required');
        expect(Validators.validatePassword(null), 'Password is required');
      });

      test('should return error for short password', () {
        expect(
          Validators.validatePassword('12345'),
          'Password must be at least 6 characters',
        );
      });

      test('should return null for valid password', () {
        expect(Validators.validatePassword('123456'), null);
        expect(Validators.validatePassword('password123'), null);
      });
    });

    group('validateName', () {
      test('should return error for empty name', () {
        expect(Validators.validateName(''), 'Name is required');
        expect(Validators.validateName(null), 'Name is required');
      });

      test('should return error for short name', () {
        expect(
          Validators.validateName('a'),
          'Name must be at least 2 characters',
        );
      });

      test('should return null for valid name', () {
        expect(Validators.validateName('Jo'), null);
        expect(Validators.validateName('John'), null);
      });
    });

    group('validateAmount', () {
      test('should return error for empty amount', () {
        expect(Validators.validateAmount(''), 'Amount is required');
        expect(Validators.validateAmount(null), 'Amount is required');
      });

      test('should return error for non-numeric amount', () {
        expect(Validators.validateAmount('abc'), 'Enter a valid number');
        expect(Validators.validateAmount('12.34.56'), 'Enter a valid number');
      });

      test('should return error for zero or negative amount', () {
        expect(Validators.validateAmount('0'), 'Amount must be greater than 0');
        expect(
          Validators.validateAmount('-10'),
          'Amount must be greater than 0',
        );
      });

      test('should return null for valid amount', () {
        expect(Validators.validateAmount('100'), null);
        expect(Validators.validateAmount('10.50'), null);
      });
    });

    group('validateRequired', () {
      test('should return error for empty value', () {
        expect(Validators.validateRequired('', 'Field'), 'Field is required');
        expect(Validators.validateRequired(null, 'Field'), 'Field is required');
      });

      test('should return null for valid value', () {
        expect(Validators.validateRequired('value', 'Field'), null);
      });
    });
  });
}
