import 'cart_item.dart';

class OrderItem {
  final String? id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  int get productCount {
    return products.length;
  }

  OrderItem({
    this.id,
    required this.amount,
    required this.products,
    DateTime? dateTime,
  }) : dateTime = dateTime ?? DateTime.now();

  OrderItem copyWith({
    String? id,
    double? amount,
    List<CartItem>? products,
    DateTime? dateTime,
  }) {
    return OrderItem(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      products: products ?? this.products,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> productJson = [];
    products.forEach((element) {
      productJson.add(element.toJsonCart());
    });
    return {
      'amount': amount,
      'dateTime': dateTime.toString(),
      'products': productJson,
    };
  }

  static OrderItem fromJson(Map<String, dynamic> json) {
    List<CartItem> products = [];
    json['products'].forEach((element) {
      products.add(CartItem.fromJsonCart(element));
    });
    return OrderItem(
      id: json['id'],
      amount: json['amount'],
      dateTime: DateTime.parse(json['dateTime']),
      products: products,
    );
  }
}
