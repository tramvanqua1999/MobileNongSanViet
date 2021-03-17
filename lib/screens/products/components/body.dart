import 'package:flutter/material.dart';
import 'package:shop_app/screens/home/components/categories.dart';
import 'package:shop_app/screens/home/components/categoriesfirst.dart';
import 'package:shop_app/screens/home/components/home_header.dart';
import 'package:shop_app/screens/home/components/list_product.dart';

import '../../../size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(10)),
            Categoriesfirst(),
            Categories(),
            SizedBox(height: getProportionateScreenWidth(10)),
            ListProduct(),
          ],
        ),
      ),
    );
  }
}
