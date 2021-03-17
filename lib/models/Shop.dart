import 'package:flutter/material.dart';

class Shop {
  final int id;
  final String title, description;
  final List<String> images;
  double rating = 2.5;
  final bool isFollow;

  Shop({
    @required this.id,
    @required this.images,
    this.rating,
    this.isFollow = false,
    @required this.title,
    @required this.description,
  });
}

// Our demo Products

Shop demoShops = Shop(
  id: 1,
  images: [
    "assets/images/huy.jpg",
  ],
  title: "HuyKaisoul™",
  description:
      "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing  …",
  isFollow: true,
);
