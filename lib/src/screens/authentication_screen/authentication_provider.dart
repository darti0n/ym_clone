import 'package:flutter/foundation.dart';

class AuthenticationProvider with ChangeNotifier {
  String _apiKey = '';

  String get apiKey => _apiKey;

  void updateApiKey(String apiKey) {
    _apiKey = apiKey.trim();
    notifyListeners();
  }
}
