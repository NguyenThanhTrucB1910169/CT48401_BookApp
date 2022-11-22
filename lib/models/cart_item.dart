import 'package:flutter/foundation.dart';

class CartItem {
  String? id;
  final String idBook;
  final String title;
  final String image;
  ValueNotifier<int> _quantity;
  final double price;

  CartItem({
    required this.id,
    required this.idBook,
    required this.title,
    required this.image,
    required this.price,
    quantity = 1,
  }) : _quantity = ValueNotifier(quantity);

  set quantity(int newValue) {
    _quantity.value = newValue;
  }

  int get quantity {
    return _quantity.value;
  }

  ValueNotifier<int> get quanlityListenable {
    return _quantity;
  }

  CartItem copyWith({
    // String? id,
    String? idBook,
    String? title,
    String? image,
    int? quantity,
    double? price,
  }) {
    return CartItem(
      id: id ?? this.id,
      idBook: idBook ?? this.idBook,
      title: title ?? this.title,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toJsonCart() {
    return {
      // 'id': id,
      'idBook': idBook,
      'title': title,
      'image': image,
      'quantity': quantity,
      'price': price
    };
  }

  static CartItem fromJsonCart(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      idBook: json['idBook'],
      title: json['title'],
      image: json['image'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }
}
