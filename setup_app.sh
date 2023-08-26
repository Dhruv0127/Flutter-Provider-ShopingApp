
# Create the necessary directories
mkdir lib

# Create the model files
echo "class Product {
  final int id;
  final String name;
  final double price;

  Product({required this.id, required this.name, required this.price});
}" > lib/product.dart

echo "import 'package:flutter/foundation.dart';
import 'package:provider_shopping_cart/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double get totalPrice {
    return _items.fold(0, (sum, item) => sum + item.product.price * item.quantity);
  }

  void addToCart(Product product) {
    int index = _items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _items.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }
}" > lib/cart.dart

# Create the screen files
echo "import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_shopping_cart/cart.dart';
import 'package:provider_shopping_cart/product.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Product> products = [
      Product(id: 1, name: 'Product 1', price: 10.0),
      Product(id: 2, name: 'Product 2', price: 20.0),
      // Add more products
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Product List')),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (ctx, index) {
          var product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: Icon(Icons.add_shopping_cart),
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false).addToCart(product);
              },
            ),
          );
        },
      ),
    );
  }
}" > lib/product_screen.dart

echo "import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_shopping_cart/cart.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.items.length,
              itemBuilder: (ctx, index) {
                var cartItem = cartProvider.items[index];
                return ListTile(
                  title: Text(cartItem.product.name),
                  subtitle: Text('\$${(cartItem.product.price * cartItem.quantity).toStringAsFixed(2)}'),
                  trailing: Text('Quantity: \${cartItem.quantity}'),
                  onTap: () {
                    cartProvider.removeFromCart(cartItem.product);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total: \${cartProvider.totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}" > lib/cart_screen.dart

# Create the main app file
echo "import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_shopping_cart/cart.dart';
import 'package:provider_shopping_cart/product_screen.dart';
import 'package:provider_shopping_cart/cart_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: MaterialApp(
        title: 'Provider Shopping Cart',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (ctx) => ProductScreen(),
          '/cart': (ctx) => CartScreen(),
        },
      ),
    );
  }
}" > lib/main.dart