import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  int bottomIndex = 0;
  void setIndex(int i) {
    bottomIndex = i;
    notifyListeners();
  }
}
