import 'package:flutter/foundation.dart';
import '../data/cart_item.dart';

class CartService extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  void addItem(String id, String name, double price, {double discount = 0.0}) {
    final existingIndex = _items.indexWhere((item) => item.id == id);
    if (existingIndex != -1) {
      _items[existingIndex].quantity += 1;
    } else {
      _items.add(CartItem(id: id, name: name, price: price, discount: discount));
    }
    notifyListeners(); // ✅ Notify UI
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners(); // ✅ Notify UI
  }

  void updateQuantity(String id, int newQuantity) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index != -1) {
      if (newQuantity <= 0) {
        _items.removeAt(index);  // <--- removes the item entirely
      } else {
        _items[index].quantity = newQuantity;
      }
    }
  }


  void clearCart() {
    _items.clear();
    notifyListeners(); // ✅ Notify UI
  }
}
