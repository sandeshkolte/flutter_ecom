import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ecom/common/shared_pref.dart';
import 'package:flutter_ecom/models/cart_model.dart';
import 'package:flutter_ecom/models/product_model.dart';
import 'package:http/http.dart' as http;
import '../common/common.dart';

class CartProvider extends ChangeNotifier {
  late Items product;

  List<CartModel> _shoppingCart = [];

  List<CartModel> get shoppingCart => _shoppingCart;

  final sharedPref = SharedPref();

  Future<void> fetchCart() async {
    try {
      final userId = await sharedPref.getUid();

      final response =
          await http.post(Uri.parse('$baseUrl/users/getcart?userid=$userId'));
      debugPrint(response.body.toString());
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        final productsData = decodedData["response"];
        if (productsData is List) {
          _shoppingCart = productsData
              .map(
                  (item) => CartModel(id: item['id'], items: item, quantity: 0))
              .toList();
        } else {
          debugPrint("No Data: productsData is not a List");
        }
      } else {
        debugPrint("Response failed with code ${response.statusCode}");
      }
    } catch (e) {
      debugPrint('Failed to Load data: $e');
    }
  }

  Future<void> add(productId) async {
    final userId = await sharedPref.getUid();

    try {
      final response = await http.post(
          Uri.parse('$baseUrl/users/addtocart?id=$productId&userid=$userId'));

      if (response.statusCode == 200) {
        debugPrint(response.body.toString());
        // final decodedData = jsonDecode(response.body);
        // final productsData = decodedData["response"];
        // if (productsData is List) {
        //   ProductModel.items =
        //       productsData.map<Items>((item) => Items.fromMap(item)).toList();
        // } else {
        //   debugPrint("No Data: productsData is not a List");
        // }
      } else {
        debugPrint("Response failed with code ${response.statusCode}");
      }
    } catch (e) {
      debugPrint('Failed to Load data: $e');
    }
  }

  Future<void> remove(productId) async {
    final userId = await sharedPref.getUid();

    try {
      final response = await http.post(
          Uri.parse('$baseUrl/users/removecart?id=$productId&userid=$userId'));

      if (response.statusCode == 200) {
        debugPrint(response.body.toString());
        // final decodedData = jsonDecode(response.body);
        // final productsData = decodedData["response"];
        // if (productsData is List) {
        //   ProductModel.items =
        //       productsData.map<Items>((item) => Items.fromMap(item)).toList();
        // } else {
        //   debugPrint("No Data: productsData is not a List");
        // }
      } else {
        debugPrint("Response failed with code ${response.statusCode}");
      }
    } catch (e) {
      debugPrint('Failed to Load data: $e');
    }
  }

  void addToCart(Items product) async {
    final userId = await sharedPref.getUid();
    debugPrint(userId);

    var isExist = _shoppingCart.where((elem) => elem.id == product.id);

    if (isExist.isEmpty) {
      _shoppingCart.add(CartModel(id: product.id, items: product, quantity: 1));

      if (userId != null) {
        add(product.id);
      }
    } else {
      isExist.first.quantity += 1;
    }

    notifyListeners();
  }

  void removeFromCart(String productId) async {
    _shoppingCart.removeWhere((elem) => elem.id == productId);

    final userId = await sharedPref.getUid();
    debugPrint(userId);

    if (userId != null) {
      remove(productId);
    }

    notifyListeners();
  }

  void incrementQty(String productId) {
    CartModel item = _shoppingCart.where((elem) => elem.id == productId).first;
    if (item.quantity < item.items.stock) {
      item.quantity++;
      notifyListeners();
    }
  }

  void decrementQty(String productId) {
    CartModel item = _shoppingCart.where((elem) => elem.id == productId).first;
    if (item.quantity > 1) {
      item.quantity--;
      notifyListeners();
    }
  }

  double getCartTotal() {
    double total = 0;

    for (var cartItem in _shoppingCart) {
      total +=
          (cartItem.items.price - cartItem.items.discount) * cartItem.quantity;
    }
    return total;
  }

  double getCartDiscount() {
    double total = 0;

    for (var cartItem in _shoppingCart) {
      total += cartItem.items.discount * cartItem.quantity;
    }
    return total;
  }

  double get cartSubtotal => getCartTotal();
  double get cartDiscount => getCartDiscount();
  double get shippingCharge => 100;
  double get cartTotal => cartSubtotal + shippingCharge;
}
