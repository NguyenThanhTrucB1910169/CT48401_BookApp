import 'package:flutter/material.dart';

Future<bool?> showConfirmDialog(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Are you sure?'),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text('No'),
          onPressed: () {
            Navigator.of(ctx).pop(false);
          },
        ),
        TextButton(
          child: const Text('Yes'),
          onPressed: () {
            Navigator.of(ctx).pop(true);
          },
        ),
      ],
    ),
  );
}

Future<void> showErrorDialog(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('An Error Occured'),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text('Okay'),
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        )
      ],
    ),
  );
}

Future<void> showAlertDialog(BuildContext context, String message) {
  // show the dialog
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Orders Success'),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    ),
  );
}
