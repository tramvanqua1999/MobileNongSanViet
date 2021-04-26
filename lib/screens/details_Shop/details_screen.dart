import 'package:flutter/material.dart';
import 'package:shop_app/models/profileShop.dart';

import '../../models/Popular_product.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';

class DetailsScreenShop extends StatelessWidget {
  static String routeName = "/detailsShop";

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments agrs =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: CustomAppBar(
          rating: agrs.product.rating, shop: agrs.shop, product: agrs.product),
      body: Body(product: agrs.product, shop: agrs.shop),
    );
  }
}

class ProductDetailsArguments {
  final Product product;
  final Shop shop;

  ProductDetailsArguments({@required this.product, @required this.shop});
}
