import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/book.dart';
import '../shared/screens.dart';

class EditBookScreen extends StatefulWidget {
  static const routeName = '/edit-book';
  EditBookScreen(
    Book? book, {
    super.key,
  }) {
    if (book == null) {
      this.book = Book(
        id: null,
        title: '',
        author: '',
        price: 0,
        description: '',
        image: '',
      );
    } else {
      this.book = book;
    }
  }
  late final Book book;
  @override
  State<EditBookScreen> createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  var _isLoading = false;
  late Book _editedBook;
  final _editForm = GlobalKey<FormState>();
  bool _isValidImageUrl(String value) {
    return (value.startsWith('http') || value.startsWith('https')) &&
        (value.endsWith('.png') ||
            value.endsWith('.jpg') ||
            value.endsWith('jpeg'));
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(() {
      if (!_imageUrlFocusNode.hasFocus) {
        if (!_isValidImageUrl(_imageUrlController.text)) {
          return;
        }
        setState(() {});
      }
    });
    _editedBook = widget.book;
    _imageUrlController.text = _editedBook.image;
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.close,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, UserBooksScreen.routeName);
          },
        ),
        title: const Text('Edit Book'),
        backgroundColor: const Color(0xFF025564),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: const Color(0xFF025564),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _editForm,
                child: ListView(
                  children: <Widget>[
                    buildBookPreview(),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: buildTitleField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: buildAuthorField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: buildPriceField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: buildDescriptionField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: buildImageURLField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: () {
                          _saveForm();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(20),
                          backgroundColor: const Color(0xFF025564),
                          shape: const StadiumBorder(),
                        ),
                        child: const Text("Save"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  TextFormField buildTitleField() {
    return TextFormField(
      initialValue: _editedBook.title,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          labelText: "Book title",
          prefixIcon: Icon(Icons.chat_bubble_outline,
              color: Colors.deepPurple.shade300),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple.shade300),
          ),
          labelStyle: const TextStyle(color: Colors.deepPurple)),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Plese enter a title.';
        }
        return null;
      },
      onSaved: (value) {
        _editedBook = _editedBook.copyWith(title: value);
      },
    );
  }

  TextFormField buildAuthorField() {
    return TextFormField(
      initialValue: _editedBook.author,
      decoration: InputDecoration(
          labelText: "Author",
          prefixIcon: Icon(Icons.people, color: Colors.deepPurple.shade300),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple.shade300),
          ),
          labelStyle: const TextStyle(color: Colors.deepPurple)),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Plese enter a author.';
        }
        return null;
      },
      onSaved: (value) {
        _editedBook = _editedBook.copyWith(author: value);
      },
    );
  }

  TextFormField buildPriceField() {
    return TextFormField(
      initialValue: _editedBook.price.toString(),
      decoration: InputDecoration(
        labelText: "Price",
        prefixIcon: Icon(Icons.attach_money, color: Colors.deepPurple.shade300),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurple.shade300),
        ),
        labelStyle: const TextStyle(color: Colors.deepPurple),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a price.';
        }
        if (double.tryParse(value) == null) {
          return 'Please enter a valid number.';
        }
        if (double.parse(value) <= 0) {
          return 'Please enter a number greater than zero.';
        }
        return null;
      },
      onSaved: (value) {
        _editedBook = _editedBook.copyWith(price: double.parse(value!));
      },
    );
  }

  TextFormField buildDescriptionField() {
    return TextFormField(
      initialValue: _editedBook.description,
      decoration: InputDecoration(
          labelText: "Description",
          prefixIcon:
              Icon(Icons.description, color: Colors.deepPurple.shade300),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple.shade300),
          ),
          labelStyle: const TextStyle(color: Colors.deepPurple)),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a description.';
        }
        if (value.length < 10) {
          return 'Should be at least 10 characters long.';
        }
        return null;
      },
      onSaved: (value) {
        _editedBook = _editedBook.copyWith(description: value);
      },
    );
  }

  Widget buildBookPreview() {
    return Container(
      width: 100,
      height: 100,
      margin: const EdgeInsets.only(left: 120, right: 120, bottom: 5),
      decoration: BoxDecoration(
          border: Border.all(
        width: 1,
        color: Colors.grey,
      )),
      child: _imageUrlController.text.isEmpty
          ? const Text('Book image')
          : FittedBox(
              child: Image.network(
                _imageUrlController.text,
                fit: BoxFit.cover,
              ),
            ),
    );
  }

  TextFormField buildImageURLField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Image URL",
          prefixIcon: Icon(Icons.edit, color: Colors.deepPurple.shade300),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple.shade300),
          ),
          labelStyle: const TextStyle(color: Colors.deepPurple)),
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.done,
      controller: _imageUrlController,
      focusNode: _imageUrlFocusNode,
      onFieldSubmitted: (value) => _saveForm(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter an immage URL.';
        }
        if (!_isValidImageUrl(value)) {
          return 'Please enter a valid image URL.';
        }
        return null;
      },
      onSaved: (value) {
        _editedBook = _editedBook.copyWith(image: value);
      },
    );
  }

  Future<void> _saveForm() async {
    final isValid = _editForm.currentState!.validate();
    if (!isValid) {
      return;
    }

    _editForm.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    try {
      final booksManager = context.read<BooksManager>();
      if (_editedBook.id != null) {
        await booksManager.updateProduct(_editedBook);
      } else {
        await booksManager.addProduct(_editedBook);
      }
    } catch (error) {
      await showErrorDialog(context, 'Something went wrong');
    }

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      Navigator.of(context).pushReplacementNamed(UserBooksScreen.routeName);
    }
  }
}
