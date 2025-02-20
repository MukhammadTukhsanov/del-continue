import 'package:flutter/material.dart';

class MarketsProvider extends ChangeNotifier {
  final List<Map<String, String>> _markets = [];
  List<Map<String, String>> get markets => _markets;

  void setMarketsList(
      String name,
      String rating,
      String ratingCount,
      String minOrder,
      String minDeliveryTime,
      String maxDeliveryTime,
      String deliveryPrice,
      String deliveryAfterFree,
      String photoUrl) {
    _markets.add({
      "name": name,
      "rating": rating,
      "ratingCount": ratingCount,
      "minOrder": minOrder,
      "minDeliveryTime": minDeliveryTime,
      "maxDeliveryTime": maxDeliveryTime,
      "deliveryPrice": deliveryPrice,
      "deliveryAfterFree": deliveryAfterFree,
      "photoUrl": photoUrl
    });
    notifyListeners();
  }

  void clearMarkets() {
    _markets.clear();
    notifyListeners();
  }
}
