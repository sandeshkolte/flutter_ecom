// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_ecom/models/product_model.dart';

class CartModel {
  final String id;
  // static List<Items>? products = [];
  Items items;
  int quantity;
  String orderStatus;
  CartModel({
    required this.id,
    required this.items,
    required this.quantity,
    required this.orderStatus,
  });

  CartModel copyWith({
    String? id,
    Items? items,
    int? quantity,
    String? orderStatus,
  }) {
    return CartModel(
      id: id ?? this.id,
      items: items ?? this.items,
      quantity: quantity ?? this.quantity,
      orderStatus: orderStatus ?? this.orderStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'items': items.toMap(),
      'quantity': quantity,
      'orderStatus': orderStatus,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'] as String,
      items: Items.fromMap(map['items'] as Map<String,dynamic>),
      quantity: map['quantity'] as int,
      orderStatus: map['orderStatus'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CartModel(id: $id, items: $items, quantity: $quantity, orderStatus: $orderStatus)';
  }

  @override
  bool operator ==(covariant CartModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.items == items &&
      other.quantity == quantity &&
      other.orderStatus == orderStatus;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      items.hashCode ^
      quantity.hashCode ^
      orderStatus.hashCode;
  }
}
