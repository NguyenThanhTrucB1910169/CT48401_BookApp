import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../shared/screens.dart';

enum FilterOptions { favorites, all }

class BookScreen extends StatefulWidget {
  static const routeName = '/';
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  final _showOnlyFavorites = ValueNotifier<bool>(false);
  late Future<void> _fetchProducts;

  @override
  void initState() {
    super.initState();
    _fetchProducts = context.read<BooksManager>().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Store"),
        backgroundColor: Color(0xFF025564),
        actions: <Widget>[
          // context.read<CartManager>().fetchCart();
          buildShoppingCartIcon(),
        ],
      ),
      drawer: const AppDrawer(),
      body: Container(
        color: Color(0xffEBECF0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 40.0, left: 10.0),
                child: ImagesList(),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, bottom: 20.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.bookmarks_sharp,
                      size: 30,
                    ),
                    Text(
                      'Sách Bán Chạy',
                      style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.brown,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 120.0),
                        child: buildFavoriteIcon())
                  ],
                ),
              ),
              SizedBox(
                  width: 500,
                  height: 340,
                  child: FutureBuilder(
                      future: _fetchProducts,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return ValueListenableBuilder<bool>(
                            valueListenable: _showOnlyFavorites,
                            builder: (context, onlyFavorites, child) {
                              return ProductsGrid(onlyFavorites);
                            },
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      })),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget buildShoppingCartIcon() {
    return Consumer<CartManager>(builder: (ctx, cartManager, child) {
      return TopRightBadge(
        data: context.read<CartManager>().cartCount,
        // data: context.read<CartManager>().productCount,
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0, bottom: 4.0),
          child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              icon: const Icon(
                Icons.shopping_cart,
                size: 30.0,
              )),
        ),
      );
    });
  }

  Widget buildFavoriteIcon() {
    return PopupMenuButton(
      onSelected: (FilterOptions selectedValue) {
        if (selectedValue == FilterOptions.favorites) {
          _showOnlyFavorites.value = true;
        } else {
          _showOnlyFavorites.value = false;
        }
      },
      icon: const Icon(Icons.more_horiz_outlined, size: 35),
      itemBuilder: (ctx) => [
        const PopupMenuItem(
          value: FilterOptions.favorites,
          child: Text('Show Favotites Book'),
        ),
        const PopupMenuItem(
          value: FilterOptions.all,
          child: Text('Show All'),
        ),
      ],
    );
  }
}
