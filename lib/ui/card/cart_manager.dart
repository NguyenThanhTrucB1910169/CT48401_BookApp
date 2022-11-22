import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import '../shared/screens.dart';
import '../../models/cart_item.dart';
import '../../models/book.dart';
import '../../services/cart_service.dart';
import '../../models/auth_token.dart';

class CartManager with ChangeNotifier {
  List<CartItem> _items = [];
  final CartService _cartService;

  CartManager([AuthToken? authToken]) : _cartService = CartService(authToken);

  set authToken(AuthToken? authToken) {
    _cartService.authToken = authToken;
  }

  int get cartCount {
    fetchCart();
    return _items.length;
  }

  List<CartItem> get cart {
    return _items.toList();
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((e) {
      total += e.price * e.quantity;
    });
    return total;
  }

  Future<void> fetchCart() async {
    _items = await _cartService.fetchCarts();
    notifyListeners();
  }

  void addItem(Book book, context) async {
    CartItem cartItem = CartItem(
      id: book.id!,
      idBook: book.id!,
      title: book.title,
      image: book.image,
      price: book.price,
      quantity: 1,
    );
    bool hasid = false;
    // print(book.id);
    _items.forEach((e) {
      // print("idbook " + e.idBook);
      if (e.idBook == book.id) {
        hasid = true;
      } else {}
    });
    if (!hasid) {
      // print(_items.length);
      await _cartService.addCart(cartItem);
      _items.add(cartItem);
    } else {
      showAlertDialog(context, 'Sản phẩm này đã có trong giỏ hàng');
    }
    notifyListeners();
  }

  void increaseQuatity(String bookId) {
    _items.forEach((e) async {
      if (e.id == bookId) {
        e.quanlityListenable.value += 1;
        await _cartService.updateCart(e);
      }
    });
    notifyListeners();
  }

  void decreaseQuatity(String bookId) {
    _items.forEach((e) async {
      if (e.id == bookId) {
        if (e.quanlityListenable.value == 1) {
          removeItem(bookId);
        } else {
          e.quanlityListenable.value -= 1;
          await _cartService.updateCart(e);
        }
      }
    });
    notifyListeners();
  }

  void removeItem(String bookId) async {
    final index = _items.indexWhere((item) => item.id == bookId);
    await _cartService.deleteCart(bookId);
    _items.removeAt(index);
    notifyListeners();
  }

  void clear() async {
    await _cartService.deleteAllCart();
    fetchCart();
    notifyListeners();
  }
}
