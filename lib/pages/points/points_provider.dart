// lib/pages/points/points_provider.dart
import 'package:flutter/material.dart';

class PointsProvider extends ChangeNotifier {
  int _points = 300;

  // 交換履歴リスト
  final List<Map<String, dynamic>> _history = [];

  int get points => _points;
  List<Map<String, dynamic>> get history => List.unmodifiable(_history);

  void addPoints(int value) {
    _points += value;
    notifyListeners();
  }

  void subtractPoints(int value, String itemName) {
    if (_points >= value) {
      _points -= value;
      _history.add({
        'name': itemName,
        'points': value,
        'date': DateTime.now().toIso8601String().split('T').first,
      });
      notifyListeners();
    }
  }
}
