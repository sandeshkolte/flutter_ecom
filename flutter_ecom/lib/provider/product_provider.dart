import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ecom/common/common.dart';
import 'package:flutter_ecom/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  // late Items product;

  List<Items> _items = [];

  List<Items> get items => _items;

  ProductProvider() {
    fetchProduct();
  }

  Future<void> fetchProduct() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products'));
      debugPrint(response.body.toString());
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        final productsData = decodedData["response"];
        if (productsData is List) {
          _items =
              productsData.map<Items>((item) => Items.fromMap(item)).toList();
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
}
