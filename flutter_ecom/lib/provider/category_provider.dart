import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../common/common.dart';
import '../models/product_model.dart';

class CategoryProvider with ChangeNotifier {
  List<Items> _items = [];

  List<Items> get items => _items;

  Future<void> findbyCategory(String category) async {
    try {
      final response = await http
          .post(Uri.parse('$baseUrl/products/findproduct?category=$category'));
      debugPrint(response.body.toString());

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        final productsData = decodedData["response"];
        debugPrint("The Products: $productsData");
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
