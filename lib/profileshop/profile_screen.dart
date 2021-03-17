import 'package:flutter/material.dart';
import 'package:shop_app/models/Shop.dart';

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
      appBar: CustomAppBar(),
      body: ShopProfilePage(
        shop: agrs.shop,
      ),
    );
  }
}

class ShopDetailsArguments {
  final Shop shop;

  ShopDetailsArguments({@required this.shop});
}
