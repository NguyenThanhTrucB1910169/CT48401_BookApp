import 'dart:convert';
// import 'package:book_app/models/cart_item.dart';
import 'package:http/http.dart' as http;

import '../models/cart_item.dart';
import '../models/auth_token.dart';

import 'firebase_service.dart';

class CartService extends FirebaseService {
  CartService([AuthToken? authToken]) : super(authToken);

  Future<List<CartItem>> fetchCarts() async {
    List<CartItem> carts = [];
    try {
      // final filters =
      //     filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
      final cartUrl = Uri.parse('$databaseUrl/cart/$userId.json?auth=$token');
      final response = await http.get(cartUrl);
      final cartMap = json.decode(response.body) as Map<String, dynamic>;
      // print(productsMap);
      if (response.statusCode != 200) {
        print(cartMap['error']);
        return carts;
      }

      cartMap.forEach((cartId, cart) {
        carts.add(CartItem.fromJsonCart({
          'id': cartId,
          ...cart,
        }));
      });
      // print(products);
      return carts;
    } catch (error) {
      print(error);
      return carts;
    }
  }

  Future<CartItem?> addCart(CartItem cart) async {
    try {
      final url = Uri.parse('$databaseUrl/cart/$userId.json?auth=$token');
      final response =
          await http.post(url, body: json.encode(cart.toJsonCart()));

      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<bool> updateCart(CartItem cart) async {
    try {
      final url = Uri.parse('$databaseUrl/cart/$userId.json?auth=$token');
      final response = await http.patch(
        url,
        body: json.encode(cart.toJsonCart()),
      );
      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }

      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> deleteProduct(String id) async {
    try {
      final url = Uri.parse('$databaseUrl/products/$id.json?auth=$token');
      final response = await http.delete(url);
      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }

      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
