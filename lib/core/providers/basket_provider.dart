import 'package:flutter/material.dart';

class BasketProvider extends ChangeNotifier {
  List<Map<String, String>> _basketData = [];
  List<Map<String, String>> get address => _basketData;

  void setBasketData(List<Map<String, String>> data) {
    _basketData = data;
    notifyListeners();
  }
}
