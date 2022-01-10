import 'package:flutter/material.dart';

import 'modules/on_bording/on_boarding_screen.dart';
import 'modules/shopping_app/login/shop_login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  ShopLoginScreen(),
    );
  }
}

