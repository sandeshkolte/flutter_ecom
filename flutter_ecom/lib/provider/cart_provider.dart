import 'package:flutter/material.dart';
import 'package:flutter_ecom/models/cart_model.dart';
import 'package:flutter_ecom/models/product_model.dart';

class CartProvider extends ChangeNotifier {
  late Items product;

  final List<CartModel> _shoppingCart = [];

  List<CartModel> get shoppingCart => _shoppingCart;

  void addToCart(Items product) {
    var isExist = _shoppingCart.where((elem) => elem.id == product.id);

    if (isExist.isEmpty) {
      _shoppingCart
          .add(CartModel(id: product.id, items: product, quantity: 1));
    } else {
      isExist.first.quantity += 1;
    }

    notifyListeners();
  }

  void removeFromCart(String productId) {
    _shoppingCart.removeWhere((elem) => elem.id == productId);

    notifyListeners();
  }

  void incrementQty(String productId) {
    CartModel item = _shoppingCart.where((elem) => elem.id == productId).first;
    if(item.quantity< item.items.stock) {
      item.quantity++;
      notifyListeners();
    }
  }

  void decrementQty(String productId) {
    CartModel item = _shoppingCart.where((elem) => elem.id == productId).first;
    if(item.quantity>1) {
      item.quantity--;
      notifyListeners();
    }
  }

  double getCartTotal() {
    double total = 0;

    for (var cartItem in _shoppingCart) {
      total += (cartItem.items.price - cartItem.items.discount) * cartItem.quantity;
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
