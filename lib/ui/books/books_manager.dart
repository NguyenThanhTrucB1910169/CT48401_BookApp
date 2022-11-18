import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import '../../models/book.dart';
import '../../services/products_service.dart';
import '../../models/auth_token.dart';

class BooksManager with ChangeNotifier {
  List<Book> _items = [];

  final ProductsService _productsService;

  BooksManager([AuthToken? authToken])
      : _productsService = ProductsService(authToken);

  set authToken(AuthToken? authToken) {
    _productsService.authToken = authToken;
  }

  Future<void> fetchProducts() async {
    _items = await _productsService.fetchProducts();
    notifyListeners();
  }

  Future<void> addProduct(Book book) async {
    final newProduct = await _productsService.addProduct(book);
    if (newProduct != null) {
      _items.add(newProduct);
      notifyListeners();
    }
  }

  int get itemCount {
    return _items.length;
  }

  List<Book> get items {
    return [..._items];
  }

  List<Book> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Book findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> updateProduct(Book product) async {
    final index = _items.indexWhere((item) => item.id == product.id);
    if (index >= 0) {
      if (await _productsService.updateProduct(product)) {
        _items[index] = product;
        notifyListeners();
      }
    }
  }

  Future<void> deleteProduct(String id) async {
    final index = _items.indexWhere((item) => item.id == id);
    Book? existingProduct = _items[index];
    _items.removeAt(index);
    notifyListeners();

    if (!await _productsService.deleteProduct(id)) {
      _items.insert(index, existingProduct);
      notifyListeners();
    }
  }

  Future<void> toggleFavoriteStatus(Book product) async {
    final savedStatus = product.isFavorite;
    product.isFavorite = !savedStatus;

    if (!await _productsService.saveFavoriteStatus(product)) {
      product.isFavorite = savedStatus;
    }
  }
}
