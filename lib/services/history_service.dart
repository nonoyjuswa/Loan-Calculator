import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/loan_record.dart';

class HistoryService {
  static const _key = 'loan_history';

  static Future<List<LoanRecord>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_key) ?? [];
    return raw.map((s) => LoanRecord.fromJson(jsonDecode(s))).toList();
  }

  // Newest first
  static Future<void> add(LoanRecord record) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_key) ?? [];
    raw.insert(0, jsonEncode(record.toJson()));
    await prefs.setStringList(_key, raw);
  }

  static Future<void> removeAt(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_key) ?? [];
    if (index < raw.length) raw.removeAt(index);
    await prefs.setStringList(_key, raw);
  }
}