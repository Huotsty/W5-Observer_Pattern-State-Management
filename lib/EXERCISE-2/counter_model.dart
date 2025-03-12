import 'package:flutter/material.dart';

class CounterModel extends ChangeNotifier {
  int _redTapCount = 0;
  int _blueTapCount = 0;
  int get redTapCount => _redTapCount;
  int get blueTapCount => _blueTapCount;

  void incrementRedTap() {
    _redTapCount++;
    notifyListeners();
  }

  void incrementBlueTap() {
    _blueTapCount++;
    notifyListeners();
  }
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}