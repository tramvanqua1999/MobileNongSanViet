import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Product {
  final int id;
  final int groupProduct;
  final int amount;
  final int shopCode;
  final String name;
  final String description;
  final List<String> images;
  final double rating;
  final String price;
  final DateTime create;
  final bool favorite;
  final int discount;
  final DateTime lastday;
  final String priceDiscount;

  Product(
      {@required this.id,
      @required this.groupProduct,
      @required this.amount,
      @required this.favorite,
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
        shopCode: jsonData['shopCode'],
        name: jsonData['name'],
        description: jsonData['description'],
        images: jsonData['listpath'].toString().split(','),
        rating: double.parse(jsonData['rating'].toString()),
        price: NumberFormat("#,###", "pt_BR")
                .format(double.parse(jsonData['price'].toString())) +
            " ₫",
        create: DateTime.parse(jsonData['create']),
        favorite: jsonData['Favor'] == 0 ? true : false,
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

List<Product> demoProducts = [
  Product(
      shopCode: 1,
      groupProduct: 2,
      create: DateTime.now(),
      id: 1,
      amount: 10,
      images: [
        // "assets/images/ps4_console_white_1.png",
        // "assets/images/ps4_console_white_2.png",
        // "assets/images/ps4_console_white_3.png",
        // "assets/images/ps4_console_white_4.png",
        "assets/images/1.jpg",
        "assets/images/23.jpg",
        "assets/images/4-1.jpg",
        "assets/images/2.jpg",
      ],
      name: "Wireless Controller for PS4™",
      price: "64.99",
      description: "description",
      rating: 1.8,
      favorite: false,
      priceDiscount: "10",
      discount: 10,
      lastday: DateTime.now()),
];
//   Product(
//     id: 3,
//     images: [
//       // "assets/images/glap.png",
//       "assets/images/9.jpg",
//     ],
//     colors: [
//       Color(0xFFF6625E),
//       Color(0xFF836DB8),
//       Color(0xFFDECB9C),
//       Colors.white,
//     ],
//     title: "Gloves XC Omega - Polygon",
//     price: 36.55,
//     description: description,
//     rating: 3.1,
//     isFavourite: true,
//     isPopular: true,
//     isSale: true,
//   ),
//   Product(
//     id: 4,
//     images: [
//       // "assets/images/wireless headset.png",
//       "assets/images/12.jpg",
//     ],
//     colors: [
//       Color(0xFFF6625E),
//       Color(0xFF836DB8),
//       Color(0xFFDECB9C),
//       Colors.white,
//     ],
//     title: "Logitech Head ProductSaleCard",
//     price: 20.20,
//     description: description,
//     rating: 4.1,
//     isFavourite: true,
//     isSale: true,
//   ),
// ];

// const String description =
//     "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";
