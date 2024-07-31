import 'package:flutter/material.dart';
import 'package:flutter_ecom/common/common.dart';
import 'package:flutter_ecom/common/shared_pref.dart';
import 'package:flutter_ecom/models/cart_model.dart';
// import 'package:flutter_ecom/models/order_model.dart';
import 'package:flutter_ecom/models/product_model.dart';
import 'package:http/http.dart' as http;

class OrderProvider extends ChangeNotifier {
  late Items product;

  final List<CartModel> _orderList = [];

  List<CartModel> get orderList => _orderList;

  final sharedPref = SharedPref();

  Future<void> add(productId) async {
    final userId = await sharedPref.getUid();

    try {
      final response = await http.post(
          Uri.parse('$baseUrl/users/addorder?id=$productId&userid=$userId'));

      if (response.statusCode == 200) {
        debugPrint(response.body.toString());
        updateOrderStatus(productId);
      } else {
        debugPrint("Response failed with code ${response.statusCode}");
      }
    } catch (e) {
      debugPrint('Failed to Load data: $e');
    }
  }

  Future<void> updateOrderStatus(productId) async {
    final userId = await sharedPref.getUid();

    try {
      final response = await http.post(
          Uri.parse('$baseUrl/users/updateorder?orderId=$productId&userId=$userId'));

      if (response.statusCode == 200) {
        debugPrint(response.body.toString());
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
          Uri.parse('$baseUrl/users/removeorder?id=$productId&userid=$userId'));

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

  void addOrder(Items product) async {
    final userId = await sharedPref.getUid();
    debugPrint(userId);

    var isExist = _orderList.where((elem) => elem.id == product.id);

    if (isExist.isEmpty) {
      _orderList.add(CartModel(id: product.id, items: product, quantity: 1));

      if (userId != null) {
      await  add(product.id);
      }
    } else {
      isExist.first.quantity += 1;
    }

    notifyListeners();
  }

  void removeOrder(String productId) async {
    _orderList.removeWhere((elem) => elem.id == productId);

    final userId = await sharedPref.getUid();
    debugPrint(userId);

    if (userId != null) {
      remove(productId);
    }

    notifyListeners();
  }
}
