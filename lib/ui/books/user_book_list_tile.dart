import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../shared/screens.dart';
import '../../models/book.dart';

class UserBookListTile extends StatelessWidget {
  final Book book;
  const UserBookListTile(
    this.book, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(book.title),
      leading: CircleAvatar(backgroundImage: NetworkImage(book.image)),
      trailing: SizedBox(
        width: 100,
        child: Row(children: <Widget>[
          buildEditButton(context),
          buildDeleteButton(context),
        ]),
      ),
    );
  }

  Widget buildEditButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pushNamed(
          EditBookScreen.routeName,
          arguments: book.id,
        );
      },
      icon: const Icon(Icons.border_color),
      color: Color.fromARGB(255, 81, 151, 117),
    );
  }

  Widget buildDeleteButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<BooksManager>().deleteProduct(book.id!);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text(
                'Product deleted',
                textAlign: TextAlign.center,
              ),
            ),
          );
      },
      icon: const Icon(Icons.delete),
      color: Theme.of(context).errorColor,
    );
  }
}
