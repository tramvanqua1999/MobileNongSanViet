import 'package:flutter/material.dart';
import 'package:shop_app/models/Popular_product.dart';
import 'package:shop_app/models/profileShop.dart';

import 'components/custom_app_bar.dart';
import 'components/profile_body.dart';

class ServieProfileScreen extends StatefulWidget {
  static String routeName = "/shop_profile";

  @override
  _ServieProfileScreenState createState() => _ServieProfileScreenState();
}

class _ServieProfileScreenState extends State<ServieProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final ShopDetailsArguments agrs = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: CustomAppBar(product: agrs.product, page: agrs.page),
      body: ShopProfilePage(
        shop: agrs.id,
      ),
    );
  }
}

class ShopDetailsArguments {
  final Shop id;
  final Product product;
  final int page;

  ShopDetailsArguments({@required this.id, this.product, this.page});
}
