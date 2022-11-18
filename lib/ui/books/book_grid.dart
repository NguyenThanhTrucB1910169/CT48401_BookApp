import 'package:flutter/material.dart';

import '../shared/screens.dart';
import '../../models/book.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavorites;

  const ProductsGrid(this.showFavorites, {super.key});

  @override
  Widget build(BuildContext context) {
    final products = context.select<BooksManager, List<Book>>(
        (productsManager) => showFavorites
            ? productsManager.favoriteItems
            : productsManager.items);
    return GridView.builder(
        padding: const EdgeInsets.all(0.0),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 20.0,
          childAspectRatio: 0.85,
        ),
        itemBuilder: (context, index) => BookGridTile(products[index]));
  }
}
