import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:flutter_ecom/models/cart_model.dart';

class User {
  String id;
  String username;
  String email;
  List<CartModel> cart;
  List<CartModel> orders;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.cart,
    required this.orders,
  });

  User copyWith({
    String? id,
    String? username,
    String? email,
    List<CartModel>? cart,
    List<CartModel>? orders,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      cart: cart ?? this.cart,
      orders: orders ?? this.orders,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'cart': cart.map((x) => x.toMap()).toList(),
      'orders': orders.map((x) => x.toMap()).toList(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      cart: List<CartModel>.from(
        (map['cart'] as List<dynamic>).map<CartModel>(
          (x) => CartModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      orders: List<CartModel>.from(
        (map['orders'] as List<dynamic>).map<CartModel>(
          (x) => CartModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, username: $username, email: $email, cart: $cart, orders: $orders)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.username == username &&
        other.email == email &&
        listEquals(other.cart, cart) &&
        listEquals(other.orders, orders);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        email.hashCode ^
        cart.hashCode ^
        orders.hashCode;
  }
}
