import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_shopping_cart/cart.dart';
import 'package:provider_shopping_cart/cart_screen.dart';
import 'package:provider_shopping_cart/product.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Product> products = [
      Product(
        id: 1,
        name: 'Apple',
        price: 1.0,
        imageURL: 'assets/images/appleimage.png',
        description: 'Fresh and crispy apples harvested from local orchards.',
      ),
      Product(
        id: 2,
        name: 'Banana',
        price: 0.5,
        imageURL: 'assets/images/bananaimage.png',
        description: 'Sweet and nutritious bananas, perfect for a quick snack.',
      ),
      Product(
        id: 3,
        name: 'Grapes',
        price: 2.5,
        imageURL: 'assets/images/grapeimage.png',
        description: 'Juicy and succulent grapes bursting with flavor.',
      ),
      Product(
        id: 4,
        name: 'Lemon',
        price: 0.75,
        imageURL: 'assets/images/lemonimage.png',
        description:
            'Tangy and refreshing lemons for adding zest to your dishes.',
      ),
      Product(
        id: 5,
        name: 'Mango',
        price: 3.0,
        imageURL: 'assets/images/mangoimage.png',
        description: 'Exotic and sweet mangoes imported from tropical regions.',
      ),
      Product(
        id: 6,
        name: 'Orange',
        price: 1.25,
        imageURL: 'assets/images/orangeimage.png',
        description: 'Vitamin C-rich oranges to boost your immune system.',
      ),
      Product(
        id: 7,
        name: 'Pineapple',
        price: 2.75,
        imageURL: 'assets/images/pineappleimage.png',
        description: 'Delicious and juicy pineapples for a tropical treat.',
      ),
    ];

    return ScaffoldMessenger(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Product List'),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 500),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const CartScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOutQuart;
                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);
                        return SlideTransition(
                            position: offsetAnimation, child: child);
                      },
                    ),
                  );
                },
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ],
          ),
          body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
            ),
            itemCount: products.length,
            itemBuilder: (ctx, index) {
              var product = products[index];
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  elevation: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        product.imageURL,
                        width: 100,
                        height: 100,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0), // Add horizontal padding
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                            8.0), // Add padding to the description
                        child: Text(
                          product.description,
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Provider.of<CartProvider>(context, listen: false)
                              .addToCart(product);
                        },
                        child: const Text('Add to Cart'),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
