import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ecom/common/shared_pref.dart';
import 'package:flutter_ecom/models/product_model.dart';
import 'package:http/http.dart' as http;

import '../common/common.dart';
import '../models/cart_model.dart';

class CartService {
  final sharedPref = SharedPref();

  Future<List<CartModel>> fetchCart() async {
    try {
      final userId = await sharedPref.getUid();
      if (userId == null) {
        throw Exception("User ID is null");
      }

      final response =
          await http.post(Uri.parse('$baseUrl/users/getcart?userid=$userId'));
      debugPrint(response.body.toString());
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        final productsData = decodedData["response"];
        debugPrint("the products data is :$productsData");
        if (productsData is List) {
          return productsData
              .map((item) {
                try {
                  if (item == null || item['_id'] == null) {
                    debugPrint('Invalid item data: $item');
                    return null;
                  }
                  // If the item contains cart-specific data
                  if (item.containsKey('quantity')) {
                    return CartModel(
                      id: item['_id'],
                      items: Items.fromMap(item),
                      quantity: item['quantity'],
                      orderStatus: item['orderStatus']
                    );
                  }
                  // If the item is just a product
                  else {
                    return CartModel(
                      id: item['_id'],
                      items: Items.fromMap(item),
                      quantity: 1,
                      orderStatus: "No order"
                    );
                  }
                } catch (e) {
                  debugPrint('Failed to convert item to CartModel: $e');
                  return null;
                }
              })
              .whereType<CartModel>()
              .toList();
        } else {
          throw Exception("No Data: productsData is not a List");
        }
      } else {
        throw Exception("Response failed with code ${response.statusCode}");
      }
    } catch (e) {
      throw Exception('Failed to Load data: $e');
    }
  }

  Future<void> add(productId) async {
    final userId = await sharedPref.getUid();

    try {
      final response = await http.post(
          Uri.parse('$baseUrl/users/addtocart?id=$productId&userid=$userId'));

      if (response.statusCode == 200) {
        debugPrint(response.body.toString());
      } else {
        throw Exception("Response failed with code ${response.statusCode}");
      }
    } catch (e) {
      throw Exception('Failed to Load data: $e');
    }
  }

  Future<void> remove(productId) async {
    final userId = await sharedPref.getUid();

    try {
      final response = await http.post(
          Uri.parse('$baseUrl/users/removecart?id=$productId&userid=$userId'));

      if (response.statusCode == 200) {
        debugPrint(response.body.toString());
      } else {
        throw Exception("Response failed with code ${response.statusCode}");
      }
    } catch (e) {
      throw Exception('Failed to Load data: $e');
    }
  }
}
