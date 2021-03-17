import 'package:flutter/material.dart';

import 'Popular_product.dart';

class Cart {
  final Product product;
  final int numOfItem;

  Cart({this.product, @required this.numOfItem});
}

// Demo data for our cart

List<Cart> demoCarts = [
  Cart(product: demoProducts[0], numOfItem: 2),
];
