import 'dart:math';
import 'package:flutter/material.dart';

class AppBanner extends StatelessWidget {
  const AppBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(image: AssetImage('assets/image/logo.png')),
      ),
      width: 160,
      height: 160,
    );
  }
}
