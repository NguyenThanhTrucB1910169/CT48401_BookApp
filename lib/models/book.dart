import 'package:flutter/foundation.dart';

class Book {
  final String? id;
  final String title;
  final String description;
  final double price;
  final String author;
  final String image;
  ValueNotifier<bool> _isFavorite;

  Book({
    this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.author,
    required this.image,
    isFavorite = false,
  }) : _isFavorite = ValueNotifier(isFavorite);

  set isFavorite(bool newValue) {
    _isFavorite.value = newValue;
  }

  bool get isFavorite {
    return _isFavorite.value;
  }

  ValueNotifier<bool> get isFavoriteListenable {
    return _isFavorite;
  }

  Book copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    String? author,
    String? image,
    bool? isFavorite,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      author: author ?? this.author,
      image: image ?? this.image,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'image': image,
      'author': author,
    };
  }

  static Book fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
      author: json['author'],
    );
  }
}
