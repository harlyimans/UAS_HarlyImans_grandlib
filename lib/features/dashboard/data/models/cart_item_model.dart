import 'package:grand_library/features/dashboard/data/models/product_model.dart';

class CartItemModel {
  final ProductModel product;
  int qty;

  CartItemModel({required this.product, this.qty = 1});

  double get subtotal => product.price * qty;
}
