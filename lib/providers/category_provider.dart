import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/category.dart';

class CategoryProvider with ChangeNotifier {
  List<Category> _categories = [];

  List<Category> get categories => _categories;

  List<Category> get expenseCategories =>
      _categories.where((c) => c.type == CategoryType.expense).toList();

  List<Category> get incomeCategories =>
      _categories.where((c) => c.type == CategoryType.income).toList();

  CategoryProvider() {
    loadCategories();
  }

  Future<void> loadCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final categoriesString = prefs.getString('categories');

    if (categoriesString != null) {
      final List<dynamic> decodedList = jsonDecode(categoriesString);
      _categories = decodedList.map((item) => Category.fromMap(item)).toList();
    }

    _ensureDefaultCategories();
    notifyListeners();
  }

  void _ensureDefaultCategories() {
    final defaultCategories = [
      // Expense Categories
      Category(
        id: 'food',
        name: 'Food',
        iconCodePoint: Icons.restaurant.codePoint,
        colorValue: Colors.orange.toARGB32(),
        type: CategoryType.expense,
        isDefault: true,
      ),
      Category(
        id: 'transport',
        name: 'Transport',
        iconCodePoint: Icons.directions_bus.codePoint,
        colorValue: Colors.blue.toARGB32(),
        type: CategoryType.expense,
        isDefault: true,
      ),
      Category(
        id: 'shopping',
        name: 'Shopping',
        iconCodePoint: Icons.shopping_bag.codePoint,
        colorValue: Colors.pink.toARGB32(),
        type: CategoryType.expense,
        isDefault: true,
      ),
      Category(
        id: 'bills',
        name: 'Bills',
        iconCodePoint: Icons.receipt_long.codePoint,
        colorValue: Colors.red.toARGB32(),
        type: CategoryType.expense,
        isDefault: true,
      ),
      Category(
        id: 'entertainment',
        name: 'Entertainment',
        iconCodePoint: Icons.movie.codePoint,
        colorValue: Colors.purple.toARGB32(),
        type: CategoryType.expense,
        isDefault: true,
      ),
      Category(
        id: 'health',
        name: 'Health',
        iconCodePoint: Icons.medical_services.codePoint,
        colorValue: Colors.green.toARGB32(),
        type: CategoryType.expense,
        isDefault: true,
      ),
      Category(
        id: 'groceries',
        name: 'Groceries',
        iconCodePoint: Icons.local_grocery_store.codePoint,
        colorValue: Colors.teal.toARGB32(),
        type: CategoryType.expense,
        isDefault: true,
      ),
      Category(
        id: 'rent',
        name: 'Rent',
        iconCodePoint: Icons.home.codePoint,
        colorValue: Colors.indigo.toARGB32(),
        type: CategoryType.expense,
        isDefault: true,
      ),
      Category(
        id: 'education',
        name: 'Education',
        iconCodePoint: Icons.school.codePoint,
        colorValue: Colors.orangeAccent.toARGB32(),
        type: CategoryType.expense,
        isDefault: true,
      ),
      Category(
        id: 'travel',
        name: 'Travel',
        iconCodePoint: Icons.flight.codePoint,
        colorValue: Colors.lightBlue.toARGB32(),
        type: CategoryType.expense,
        isDefault: true,
      ),
      Category(
        id: 'other_expense',
        name: 'Other',
        iconCodePoint: Icons.more_horiz.codePoint,
        colorValue: Colors.grey.toARGB32(),
        type: CategoryType.expense,
        isDefault: true,
      ),

      // Income Categories
      Category(
        id: 'salary',
        name: 'Salary',
        iconCodePoint: Icons.attach_money.codePoint,
        colorValue: Colors.green.toARGB32(),
        type: CategoryType.income,
        isDefault: true,
      ),
      Category(
        id: 'freelance',
        name: 'Freelance',
        iconCodePoint: Icons.computer.codePoint,
        colorValue: Colors.blueAccent.toARGB32(),
        type: CategoryType.income,
        isDefault: true,
      ),
      Category(
        id: 'business',
        name: 'Business',
        iconCodePoint: Icons.business_center.codePoint,
        colorValue: Colors.indigo.toARGB32(),
        type: CategoryType.income,
        isDefault: true,
      ),
      Category(
        id: 'investment',
        name: 'Investment',
        iconCodePoint: Icons.trending_up.codePoint,
        colorValue: Colors.teal.toARGB32(),
        type: CategoryType.income,
        isDefault: true,
      ),
      Category(
        id: 'rental',
        name: 'Rental',
        iconCodePoint: Icons.home_work.codePoint,
        colorValue: Colors.brown.toARGB32(),
        type: CategoryType.income,
        isDefault: true,
      ),
      Category(
        id: 'gift',
        name: 'Gift',
        iconCodePoint: Icons.card_giftcard.codePoint,
        colorValue: Colors.pinkAccent.toARGB32(),
        type: CategoryType.income,
        isDefault: true,
      ),
      Category(
        id: 'other_income',
        name: 'Other',
        iconCodePoint: Icons.more_horiz.codePoint,
        colorValue: Colors.grey.toARGB32(),
        type: CategoryType.income,
        isDefault: true,
      ),
    ];

    bool hasChanges = false;
    for (final defaultCategory in defaultCategories) {
      if (!_categories.any((c) => c.id == defaultCategory.id)) {
        _categories.add(defaultCategory);
        hasChanges = true;
      }
    }

    if (hasChanges) {
      _saveCategories();
    }
  }

  Future<void> addCategory(Category category) async {
    _categories.add(category);
    await _saveCategories();
    notifyListeners();
  }

  Future<void> updateCategory(Category category) async {
    final index = _categories.indexWhere((c) => c.id == category.id);
    if (index != -1) {
      _categories[index] = category;
      await _saveCategories();
      notifyListeners();
    }
  }

  Future<void> deleteCategory(String id) async {
    _categories.removeWhere((c) => c.id == id && !c.isDefault);
    await _saveCategories();
    notifyListeners();
  }

  Future<void> _saveCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final categoriesString = jsonEncode(
      _categories.map((c) => c.toMap()).toList(),
    );
    await prefs.setString('categories', categoriesString);
  }
}
