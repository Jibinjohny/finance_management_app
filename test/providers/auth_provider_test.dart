import 'package:flutter_test/flutter_test.dart';
import 'package:cashflow_app/providers/auth_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:cashflow_app/services/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late AuthProvider authProvider;
  late DatabaseHelper dbHelper;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    DatabaseHelper.dbNameOverride = inMemoryDatabasePath;
  });

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    dbHelper = DatabaseHelper.instance;
    // Ensure we start with a clean state
    await dbHelper.deleteDB();
    // Re-initialize database to ensure tables exist
    await dbHelper.database;
    authProvider = AuthProvider();
  });

  tearDown(() async {
    await dbHelper.close();
  });

  group('AuthProvider Tests', () {
    test('Initial state should be unauthenticated', () {
      expect(authProvider.isAuth, false);
      expect(authProvider.currentUser, null);
    });

    test('Signup should create user and authenticate', () async {
      final success = await authProvider.signup(
        'John',
        'Doe',
        'signup_user',
        'password123',
        '₹',
      );

      expect(success, true);
      expect(authProvider.isAuth, true);
      expect(authProvider.currentUser?.username, 'signup_user');

      // Verify persistence
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('userId'), isNotNull);
    });

    test('Signup should fail if username exists', () async {
      await authProvider.signup(
        'John',
        'Doe',
        'duplicate_user',
        'password123',
        '₹',
      );

      final success = await authProvider.signup(
        'Jane',
        'Doe',
        'duplicate_user', // Same username
        'password456',
        '₹',
      );

      expect(success, false);
    });

    test('Login should succeed with correct credentials', () async {
      // Create user first
      await authProvider.signup(
        'John',
        'Doe',
        'login_user',
        'password123',
        '₹',
      );

      // Logout to reset state
      await authProvider.logout();
      expect(authProvider.isAuth, false);

      // Login
      final success = await authProvider.login('login_user', 'password123');

      expect(success, true);
      expect(authProvider.isAuth, true);
      expect(authProvider.currentUser?.username, 'login_user');
    });

    test('Login should fail with incorrect credentials', () async {
      await authProvider.signup(
        'John',
        'Doe',
        'fail_login_user',
        'password123',
        '₹',
      );
      await authProvider.logout();

      final success = await authProvider.login(
        'fail_login_user',
        'wrongpassword',
      );

      expect(success, false);
      expect(authProvider.isAuth, false);
    });

    test('Logout should clear user and persistence', () async {
      await authProvider.signup(
        'John',
        'Doe',
        'logout_user',
        'password123',
        '₹',
      );

      await authProvider.logout();

      expect(authProvider.isAuth, false);
      expect(authProvider.currentUser, null);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('userId'), null);
    });

    test('tryAutoLogin should restore session', () async {
      // Setup: Create user and manually set SharedPreferences
      await authProvider.signup(
        'John',
        'Doe',
        'auto_login_user',
        'password123',
        '₹',
      );

      final currentUser = authProvider.currentUser;
      expect(currentUser, isNotNull);
      final userId = currentUser!.id;

      // Reset provider but keep DB and Prefs
      authProvider = AuthProvider();

      final success = await authProvider.tryAutoLogin();

      expect(success, true);
      expect(authProvider.isAuth, true);
      expect(authProvider.currentUser?.id, userId);
    });

    test('updateUser should update user details', () async {
      await authProvider.signup(
        'John',
        'Doe',
        'update_user',
        'password123',
        '₹',
      );

      final success = await authProvider.updateUser(
        'Johnny',
        'Smith',
        'newpassword',
        '₹',
      );

      expect(success, true);
      expect(authProvider.currentUser?.firstName, 'Johnny');
      expect(authProvider.currentUser?.lastName, 'Smith');
      expect(authProvider.currentUser?.password, 'newpassword');

      // Verify in DB
      final db = await dbHelper.database;
      final maps = await db.query(
        'users',
        where: 'username = ?',
        whereArgs: ['update_user'],
      );
      expect(maps.first['firstName'], 'Johnny');
    });
  });
}
