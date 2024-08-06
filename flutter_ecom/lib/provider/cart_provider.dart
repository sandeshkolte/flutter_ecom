import 'package:flutter/material.dart';
import 'package:flutter_ecom/common/shared_pref.dart';
import 'package:flutter_ecom/models/cart_model.dart';
import 'package:flutter_ecom/models/product_model.dart';
import '../repository/cart_services.dart';

class CartProvider extends ChangeNotifier {
  late Items product;

  List<CartModel> _shoppingCart = [];

  List<CartModel> get shoppingCart => _shoppingCart;

  final sharedPref = SharedPref();

  final CartService _cartService = CartService();

  bool isCartFetched = false;
  Future<void>? _fetchCartFuture;

  Future<void> get fetchCartFuture {
    return _fetchCartFuture ??= fetchCart();
  }

  Future<void> fetchCart() async {
    _shoppingCart = await _cartService.fetchCart();
    notifyListeners();
  }

  void clearCart() {
    _shoppingCart.clear();
    notifyListeners();
  }

  void addToCart(Items product) async {
    final userId = await sharedPref.getUid();

    var isExist = _shoppingCart.where((elem) => elem.id == product.id);

    if (isExist.isEmpty) {
      _shoppingCart.add(CartModel(
          id: product.id,
          items: product,
          quantity: 1,
          orderStatus: "No order"));

      if (userId != null) {
        await _cartService.add(product.id);
      }
    } else {
      isExist.first.quantity += 1;
    }
    notifyListeners();
  }

  void removeFromCart(String productId) async {
    _shoppingCart.removeWhere((elem) => elem.id == productId);

    final userId = await sharedPref.getUid();

    if (userId != null) {
      await _cartService.remove(productId);
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
