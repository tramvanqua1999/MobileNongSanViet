import 'package:flutter/material.dart';

import 'Popular_product.dart';

class Cart {
  final Product product;
  final int numOfItem;
  final double priceship;

  Cart({this.product, @required this.numOfItem, this.priceship});
}

// Demo data for our cart

List<Cart> demoCarts = [];
