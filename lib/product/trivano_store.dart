import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrivanoStore extends ChangeNotifier {
  List<dynamic> items = [];

  Future<void> load(String jsonStr) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('trivano_items')) {
      items = jsonDecode(jsonStr)['items'] ?? [];
      await save();
    } else {
      items = jsonDecode(prefs.getString('trivano_items')!);
    }
    notifyListeners();
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('trivano_items', jsonEncode(items));
  }
}
