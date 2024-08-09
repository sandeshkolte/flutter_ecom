import 'package:flutter/material.dart';
import 'package:flutter_ecom/common/shared_pref.dart';
import 'package:flutter_ecom/models/cart_model.dart';
import 'package:flutter_ecom/models/product_model.dart';
import 'package:flutter_ecom/repository/order_service.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderProvider extends ChangeNotifier {
  late Items product;

  List<CartModel> _orderList = [];

  List<CartModel> get orderList => _orderList;

  final sharedPref = SharedPref();

  final _orderService = OrderService();

  Future<void>? _fetchOrderFuture;

  Future<void> get fetchOrderFuture {
    return _fetchOrderFuture ??= fetchOrder();
  }

  OrderProvider() {
    fetchOrder();
  }

  Future<void> fetchOrder() async {
    _orderList = await _orderService.fetchOrder();
    notifyListeners();
  }

  void addOrder(CartModel products, context) async {
    final userId = await sharedPref.getUid();
    debugPrint("User ID: $userId");

    var isExist = _orderList.where((elem) => elem.id == products.id);

    if (isExist.isEmpty) {
      _orderList.add(CartModel(
          id: products.id,
          items: products.items,
          quantity: products.quantity,
          orderStatus: "Processing"));
      debugPrint("Product added to order list: ${products.id}");

      if (userId != null) {
        await _orderService.add(products.id);
        debugPrint("Product added to remote service: ${products.id}");
      }
    } else {
      debugPrint("Item already ordered: ${products.id}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: "Item already ordered".text.black.make(),
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
          backgroundColor: Vx.indigo300,
        ),
      );
    }

    notifyListeners();
  }

  void removeOrder(String productId) async {
    _orderList.removeWhere((elem) => elem.id == productId);

    final userId = await sharedPref.getUid();
    debugPrint(userId);

    if (userId != null) {
      await _orderService.remove(productId);
    }

    notifyListeners();
  }
}
