import 'package:flutter/material.dart';

import 'auth_card.dart';
import 'app_banner.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
            colors: [
              Colors.teal,
              Color.fromARGB(255, 207, 231, 228),
              // Colors.red,
              // Colors.green
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ))),
          SingleChildScrollView(
            child: SizedBox(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 40), child: AppBanner()),
                  const Flexible(
                    // flex: deviceSize.width > 600 ? 2 : 1,
                    child: const AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
