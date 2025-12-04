import 'package:flutter/material.dart';
import '../models/tag.dart';
import '../services/database_helper.dart';

class TagProvider with ChangeNotifier {
  List<Tag> _tags = [];
  String? _userId;

  List<Tag> get tags => [..._tags];

  void setUserId(String? userId) {
    _userId = userId;
    if (userId != null) {
      fetchTags();
    } else {
      _tags = [];
      notifyListeners();
    }
  }

  Future<void> fetchTags() async {
    if (_userId == null) return;

    final db = await DatabaseHelper.instance.database;
    final result = await db.query(
      'tags',
      where: 'userId = ?',
      whereArgs: [_userId],
      orderBy: 'name ASC',
    );

    _tags = result.map((json) => Tag.fromMap(json)).toList();
    notifyListeners();
  }

  Future<void> addTag(Tag tag) async {
    if (_userId == null) return;

    final db = await DatabaseHelper.instance.database;
    await db.insert('tags', tag.toMap());
    _tags.add(tag);
    notifyListeners();
  }

  Future<void> updateTag(Tag tag) async {
    final db = await DatabaseHelper.instance.database;
    await db.update('tags', tag.toMap(), where: 'id = ?', whereArgs: [tag.id]);

    final index = _tags.indexWhere((t) => t.id == tag.id);
    if (index != -1) {
      _tags[index] = tag;
      notifyListeners();
    }
  }

  Future<void> deleteTag(String id) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete('tags', where: 'id = ?', whereArgs: [id]);

    _tags.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  Tag? getTagById(String id) {
    try {
      return _tags.firstWhere((t) => t.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Tag> getTagsByIds(List<String> ids) {
    return _tags.where((t) => ids.contains(t.id)).toList();
  }
}
