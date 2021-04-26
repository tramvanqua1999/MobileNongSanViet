import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Shop {
  final int id;
  final String shopID;
  final String nameShop;
  final String img;
  final String imgBg;
  final double ratingShop;
  final String follow;
  final String sumproduct;
  final String description;
  final String address;
  final String phone;
  final String email;
  final String fee;
  final String price;
  final DateTime createshop;

  Shop(
      {@required this.id,
      @required this.shopID,
      @required this.nameShop,
      @required this.img,
      @required this.imgBg,
      @required this.ratingShop,
      @required this.follow,
      @required this.sumproduct,
      @required this.description,
      @required this.address,
      @required this.phone,
      @required this.email,
      @required this.fee,
      @required this.price,
      @required this.createshop});
  factory Shop.fromJson(Map<String, dynamic> jsonData) {
    return Shop(
      id: jsonData['id'],
      shopID: jsonData['shopID'].toString(),
      nameShop: jsonData['nameShop'],
      img: jsonData['img'],
      imgBg: jsonData['imgBg'],
      ratingShop: double.parse(jsonData['ratingShop'].toString()),
      follow: jsonData['follow'].toString(),
      sumproduct: jsonData['sumproduct'].toString(),
      description: jsonData['description'],
      address: jsonData['address'],
      phone: jsonData['phone'],
      email: jsonData['email'],
      fee: NumberFormat("#,###", "pt_BR")
              .format(double.parse(jsonData['fee'].toString())) +
          " ₫",
      price: NumberFormat("#,###", "pt_BR")
              .format(double.parse(jsonData['price'].toString())) +
          " ₫",
      createshop: DateTime.parse(jsonData['createshop']),
    );
  }
}
