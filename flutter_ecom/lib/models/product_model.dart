import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class ProductModel {
  static List<Items>? items = []; // Ensure it is not null

  // Get item by id
  Items? getById(String id) => items?.firstWhere((element) => element.id == id);

  // Get item by position
  Items getByPosition(int pos) => items![pos];
}

class Items {
  final String id;
  final String image;
  final String name;
  final String description;
  final num price;
  final num discount;
  final num stock;
  final String seller;
  final String category;

  Items({
    required this.id,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.discount,
    required this.stock,
    required this.seller,
    required this.category,
  });

  Items copyWith({
    String? id,
    String? image,
    String? name,
    String? description,
    num? price,
    num? discount,
    num? stock,
    String? seller,
    String? category,
  }) {
    return Items(
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      stock: stock ?? this.stock,
      seller: seller ?? this.seller,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'name': name,
      'description': description,
      'price': price,
      'discount': discount,
      'stock': stock,
      'seller': seller,
      'category': category,
    };
  }

  factory Items.fromMap(Map<String, dynamic> map) {
    return Items(
      id: map['_id'] as String? ?? '',
      image: map['image'] as String? ?? '',
      name: map['name'] as String? ?? '',
      description: map['description'] as String? ?? '',
      price: map['price'] as num? ?? 0,
      discount: map['discount'] as num? ?? 0,
      stock: map['stock'] as num? ?? 0,
      seller: map['seller'] as String? ?? '',
      category: map['category'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Items.fromJson(String source) => Items.fromMap(json.decode(source) as Map<String, dynamic>);
}
