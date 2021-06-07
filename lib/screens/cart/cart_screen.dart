import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../enums.dart';
import 'components/body.dart';

class CartScreen extends StatefulWidget {
  static String routeName = "/cart";

  @override
  State<CartScreen> createState() => new _CartScreenState();
  static _CartScreenState of(BuildContext context) =>
      context.findAncestorStateOfType<_CartScreenState>();
}

class _CartScreenState extends State<CartScreen> {
  int count;
  function(value) => setState(() => count = value);
  @override
  Widget build(BuildContext context) {
    count = demoCarts.length;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            "assets/icons/Cart Icon.svg",
          ),
          iconSize: 20.0,
          onPressed: () {},
        ),
        title: Column(
          children: [
            Text(
              "cart".tr().toString(),
              style: TextStyle(color: Colors.black),
            ),
            Text(
              "${count.toString()} " + "product".tr().toString(),
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
      body: Body(callback: (val) => setState(() => count = val)),
      // bottomNavigationBar: CheckoutCard(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.cart),
    );
  }
}
