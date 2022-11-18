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
    return {
      'amount': amount.toString(),
      'dateTime': dateTime.toString(),
      'products': products.toString()
    };
  }

  static OrderItem fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      amount: json['amount'],
      products: json['products'],
      dateTime: json['dateTime'],
    );
  }
}
