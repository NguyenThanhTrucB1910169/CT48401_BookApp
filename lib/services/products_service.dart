import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/book.dart';
import '../models/auth_token.dart';

import 'firebase_service.dart';

class ProductsService extends FirebaseService {
  ProductsService([AuthToken? authToken]) : super(authToken);

  Future<List<Book>> fetchProducts() async {
    final List<Book> products = [];
    try {
      // final filters =
      //     filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
      final productsUrl = Uri.parse('$databaseUrl/products.json?auth=$token');
      final response = await http.get(productsUrl);
      final productsMap = json.decode(response.body) as Map<String, dynamic>;
      // print(productsMap);
      if (response.statusCode != 200) {
        print(productsMap['error']);
        return products;
      }

      final userFavoritesUrl =
          Uri.parse('$databaseUrl/userFavorites/$userId.json?auth=$token');
      final userFavoritesResponse = await http.get(userFavoritesUrl);
      final userFavoritesMap = json.decode(userFavoritesResponse.body);

      productsMap.forEach((productId, product) {
        final isFavorite = (userFavoritesMap == null)
            ? false
            : (userFavoritesMap[productId] ?? false);
        products.add(Book.fromJson({
          'id': productId,
          ...product,
        }).copyWith(isFavorite: isFavorite));
      });
      // print(products);
      return products;
    } catch (error) {
      print(error);
      return products;
    }
  }

  Future<Book?> addProduct(Book product) async {
    try {
      final url = Uri.parse('$databaseUrl/products.json?auth=$token');
      final response = await http.post(
        url,
        body: json.encode(
          product.toJson()
            ..addAll({
              'creatorId': userId,
            }),
        ),
      );

      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }

      return product.copyWith(
        id: json.decode(response.body)['name'],
      );
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<bool> updateProduct(Book product) async {
    try {
      final url =
          Uri.parse('$databaseUrl/products/${product.id}.json?auth=$token');
      final response = await http.patch(
        url,
        body: json.encode(product.toJson()),
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

  Future<bool> saveFavoriteStatus(Book product) async {
    try {
      final url = Uri.parse(
          '$databaseUrl/userFavorites/$userId/${product.id}.json?auth=$token');
      final response = await http.put(
        url,
        body: json.encode(
          product.isFavorite,
        ),
      );

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
