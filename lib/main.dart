import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:book_app/ui/auth/auth_screen.dart';
// import 'package:book_app/ui/card/cart_manager.dart';
// import 'package:book_app/ui/splash_screen.dart';
// import 'ui/books/book_screen.dart';
// import 'ui/card/cart_screen.dart';
// import 'ui/orders/orders_screen.dart';
// import 'ui/books/book_detail_screen.dart';
// import 'ui/orders/order_manager.dart';
// import 'ui/auth/auth_manager.dart';
// import 'ui/books/books_manager.dart';
import 'ui/shared/screens.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
                // onGenerateRoute: (settings) {
                //  if(settings.name == ProductsOverviewScreen.route)
                // },
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
                  // if (settings.name == OrdersScreen.routeName) {
                  //   final args = settings.arguments as bool?;
                  //   print(args);
                  //   // return MaterialPageRoute(
                  //   //   builder: (ctx) {
                  //   //     return OrdersScreen(args);
                  //   //   },
                  //   // );
                  // }
                  return null;
                });
          },
        ));
  }
}
