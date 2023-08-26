import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_shopping_cart/cart.dart';
import 'package:provider_shopping_cart/product.dart';

class AdminPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageURLController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Product Name')),
            TextField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Product Price')),
            TextField(
                controller: _imageURLController,
                decoration: const InputDecoration(labelText: 'Image URL')),
            TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String name = _nameController.text;
                double price = double.tryParse(_priceController.text) ?? 0.0;
                String imageURL = _imageURLController.text;
                String description = _descriptionController.text;

                if (name.isNotEmpty &&
                    price > 0 &&
                    imageURL.isNotEmpty &&
                    description.isNotEmpty) {
                  Provider.of<CartProvider>(context, listen: false).addProduct(
                    Product(
                      id: DateTime.now().millisecondsSinceEpoch,
                      name: name,
                      price: price,
                      imageURL: imageURL,
                      description: description,
                    ),
                  );
                  Navigator.pop(context); // Return to the admin page
                }
              },
              child: const Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
