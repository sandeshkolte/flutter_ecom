import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

// class ProductModel {
//   static List<Items>? items = []; // Ensure it is not null

//   // Get item by id
//   Items? getById(String id) => items?.firstWhere((element) => element.id == id);

//   // Get item by position
//   Items getByPosition(int pos) => items![pos];
// }

class Items {
  final String id;
  final String image;
  final String name;
  final num price;
  final String description;
  final num discount;
  final num stock;
  final String seller;
  final String category;
  final String orderStatus;

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
    required this.orderStatus,
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
    String? orderStatus,
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
      orderStatus: orderStatus ?? this.orderStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'image': image,
      'name': name,
      'description': description,
      'price': price,
      'discount': discount,
      'stock': stock,
      'seller': seller,
      'category': category,
      'orderStatus': orderStatus,
    };
  }

  factory Items.fromMap(Map<String, dynamic> map) {
    return Items(
      id: map['_id'] as String,
      image: map['image'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as num,
      discount: map['discount'] as num,
      stock: map['stock'] as num,
      seller: map['seller'] as String,
      category: map['category'] as String,
      orderStatus: map['orderStatus'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Items.fromJson(String source) =>
      Items.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Items(id: $id, image: $image, name: $name, description: $description, price: $price, discount: $discount, stock: $stock, seller: $seller, category: $category, orderStatus: $orderStatus)';
  }

  @override
  bool operator ==(covariant Items other) {
    if (identical(this, other)) return true;

    return
      other.id == id &&
      other.image == image &&
      other.name == name &&
      other.description == description &&
      other.price == price &&
      other.discount == discount &&
      other.stock == stock &&
      other.seller == seller &&
      other.category == category &&
      other.orderStatus == orderStatus;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      image.hashCode ^
      name.hashCode ^
      description.hashCode ^
      price.hashCode ^
      discount.hashCode ^
      stock.hashCode ^
      seller.hashCode ^
      category.hashCode ^
      orderStatus.hashCode;
  }
}
