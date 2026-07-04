import 'package:flutter/material.dart';
import 'package:grand_library/features/dashboard/data/models/cart_item_model.dart';
import 'package:grand_library/features/dashboard/data/models/product_model.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItemModel> _items = [];

  List<CartItemModel> get items => _items;

  double get total => _items.fold(0, (sum, item) => sum + item.subtotal);

  void add(ProductModel product) {
    final index = _items.indexWhere((e) => e.product.id == product.id);

    if (index != -1) {
      _items[index].qty++;
    } else {
      _items.add(CartItemModel(product: product));
    }

    notifyListeners();
  }

  void increase(int index) {
    _items[index].qty++;
    notifyListeners();
  }

  void decrease(int index) {
    if (_items[index].qty > 1) {
      _items[index].qty--;
    } else {
      _items.removeAt(index);
    }

    notifyListeners();
  }

  void remove(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
