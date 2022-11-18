import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import '../shared/screens.dart';
import '../../models/cart_item.dart';
import '../../models/book.dart';
import '../../services/cart_service.dart';
import '../../models/auth_token.dart';

class CartManager with ChangeNotifier {
  Map<String, CartItem> _items = {
    // 'p1': CartItem(
    //   id: 'c1',
    //   title: 'Sự Im Lặng Của Bầy Cừu',
    //   image: 'assets/image/book_1.jpg',
    //   price: 100.8,
    //   quantity: 2,
    // ),
  };
  List<String> _idproducts = [];

  int get productCount {
    return _items.length;
  }

  List<CartItem> get products {
    return _items.values.toList();
  }

  List<String> get idproducts {
    return _idproducts;
  }

  Iterable<MapEntry<String, CartItem>> get productEntries {
    return {..._items}.entries;
  }

  // Iterable<MapEntry<String, CartItem>> get productEntries {
  //   return {..._items};
  // }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  // Future<void> fetchCart() async {
  //   _items = await _cartService.fetchCarts();
  //   notifyListeners();
  // }

  void addItem(Book book) {
    if (_items.containsKey(book.id)) {
      _items.update(
          book.id!,
          (existingCartItem) => existingCartItem.copyWith(
                quantity: existingCartItem.quantity + 1,
              ));
    } else {
      _idproducts.add(
        book.id!,
      );
      _items.putIfAbsent(
        book.id!,
        () => CartItem(
          id: 'c${DateTime.now().toIso8601String()}',
          title: book.title,
          image: book.image,
          price: book.price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void increaseQuatity(String bookId) {
    _items.update(
      bookId,
      (existingCartItem) => existingCartItem.copyWith(
        quantity: existingCartItem.quantity + 1,
      ),
    );
    notifyListeners();
  }

  void decreaseQuatity(String bookId) {
    _items.update(
        bookId,
        (existingCartItem) => existingCartItem.copyWith(
              quantity: existingCartItem.quantity > 0
                  ? existingCartItem.quantity - 1
                  : 0,
            ));
    if (_items[bookId]?.quantity == 0) {
      removeItem(bookId);
    }
    notifyListeners();
  }

  void removeItem(String bookId) {
    _items.remove(bookId);
    notifyListeners();
  }

  void removeSingleItem(String bookId) {
    if (!_items.containsKey(bookId)) {
      return;
    }
    if (_items[bookId]?.quantity as num > 1) {
      _items.update(
        bookId,
        (existingCartItem) => existingCartItem.copyWith(
          quantity: existingCartItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(bookId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
