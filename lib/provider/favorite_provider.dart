import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  List<String> _favorites = [];
  List<String> get favorites => _favorites;

  void toggleFavorite(String bookTitle) {
    final isExist = _favorites.contains(bookTitle);
    if (isExist) {
      _favorites.remove(bookTitle);
    } else {
      _favorites.add(bookTitle);
    }
    notifyListeners();
  }

  bool isExist(String bookTitle) {
    final isExist = _favorites.contains(bookTitle);
    return isExist;
  }

  void clearFavorite() {
    _favorites = [];
    notifyListeners();
  }
}
