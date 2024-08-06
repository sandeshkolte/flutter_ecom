import 'package:flutter/material.dart';

import '../models/product_model.dart';

class WishListProvider with ChangeNotifier {
  final List<Items> _wishList = [];
  List<Items> get wishList => _wishList;

  addToList(Items item) {
    wishList.add(item);
    notifyListeners();
  }

  removeList(Items item) {
    wishList.remove(item);
    notifyListeners();
  }
}
