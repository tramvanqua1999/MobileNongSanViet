import 'package:flutter/material.dart';

import '../../models/Popular_product.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments agrs =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: CustomAppBar(product: agrs.product, page: agrs.page),
      body: Body(product: agrs.product, page: agrs.page),
    );
  }
}

class ProductDetailsArguments {
  final Product product;
  final int page;

  ProductDetailsArguments({@required this.product, this.page});
}
