import 'dart:convert';

import 'package:collection/collection.dart';

class CreatedUser {
  String? username;
  String? email;
  String? password;
  List<dynamic>? cart;
  List<dynamic>? orders;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  CreatedUser({
    this.username,
    this.email,
    this.password,
    this.cart,
    this.orders,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory CreatedUser.fromMap(Map<String, dynamic> data) => CreatedUser(
        username: data['username'] as String?,
        email: data['email'] as String?,
        password: data['password'] as String?,
        cart: data['cart'] as List<dynamic>?,
        orders: data['orders'] as List<dynamic>?,
        id: data['_id'] as String?,
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
        v: data['__v'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'username': username,
        'email': email,
        'password': password,
        'cart': cart,
        'orders': orders,
        '_id': id,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CreatedUser].
  factory CreatedUser.fromJson(String data) {
    return CreatedUser.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CreatedUser] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CreatedUser) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      username.hashCode ^
      email.hashCode ^
      password.hashCode ^
      cart.hashCode ^
      orders.hashCode ^
      id.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      v.hashCode;
}
