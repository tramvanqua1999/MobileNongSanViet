import 'package:flutter/material.dart';
import 'package:shop_app/models/Popular_product.dart';

class Product {
  final int id, groupProduct, amount;
  final String shopCode, name, description;
  final List<String> listpath;
  final double rating, price;
  final DateTime create;

  Product({
    @required this.id,
    @required this.groupProduct,
    @required this.amount,
    @required this.shopCode,
    @required this.name,
    @required this.description,
    @required this.listpath,
    @required this.rating,
    @required this.price,
    @required this.create,
  });
  factory Product.fromJson(Map<String, dynamic> jsonData) {
    return Product(
      id: jsonData['id'],
      groupProduct: jsonData['groupProduct'],
      amount: jsonData['amount'],
      shopCode: jsonData['shopCode'],
      name: jsonData['name'],
      description: jsonData['description'],
      listpath: jsonData['listpath'],
      rating: jsonData['rating'],
      price: jsonData['price'],
      create: jsonData['create'],
    );
  }
}

// Our demo Products
