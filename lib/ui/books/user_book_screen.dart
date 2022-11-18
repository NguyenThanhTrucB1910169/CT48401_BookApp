import '../shared/screens.dart';
import 'package:flutter/material.dart';
import 'books_manager.dart';
import 'package:provider/provider.dart';

class UserBooksScreen extends StatelessWidget {
  static const routeName = '/user-books';
  const UserBooksScreen({super.key});

  Future<void> _refreshProducts(BuildContext context) async {
    await context.read<BooksManager>().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Manager Books'),
          backgroundColor: Color(0xFF025564),
          actions: <Widget>[
            buildAddButton(context),
          ],
        ),
        drawer: const AppDrawer(),
        body: FutureBuilder(
            future: _refreshProducts(context),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return RefreshIndicator(
                onRefresh: () => _refreshProducts(context),
                child: buildUserBookListView(),
              );
            }));
  }

  Widget buildUserBookListView() {
    return Consumer<BooksManager>(
      builder: (ctx, booksManager, child) {
        return ListView.builder(
            itemCount: booksManager.itemCount,
            itemBuilder: (ctx, i) => Card(
                  elevation: 15.0,
                  child: Column(
                    children: [
                      UserBookListTile(
                        booksManager.items[i],
                      ),
                      const Divider(),
                    ],
                  ),
                ));
      },
    );
  }

  Widget buildAddButton(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(EditBookScreen.routeName);
        });
  }
}
