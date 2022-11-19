import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/cart_item.dart';
// import '../shared/dialog_utils.dart';
// import 'cart_manager.dart';
import '../shared/screens.dart';

class CartItemCard extends StatelessWidget {
  // final String productId;
  // final CartItem cardItem;

  // const OrderItemCard(this.order, {super.key});
  // const CartItemCard(
  //   // required this.productId,
  //   this.cardItem, {
  //   super.key,
  // });
  // final String productId;
  final CartItem cardItem;

  const CartItemCard(
    // this.productId,
    this.cardItem, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cardItem.id),
      background: Container(
        color: Colors.blueGrey,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: const Icon(
          Icons.delete_forever_rounded,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showConfirmDialog(
          context,
          'Do you want to remove the item from the cart?',
        );
      },
      onDismissed: (direction) {
        context.read<CartManager>().removeItem(cardItem.id!);
      },
      child: buildItemCard(context),
    );
  }

  Widget buildItemCard(BuildContext context) {
    return Card(
        elevation: 30.0,
        margin: const EdgeInsets.symmetric(
          horizontal: 1,
          vertical: 10,
        ),
        child: Padding(
            padding: const EdgeInsets.only(left: 5, top: 15, bottom: 15),
            child: ListTile(
                leading: Image.network(
                  cardItem.image,
                  // height: 100,
                ),
                title: Text(cardItem.title),
                subtitle:

                    // Padding(
                    // padding: const EdgeInsets.only(left: 0),
                    // child:
                    // Column(
                    // children: <Widget>[
                    Text('${cardItem.price.toStringAsFixed(3)}đ'),
                // Text('Total: \$${(cardItem.price * cardItem.quantity)}')
                // ],
                // ),
                // ),
                trailing: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: FittedBox(
                        child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 3, color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                context
                                    .read<CartManager>()
                                    .decreaseQuatity(cardItem.id!);
                              },
                              icon: Icon(Icons.remove)),
                          Text(
                            '${cardItem.quantity}',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w500),
                          ),
                          IconButton(
                              onPressed: () {
                                context
                                    .read<CartManager>()
                                    .increaseQuatity(cardItem.id!);
                                // print(cardItem.id);
                              },
                              icon: Icon(Icons.add)),
                        ],
                      ),
                    ))))));
    // Row(
    //   children: [
    //     Text('${cardItem.quantity} x'),
    //     Text('${cardItem.quantity} x'),
    //   ],
    // )
    // Padding(
    //   padding: const EdgeInsets.only(top: 5.0),
    //   child:
    // Row(
    //   children: [
    //   ],
    // )
    //  Row(children: <Widget>[
    //   //   // InkWell(
    //   //   //     onTap: () {
    //   //   //       // context.read<CartManager>().decreaseQuatity(productId);
    //   //   //     },
    //   //   //     child: Icon(Icons.remove)),
    //   Text('quatity'),
    //   //   // InkWell(
    //   //   //     onTap: () {
    //   //   //       // context.read<CartManager>().increaseQuatity(productId);
    //   //   //     },
    //   //   //     child: Icon(Icons.add)),
    //
    // ])
    //       child:
    // Column(
    //   children: [
    //     Padding(
    //       padding: const EdgeInsets.only(bottom: 2.0),
    //     ),
    //     Text('Total: \$${(cardItem.price * cardItem.quantity)}')
    //   ],
    // ),
    // ),
    // ),
    // );
  }
}

// class CartItemCard extends StatelessWidget {
//   final String productId;
//   final CartItem cardItem;

//   const CartItemCard({
//     required this.productId,
//     required this.cardItem,
//     super.key,
//   });

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../models/cart_item.dart';
// // import '../shared/dialog_utils.dart';
// // import 'cart_manager.dart';
// import '../shared/screens.dart';

// class CartItemCard extends StatelessWidget {
//   // final String productId;
//   // final CartItem cardItem;

//   // const OrderItemCard(this.order, {super.key});
//   // const CartItemCard(
//   //   // required this.productId,
//   //   this.cardItem, {
//   //   super.key,
//   // });
//   final String productId;
//   final CartItem cardItem;

//   const CartItemCard({
//     required this.productId,
//     required this.cardItem,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Dismissible(
//       key: ValueKey(cardItem.id),
//       background: Container(
//         color: Colors.blueGrey,
//         alignment: Alignment.centerRight,
//         padding: const EdgeInsets.only(right: 20),
//         margin: const EdgeInsets.symmetric(
//           horizontal: 15,
//           vertical: 4,
//         ),
//         child: const Icon(
//           Icons.delete_forever_rounded,
//           color: Colors.white,
//           size: 40,
//         ),
//       ),
//       direction: DismissDirection.endToStart,
//       confirmDismiss: (direction) {
//         return showConfirmDialog(
//           context,
//           'Do you want to remove the item from the cart?',
//         );
//       },
//       onDismissed: (direction) {
//         context.read<CartManager>().removeItem(productId);
//       },
//       child: buildItemCard(context),
//     );
//   }

//   Widget buildItemCard(BuildContext context) {
//     return Card(
//         elevation: 30.0,
//         margin: const EdgeInsets.symmetric(
//           horizontal: 1,
//           vertical: 10,
//         ),
//         child: Padding(
//           padding: const EdgeInsets.only(left: 5, top: 15, bottom: 15),
//           child: ListTile(
//             leading: Image.network(
//               cardItem.image,
//               // height: 100,
//             ),
//             title: Text(cardItem.title),
//             subtitle:
//                 // Padding(
//                 // padding: const EdgeInsets.only(left: 0),
//                 // child:
//                 // Column(
//                 // children: <Widget>[
//                 Text('${cardItem.price.toStringAsFixed(3)}đ'),
//             // Text('Total: \$${(cardItem.price * cardItem.quantity)}')
//             // ],
//             // ),
//             // ),
//             trailing: Padding(
//                 padding: const EdgeInsets.only(top: 15),
//                 child: FittedBox(
//                     child: Container(
//                   decoration: BoxDecoration(
//                       border: Border.all(width: 3, color: Colors.blueGrey),
//                       borderRadius: BorderRadius.circular(20)),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                           onPressed: () {
//                             context
//                                 .read<CartManager>()
//                                 .decreaseQuatity(productId);
//                           },
//                           icon: Icon(Icons.remove)),
//                       Text(
//                         '${cardItem.quantity}',
//                         style: TextStyle(
//                             fontSize: 22, fontWeight: FontWeight.w500),
//                       ),
//                       IconButton(
//                           onPressed: () {
//                             context
//                                 .read<CartManager>()
//                                 .increaseQuatity(productId);
//                           },
//                           icon: Icon(Icons.add)),
//                     ],
//                   ),
//                 ))
//                 // Row(
//                 //   children: [
//                 //     Text('${cardItem.quantity} x'),
//                 //     Text('${cardItem.quantity} x'),
//                 //   ],
//                 // )
//                 // Padding(
//                 //   padding: const EdgeInsets.only(top: 5.0),
//                 //   child:
//                 // Row(
//                 //   children: [
//                 //   ],
//                 // )
//                 // Row(children: <Widget>[
//                 //   //   // InkWell(
//                 //   //   //     onTap: () {
//                 //   //   //       // context.read<CartManager>().decreaseQuatity(productId);
//                 //   //   //     },
//                 //   //   //     child: Icon(Icons.remove)),
//                 //   Text('quatity'),
//                 //   //   // InkWell(
//                 //   //   //     onTap: () {
//                 //   //   //       // context.read<CartManager>().increaseQuatity(productId);
//                 //   //   //     },
//                 //   //   //     child: Icon(Icons.add)),
//                 //
//                 // ])
//                 //       child:
//                 // Column(
//                 //   children: [
//                 //     Padding(
//                 //       padding: const EdgeInsets.only(bottom: 2.0),
//                 //     ),
//                 //     Text('Total: \$${(cardItem.price * cardItem.quantity)}')
//                 //   ],
//                 // ),
//                 ),
//           ),
//         ));
//   }
// }

  
// class CartItemCard extends StatelessWidget {
//   final String productId;
//   final CartItem cardItem;

//   const CartItemCard({
//     required this.productId,
//     required this.cardItem,
//     super.key,
//   });