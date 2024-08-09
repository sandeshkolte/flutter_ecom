import 'package:flutter/material.dart';
import '../models/product_model.dart';

class WishListProvider with ChangeNotifier {
  final List<Items> _wishList = [];
  List<Items> get wishList => _wishList;

  // WishListProvider(){

  // }

  addToList(Items item) {
    debugPrint("${item.name} added");
    wishList.add(item);
    notifyListeners();
  }

  removeList(Items item) {
    debugPrint("${item.name} removed");
    wishList.remove(item);
    notifyListeners();
  }
}
