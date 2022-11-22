import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/shared/screens.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          // ChangeNotifierProvider(create: (context) => CartManager()),
          // ChangeNotifierProvider(create: (ctx) => OrderManager()),
          ChangeNotifierProvider(create: (context) => AuthManager()),
          ChangeNotifierProxyProvider<AuthManager, OrderManager>(
            create: (ctx) => OrderManager(),
            update: (ctx, authManager, ordersManager) {
              ordersManager!.authToken = authManager.authToken;
              return ordersManager;
            },
          ),
          ChangeNotifierProxyProvider<AuthManager, CartManager>(
            create: (ctx) => CartManager(),
            update: (ctx, authManager, cartManager) {
              cartManager!.authToken = authManager.authToken;
              return cartManager;
            },
          ),
          ChangeNotifierProxyProvider<AuthManager, BooksManager>(
            create: (ctx) => BooksManager(),
            update: (ctx, authManager, productsManager) {
              productsManager!.authToken = authManager.authToken;
              return productsManager;
            },
          ),
        ],
        child: Consumer<AuthManager>(
          builder: (context, authManager, child) {
            return MaterialApp(
                title: 'Book App',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                home: authManager.isAuth
                    ? const BookScreen()
                    : FutureBuilder(
                        future: authManager.tryAutoLogin(),
                        builder: (ctx, snapshot) {
                          return snapshot.connectionState ==
                                  ConnectionState.waiting
                              ? const SplashScreen()
                              : const AuthScreen();
                        },
                      ),
                routes: {
                  CartScreen.routeName: (ctx) => const CartScreen(),
                  OrdersScreen.routeName: (ctx) => const OrdersScreen(),
                  UserBooksScreen.routeName: (ctx) => const UserBooksScreen(),
                  // EditBookScreen.routeName: (ctx) => const EditBookScreen(),

                  // BookDetailScreen.routeName: (ctx) => const BookDetailScreen(),
                },
                onGenerateRoute: (settings) {
                  if (settings.name == BookDetailScreen.routeName) {
                    final bookid = settings.arguments as String;
                    return MaterialPageRoute(
                      builder: (ctx) {
                        return BookDetailScreen(
                          ctx.read<BooksManager>().findById(bookid),
                        );
                      },
                    );
                  }
                  if (settings.name == EditBookScreen.routeName) {
                    final bookid = settings.arguments as String?;
                    return MaterialPageRoute(
                      builder: (ctx) {
                        return EditBookScreen(
                          bookid != null
                              ? ctx.read<BooksManager>().findById(bookid)
                              : null,
                        );
                      },
                    );
                  }
                  return null;
                });
          },
        ));
  }
}
