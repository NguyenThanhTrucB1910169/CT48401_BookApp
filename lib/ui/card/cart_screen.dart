import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../shared/screens.dart';
import 'cart_manager.dart';
import '../../models/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  const CartScreen({super.key});
  // late Future<void> _fetchCart;
  // @override
  // void initState() {
  //   super.initState();
  //   _fetchCart = context.read<CartManager>().fetchCart();
  // }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartManager>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: Color(0xff025564),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, BookScreen.routeName);
          },
          icon: Icon(Icons.close),
        ),
      ),
      // body: Consumer<CartManager>(
      //   builder: (context, cartManager, child) {
      //     return FutureBuilder(
      //         future: _fetchCart,
      //         builder: (context, snapshot) {
      //           if (snapshot.connectionState == ConnectionState.done) {
      //             return ListView.builder(
      //               itemCount: cartManager.cartCount,
      //               itemBuilder: (ctx, i) =>
      //                   CartItemCard(cartManager.cart[i]),
      //             );
      //           }
      //           return const Center(
      //             child: CircularProgressIndicator(),
      //           );
      //         });
      //   },
      // ));
      body: Column(
        children: <Widget>[
          const SizedBox(height: 10),
          Expanded(
            child: buildCartDetails(cart),
          ),
          buildCartSummary(cart, context),
        ],
      ),
    );
  }

  Widget buildCartDetails(CartManager cart) {
    return ListView(
      children: cart.productEntries
          .map(
            (entry) => CartItemCard(
              productId: entry.key,
              cardItem: entry.value,
            ),
          )
          .toList(),
    );
  }

  Widget buildCartSummary(CartManager cart, BuildContext context) {
    return Card(
      // elevation: 15,
      margin: const EdgeInsets.only(bottom: 15, left: 5, right: 5, top: 10),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 5, top: 5, left: 20),
                          child: const Text(
                            'Total',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Text(
                          '${cart.totalAmount.toStringAsFixed(3)}đ',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                ),
                TextButton(
                  onPressed: cart.totalAmount <= 0
                      ? null
                      : () {
                          context
                              .read<OrderManager>()
                              .addOrder(cart.products, cart.totalAmount);
                          showAlertDialog(
                              context, 'Your Order Was Placed Successfully');
                          cart.clear();
                        },
                  style: ButtonStyle(
                      // backgroundColor:
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(width: 3, color: Colors.black),
                  ))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 110.0, vertical: 10.0),
                    child: Text(
                      'ORDER NOW',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
