import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/book.dart';
import 'package:provider/provider.dart';
import '../shared/screens.dart';

class BookDetailScreen extends StatelessWidget {
  static const routeName = '/book-detail';
  const BookDetailScreen(
    this.book, {
    super.key,
  });

  final Book book;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          color: Colors.white,
          child: ElevatedButton(
            onPressed: () {
              final cart = context.read<CartManager>();
              cart.addItem(book, context);
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: const Text('Thêm vào giỏ hàng'),
                  duration: const Duration(seconds: 1),
                ));
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF025564),
                shape: const StadiumBorder(),
                padding: const EdgeInsets.only(top: 20, bottom: 20)),
            child: const Text("Add to cart"),
          ),
        ),
        backgroundColor: Color(0xFF025564),
        appBar: AppBar(
            elevation: 20,
            backgroundColor: Color(0xFF025564),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: <Widget>[buiShoppingCart()]),
        body: ListView(children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  book.image,
                ),
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.4,
          ),
          Container(
              child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    textAlign: TextAlign.center,
                    book.title,
                    style: AppTheme.light().textTheme.headline1,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      book.author,
                      style: AppTheme.light().textTheme.headline2,
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 7, left: 25, bottom: 10),
                    child: Row(
                      children: <Widget>[
                        Text(
                          book.price.toStringAsFixed(3),
                          style: GoogleFonts.openSans(
                            fontSize: 25,
                            color: Color.fromARGB(255, 207, 24, 11),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'đ',
                          style: GoogleFonts.openSans(
                              fontSize: 18,
                              color: Color.fromARGB(255, 207, 24, 11),
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    )),
                Padding(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: Text(
                    book.description,
                    style: AppTheme.light().textTheme.bodyText1,
                  ),
                )
              ],
            ),
          ))
        ]));
  }

  Widget buiShoppingCart() {
    return Consumer<CartManager>(builder: (ctx, cartManager, child) {
      return TopRightBadge(
        data: cartManager.cartCount,
        // data: cartManager.productCount,

        child: Padding(
          padding: const EdgeInsets.only(right: 10.0, bottom: 4.0),
          child: IconButton(
              onPressed: () {
                Navigator.of(ctx).pushNamed(CartScreen.routeName);
              },
              icon: const Icon(
                Icons.shopping_cart,
                size: 30.0,
              )),
        ),
      );
    });
  }
}
