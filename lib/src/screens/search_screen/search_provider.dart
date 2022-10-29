import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {
  String _queryString = '';

  String get queryString => _queryString;

  void updateQueryString(String queryString) {
    _queryString = queryString;
    notifyListeners();
  }
}
