import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth/auth_manager.dart';
import 'order_manager.dart';
import 'order_card.dart';
import '../shared/app_drawer.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';
  // final bool admin;
  const OrdersScreen({super.key});
  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late Future<void> _fetchOrders;
  bool isadmin = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthManager>(builder: (context, authManager, child) {
      isadmin = authManager.isAdmin;
      _fetchOrders = context.read<OrderManager>().fetchOrders(isadmin);
      // print(isadmin);
      return Scaffold(
          appBar: AppBar(
            title: const Text('Orders'),
            backgroundColor: Color(0xff025564),
          ),
          drawer: const AppDrawer(),
          body: Consumer<OrderManager>(
            builder: (context, orderManager, child) {
              return FutureBuilder(
                  future: _fetchOrders,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: orderManager.orderCount,
                        itemBuilder: (ctx, i) =>
                            OrderItemCard(orderManager.orders[i]),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  });
            },
          ));
    });
  }
}
