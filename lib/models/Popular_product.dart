import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Product {
  final int id;
  final int groupProduct;
  final int amount;
  final int countSale;
  final int shopCode;
  final String name;
  final String description;
  final List<String> images;
  final double rating;
  final String price;
  final DateTime create;
  final int discount;
  final DateTime lastday;
  final String priceDiscount;

  Product(
      {@required this.id,
      @required this.groupProduct,
      @required this.amount,
      @required this.countSale,
      @required this.shopCode,
      @required this.name,
      @required this.description,
      @required this.images,
      @required this.rating,
      @required this.price,
      @required this.create,
      @required this.discount,
      @required this.lastday,
      @required this.priceDiscount});
  factory Product.fromJson(Map<String, dynamic> jsonData) {
    return Product(
        id: jsonData['id'],
        groupProduct: jsonData['groupProduct'],
        amount: jsonData['amount'],
        countSale: jsonData['countSale'],
        shopCode: jsonData['shopCode'],
        name: jsonData['name'],
        description: jsonData['description'],
        images: jsonData['listpath'].toString().split(','),
        rating: double.parse(jsonData['rating'].toString()),
        price: NumberFormat("#,###", "pt_BR")
                .format(double.parse(jsonData['price'].toString())) +
            " ₫",
        create: DateTime.parse(jsonData['create']),
        discount: jsonData['discount'],
        lastday: DateTime.parse(jsonData['lastday']),
        priceDiscount: NumberFormat("#,###", "pt_BR")
                .format(double.parse(jsonData['price'].toString()) -
                    (double.parse(jsonData['price'].toString()) *
                        double.parse(jsonData['discount'].toString()) /
                        100))
                .toString() +
            " ₫");
  }
}
// Our demo Products
