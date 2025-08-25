import 'package:flutter/material.dart';

class CartItem {
  final String name;
  final double price;
  final String image;
  int quantity;

  CartItem({
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 1,
  });
}

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;
  
  int get itemCount {
    return _items.fold(0, (sum, item) => sum + item.quantity);
  }
  
  double get totalPrice {
    return _items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  void addItem({required String name, required double price, required String image}) {
    final existingIndex = _items.indexWhere((item) => item.name == name);
    
    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItem(name: name, price: price, image: image));
    }
    
    notifyListeners();
  }

  void removeItem(String name) {
    final existingIndex = _items.indexWhere((item) => item.name == name);
    
    if (existingIndex >= 0) {
      if (_items[existingIndex].quantity > 1) {
        _items[existingIndex].quantity--;
      } else {
        _items.removeAt(existingIndex);
      }
      
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}