import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/models/Popular_product.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/list_favorite/list_favorite_screen.dart';
import 'package:shop_app/screens/products/products_screen.dart';

import '../../../size_config.dart';

class CustomAppBar extends PreferredSize {
  final Product product;
  final int page;

  CustomAppBar({@required this.product, this.page});

  @override
  // AppBar().preferredSize.height provide us the height that appy on our app bar
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Row(
          children: [
            SizedBox(
              height: getProportionateScreenWidth(40),
              width: getProportionateScreenWidth(40),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
                color: Colors.white,
                padding: EdgeInsets.zero,
                onPressed: () async {
                  // SharedPreferences prefs =
                  //     await SharedPreferences.getInstance();
                  page == 1
                      ? Navigator.pushNamed(context, HomeScreen.routeName)
                      : page == 2
                          ? Navigator.pushNamed(
                              context, ProductScreen.routeName)
                          : page == 20
                              ? Navigator.pushNamed(
                                  context, ListFavoriteScreen.routeName)
                              : Navigator.pop(context);
                },
                child: SvgPicture.asset(
                  "assets/icons/Back ICon.svg",
                  height: 15,
                ),
              ),
            ),
            Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Text(
                    "${product.rating}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SvgPicture.asset("assets/icons/Star Icon.svg"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
