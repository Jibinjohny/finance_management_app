import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../services/database_helper.dart';

class AuthProvider with ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuth => _currentUser != null;

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userId')) return false;

    final userId = prefs.getString('userId');
    if (userId == null) return false;

    try {
      final db = await DatabaseHelper.instance.database;
      final maps = await db.query(
        'users',
        where: 'id = ?',
        whereArgs: [userId],
      );

      if (maps.isNotEmpty) {
        _currentUser = User.fromMap(maps.first);
        notifyListeners();
        return true;
      }
    } catch (e) {
      print('Auto-login error: $e');
    }
    return false;
  }

  Future<bool> signup(
    String firstName,
    String lastName,
    String username,
    String password,
    String currency,
  ) async {
    _isLoading = true;
    notifyListeners();

    try {
      final db = await DatabaseHelper.instance.database;

      print('Checking if username $username exists...');
      // Check if username exists
      final maps = await db.query(
        'users',
        where: 'username = ?',
        whereArgs: [username],
      );

      print('Query result: $maps');

      if (maps.isNotEmpty) {
        print('Username already exists!');
        _isLoading = false;
        notifyListeners();
        return false; // Username already exists
      }

      final newUser = User(
        id: const Uuid().v4(),
        firstName: firstName,
        lastName: lastName,
        username: username,
        password: password,
        currency: currency,
      );

      print('Inserting new user: ${newUser.toMap()}');
      await db.insert('users', newUser.toMap());
      print('User inserted successfully');

      _currentUser = newUser;

      // Save to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', newUser.id);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print('Signup error: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      print('Attempting login for $username');
      final db = await DatabaseHelper.instance.database;

      final maps = await db.query(
        'users',
        where: 'username = ? AND password = ?',
        whereArgs: [username, password],
      );

      print('Login query result: $maps');

      if (maps.isNotEmpty) {
        _currentUser = User.fromMap(maps.first);
        print('Login successful for user: ${_currentUser!.id}');

        // Save to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', _currentUser!.id);

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        print('Login failed: User not found or invalid password');
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print('Login error: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    _currentUser = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    notifyListeners();
  }

  Future<void> resetData() async {
    await DatabaseHelper.instance.deleteDB();
    _currentUser = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    notifyListeners();
  }

  Future<bool> updateUser(
    String firstName,
    String lastName,
    String password,
    String currency,
  ) async {
    if (_currentUser == null) return false;
    _isLoading = true;
    notifyListeners();

    try {
      final db = await DatabaseHelper.instance.database;

      final updatedUser = User(
        id: _currentUser!.id,
        firstName: firstName,
        lastName: lastName,
        username: _currentUser!.username, // Username cannot be changed
        password: password,
        currency: currency,
      );

      await db.update(
        'users',
        updatedUser.toMap(),
        where: 'id = ?',
        whereArgs: [_currentUser!.id],
      );

      _currentUser = updatedUser;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print('Update user error: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
