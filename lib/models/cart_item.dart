import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final String image;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.image,
    required this.quantity,
    required this.price,
  });

  CartItem copyWith({
    String? id,
    String? title,
    String? image,
    int? quantity,
    double? price,
  }) {
    return CartItem(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toJsonCart() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'quantity': quantity,
      'price': price
    };
  }

  // void set changeQuatity(int newQuatity) {
  //   quantity.value = newQuatity;
  // }

  // int get newQuatity {
  //   return quantity.value;
  // }

  static CartItem fromJsonCart(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }
}
