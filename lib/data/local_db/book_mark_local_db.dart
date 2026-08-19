import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

/// Raw Hive access for bookmarks. Stores each article as a JSON string,
/// keyed by its `url` (falls back to `title` if url is missing).
class BookmarkLocalDataSource {
  static const String boxName = 'bookmarks_box';

  Box<String>? _box;

  Future<Box<String>> _openBox() async {
    _box ??= await Hive.openBox<String>(boxName);
    return _box!;
  }

  Future<Map<String, dynamic>> _getAllRaw() async {
    final box = await _openBox();
    return {
      for (final key in box.keys) key: jsonDecode(box.get(key)!),
    };
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    final raw = await _getAllRaw();
    return raw.values.cast<Map<String, dynamic>>().toList();
  }

  Future<void> save(String key, Map<String, dynamic> articleJson) async {
    final box = await _openBox();
    await box.put(key, jsonEncode(articleJson));
  }

  Future<void> remove(String key) async {
    final box = await _openBox();
    await box.delete(key);
  }

  Future<bool> contains(String key) async {
    final box = await _openBox();
    return box.containsKey(key);
  }
}