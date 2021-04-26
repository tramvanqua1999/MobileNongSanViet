import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final int amount;

  CartItem({
    @required this.id,
    @required this.amount,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(String pdtid, int amount) {
    if (_items.containsKey(pdtid)) {
      _items.update(
          pdtid,
          (existingCartItem) => CartItem(
                id: DateTime.now().toString(),
                amount: existingCartItem.amount + amount,
              ));
    } else {
      _items.putIfAbsent(
          pdtid,
          () => CartItem(
                id: DateTime.now().toString(),
                amount: amount,
              ));
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (!_items.containsKey(id)) {
      return;
    }
    if (_items[id].amount > 1) {
      _items.update(
          id,
          (existingCartItem) => CartItem(
                id: DateTime.now().toString(),
                amount: existingCartItem.amount - 1,
              ));
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
