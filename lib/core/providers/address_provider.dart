import 'package:flutter/material.dart';

class AddressProvider extends ChangeNotifier {
  Map<String, String> _address = {};
  Map<String, String> get address => _address;

  void setAddress(
      String street, String locality, String country, String region) {
    _address = {
      "street": street,
      "locality": locality,
      "country": country,
      "region": region
    };
    notifyListeners();
  }
}
