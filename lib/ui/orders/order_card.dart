import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/order_item.dart';

class OrderItemCard extends StatefulWidget {
  final OrderItem order;

  const OrderItemCard(this.order, {super.key});

  @override
  State<OrderItemCard> createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 30.0,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          buildOrderSummary(),
          if (_expanded) buildOrderDetails()
        ],
      ),
    );
  }

  Widget buildOrderDetails() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        height: min(widget.order.productCount * 20.0 + 90, 200),
        child: ListView(
          children: widget.order.products
              .map(
                (prod) => Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            prod.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          '${prod.quantity}x ${prod.price.toStringAsFixed(3)}đ',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                    const Divider()
                  ],
                ),
              )
              .toList(),
        ));
  }

  Widget buildOrderSummary() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        leading: Icon(Icons.border_color_outlined),
        title: Text(
          '${widget.order.amount.toStringAsFixed(3)}đ',
          style: TextStyle(color: Colors.black),
        ),
        subtitle: Text(
            DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
            style: TextStyle(color: Colors.black)),
        trailing: IconButton(
          iconSize: 30,
          color: Color(0xff025564),
          icon: Icon(_expanded
              ? Icons.keyboard_double_arrow_up
              : Icons.keyboard_double_arrow_down_rounded),
          onPressed: () {
            setState(() {
              _expanded = !_expanded;
            });
          },
        ),
      ),
    );
  }
}
