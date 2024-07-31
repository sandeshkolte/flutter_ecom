// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_ecom/models/product_model.dart';

class CartModel {
  final String id;
  static List<Items>? products = []; 
  Items items;
  int quantity;
  CartModel({
    required this.id,
    required this.items,
    required this.quantity,
  });
}
