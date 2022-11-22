import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/cart_item.dart';
import '../shared/screens.dart';

class CartItemCard extends StatelessWidget {
  final CartItem cardItem;

  const CartItemCard(
    // this.productId,
    this.cardItem, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 150,
      child: buildItemCard(context),
    );
  }

  Widget buildItemCard(BuildContext context) {
    return Card(
        elevation: 30.0,
        margin: const EdgeInsets.symmetric(
          horizontal: 7,
          vertical: 10,
        ),
        child: Padding(
            padding: const EdgeInsets.only(left: 5, bottom: 15),
            child: ListTile(
                leading: Image.network(
                  cardItem.image,
                  // height: 500,
                ),
                title: Text(cardItem.title),
                subtitle: Text('${cardItem.price.toStringAsFixed(3)}đ'),
                trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          showAlertDialog(
                            context,
                            'Xóa sản phẩm này khỏi giỏ hàng!',
                          );
                          context.read<CartManager>().removeItem(cardItem.id!);
                        },
                        child: Icon(Icons.delete, color: Colors.black),
                      ),
                      Padding(padding: EdgeInsets.only(top: 2)),
                      FittedBox(
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 2, color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            // mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    context
                                        .read<CartManager>()
                                        .decreaseQuatity(cardItem.id!);
                                  },
                                  icon: Icon(Icons.remove, size: 17)),
                              Text(
                                '${cardItem.quantity}',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              IconButton(
                                  onPressed: () {
                                    context
                                        .read<CartManager>()
                                        .increaseQuatity(cardItem.id!);
                                    // print(cardItem.id);
                                  },
                                  icon: Icon(Icons.add, size: 17)),
                            ],
                          ),
                        ),
                      ),
                    ]))));
  }
}
