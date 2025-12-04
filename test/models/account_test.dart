import 'package:flutter_test/flutter_test.dart';
import 'package:cashflow_app/models/account.dart';

void main() {
  group('Account Model Tests', () {
    test('should create Account instance correctly', () {
      final account = Account(
        id: '1',
        name: 'Test Bank',
        type: AccountType.bank,
        balance: 1000.0,
        color: 0xFF000000,
        icon: 12345,
      );

      expect(account.id, '1');
      expect(account.name, 'Test Bank');
      expect(account.type, AccountType.bank);
      expect(account.balance, 1000.0);
      expect(account.color, 0xFF000000);
      expect(account.icon, 12345);
    });

    test('should convert Account to Map correctly', () {
      final account = Account(
        id: '1',
        name: 'Test Bank',
        type: AccountType.bank,
        balance: 1000.0,
        color: 0xFF000000,
        icon: 12345,
      );

      final map = account.toMap();

      expect(map['id'], '1');
      expect(map['name'], 'Test Bank');
      expect(map['type'], 'BANK');
      expect(map['balance'], 1000.0);
      expect(map['color'], 0xFF000000);
      expect(map['icon'], 12345);
    });

    test('should create Account from Map correctly', () {
      final map = {
        'id': '1',
        'name': 'Test Bank',
        'type': 'BANK',
        'balance': 1000.0,
        'color': 0xFF000000,
        'icon': 12345,
      };

      final account = Account.fromMap(map);

      expect(account.id, '1');
      expect(account.name, 'Test Bank');
      expect(account.type, AccountType.bank);
      expect(account.balance, 1000.0);
      expect(account.color, 0xFF000000);
      expect(account.icon, 12345);
    });

    test('should handle unknown account type gracefully', () {
      final map = {
        'id': '1',
        'name': 'Test Bank',
        'type': 'unknown_type',
        'balance': 1000.0,
        'color': 0xFF000000,
        'icon': 12345,
      };

      final account = Account.fromMap(map);
      expect(account.type, AccountType.other);
    });
  });
}
