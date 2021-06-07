import 'package:flutter/material.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/enums.dart';

import 'components/body.dart';

class ProductScreen extends StatelessWidget {
  static String routeName = "/product";
  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments agrs =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Body(search: agrs.search == null ? '' : agrs.search),
      bottomNavigationBar:
          CustomBottomNavBar(selectedMenu: MenuState.favourite),
    );
  }
}

class ProductDetailsArguments {
  final String search;

  ProductDetailsArguments({this.search});
}
