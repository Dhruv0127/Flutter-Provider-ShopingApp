import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_shopping_cart/AdminPage.dart';
import 'package:provider_shopping_cart/cart.dart';
import 'package:provider_shopping_cart/cart_screen.dart';
import 'package:provider_shopping_cart/product_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: MaterialApp(
        title: 'Provider Shopping Cart',
        theme: ThemeData.dark(useMaterial3: true, ),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (ctx) => const ProductScreen(),
          '/admin': (ctx) => AdminPage(),
          '/user': (ctx) => const ProductScreen(),
          '/cart': (ctx) => const CartScreen(),
        },
      ),
    );
  }
}
