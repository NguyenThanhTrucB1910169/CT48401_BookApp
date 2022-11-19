// import 'package:flutter/foundation.dart';

// import '../../models/cart_item.dart';
// import '../../models/order_item.dart';

// class OrderManager with ChangeNotifier {
//   final List<OrderItem> _orders = [];

//   int get orderCount {
//     return _orders.length;
//   }

//   List<OrderItem> get orders {
//     return [..._orders];
//   }

//   void addOrder(List<CartItem> cartProducts, double total) async {
//     _orders.insert(
//       0,
//       OrderItem(
//           id: 'o${DateTime.now().toIso8601String()}',
//           amount: total,
//           products: cartProducts,
//           dateTime: DateTime.now()),
//     );
//     notifyListeners();
//   }
// }

import 'package:flutter/foundation.dart';

import '../../models/auth_token.dart';
import '../../models/book.dart';
import '../../models/cart_item.dart';
import '../../models/order_item.dart';
import '../../services/order_service.dart';
import '../../services/products_service.dart';

class OrderManager with ChangeNotifier {
  List<OrderItem> _orders = [];
  final List<CartItem> _books = [];
  final OrdersService _ordersService;

  OrderManager([AuthToken? authToken])
      : _ordersService = OrdersService(authToken);

  set authToken(AuthToken? authToken) {
    _ordersService.authToken = authToken;
  }

  int get orderCount {
    return _orders.length;
  }

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) async {
    OrderItem order = OrderItem(
        id: 'o${DateTime.now().toIso8601String()}',
        amount: total,
        products: cartProducts,
        dateTime: DateTime.now());
    final newOrder = await _ordersService.addOrder(order);
    // if (newOrder != null) {
    //   _orders.add(newOrder);
    //   notifyListeners();
    // }
  }

  Future<void> fetchOrders(filterByUser) async {
    _orders = await _ordersService.fetchOrders(filterByUser);
    // print(_orders);
    notifyListeners();
  }

  // bool isAdmin (){

  // }
}

 
// void addOrder(List<CartItem> cartProducts, double total) async {
//   _orders.insert(
//     0,
//     OrderItem(
//         id: 'o${DateTime.now().toIso8601String()}',
//         amount: total,
//         products: cartProducts,
//         dateTime: DateTime.now()),
//   );
//   notifyListeners();
// }