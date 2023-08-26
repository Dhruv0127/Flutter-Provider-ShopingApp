import 'package:flutter/foundation.dart';
import 'package:provider_shopping_cart/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double get totalPrice {
    return _items.fold(
        0, (sum, item) => sum + item.product.price * item.quantity);
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

  // Define the addProduct method here
  void addProduct(Product product) {
    _items.add(CartItem(product: product));
    notifyListeners();
  }
}
