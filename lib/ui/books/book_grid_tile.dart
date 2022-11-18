import 'package:flutter/material.dart';
import '../../models/book.dart';
import 'package:provider/provider.dart';
import '../shared/screens.dart';

class BookGridTile extends StatelessWidget {
  const BookGridTile(
    this.book, {
    super.key,
  });

  final Book book;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => BookDetailScreen(book)));
        },
        child: Card(
          elevation: 50.0,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 125,
                  width: 110,
                  margin: EdgeInsets.only(left: 35.0),
                  child: Image.network(
                    book.image,
                    scale: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5, left: 10, top: 2.0),
                  child: Text(
                    book.title,
                    style: TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                buildGridFooterBar(context)
              ]),
        ));
  }

  Widget buildGridFooterBar(BuildContext context) {
    return GridTileBar(
      leading: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 5.0),
          child: Text(
            "${book.price.toStringAsFixed(3)}đ",
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      trailing: ValueListenableBuilder<bool>(
          valueListenable: book.isFavoriteListenable,
          builder: (context, isFavorite, child) {
            return Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: IconButton(
                icon: Icon(
                  book.isFavorite ? Icons.favorite : Icons.favorite_border,
                  size: 27,
                ),
                color: Color(0xFF025564),
                onPressed: () {
                  context.read<BooksManager>().toggleFavoriteStatus(book);
                },
              ),
            );
          }),
    );
  }
}
