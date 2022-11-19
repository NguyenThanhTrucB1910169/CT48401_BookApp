import 'dart:convert';
import 'package:book_app/models/order_item.dart';
import 'package:http/http.dart' as http;

import '../models/book.dart';
import '../models/auth_token.dart';

import '../models/cart_item.dart';
import 'firebase_service.dart';

class OrdersService extends FirebaseService {
  OrdersService([AuthToken? authToken]) : super(authToken);

  Future<List<OrderItem>> fetchOrders(filterUser) async {
    // print(userId);
    List<OrderItem> orders = [];
    try {
      final filters = filterUser ? '' : 'orderBy="creatorId"&equalTo="$userId"';
      final ordersUrl =
          Uri.parse('$databaseUrl/orders.json?auth=$token&$filters');
      final response = await http.get(ordersUrl);
      final ordersMap = json.decode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 200) {
        print(ordersMap['error']);
        return orders;
      }
      // print(ordersMap.length);
      ordersMap.forEach((orderId, order) {
        orders.add(OrderItem.fromJson({
          'id': orderId,
          ...order,
        }));
      });
      // print(products);
      return orders;
    } catch (error) {
      print(error);
      return orders;
    }
  }

  Future<OrderItem?> addOrder(OrderItem order) async {
    try {
      final url = Uri.parse('$databaseUrl/orders.json?auth=$token');
      // print(userId);
      final response = await http.post(
        url,
        body: json.encode(
          order.toJson()
            ..addAll({
              'creatorId': userId,
            }),
        ),
      );

      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }
      // print('2222');
      return order.copyWith(
          // id: 'o${DateTime.now().toIso8601String()}',
          );
    } catch (error) {
      print(error);
      return null;
    }
  }
}
