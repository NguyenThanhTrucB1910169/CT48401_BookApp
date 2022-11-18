import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../shared/screens.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Consumer<AuthManager>(builder: (context, authManager, child) {
      return Column(
        children: <Widget>[
          AppBar(
            // title: const Text("Book App!!"),
            automaticallyImplyLeading: false,
            // backgroundColor: Color(0xFF025564),
            flexibleSpace: const Image(
              image: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqoRhccovWlAd7E8w3UF0EwsRqh-CTruPv4w&usqp=CAU'),
              fit: BoxFit.cover,
            ),
            backgroundColor: Colors.transparent,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Column(
              children: [
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(BookScreen.routeName);
                  },
                ),
                authManager.isAdmin
                    ? Column(children: [
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.description),
                          title: const Text('Manager books'),
                          onTap: () {
                            Navigator.of(context).pushReplacementNamed(
                                UserBooksScreen.routeName);
                          },
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.add_circle_outline),
                          title: const Text('Add New Book'),
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed(EditBookScreen.routeName);
                          },
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.list_alt),
                          title: const Text('Order'),
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed(OrdersScreen.routeName);
                          },
                        ),
                        const Divider(),
                      ])
                    : Column(children: [
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.shopping_bag),
                          title: const Text('Cart'),
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed(CartScreen.routeName);
                          },
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.list_alt),
                          title: const Text('Order'),
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed(OrdersScreen.routeName);
                          },
                        ),
                        const Divider(),
                      ]),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    Navigator.of(context)
                      ..pop()
                      ..pushReplacementNamed('/');
                    context.read<AuthManager>().logout();
                  },
                ),
              ],
            ),
          ),
        ],
      );
    }));
  }
}
