import 'package:flutter/material.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/models/Popular_product.dart';
import 'package:shop_app/models/Shop.dart';
import 'package:shop_app/profileshop/components/information.dart';
import 'package:shop_app/profileshop/profile_screen.dart';
import 'package:shop_app/size_config.dart';

import 'cart_counter.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatelessWidget {
  final Product product;
  Shop demoShops = Shop(
    id: 1,
    images: [
      "assets/images/huy.jpg",
    ],
    title: "HuyKaisoul™",
    rating: 3.1,
    description:
        "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing  …",
    isFollow: true,
  );

  Body({
    Key key,
    @required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SingleChildScrollView(
        child: Stack(children: [
          SafeArea(
            child: Column(
              children: <Widget>[
                ProductImages(product: product),
                SizedBox(
                  height: getProportionateScreenHeight(8),
                ),
                TopRoundedContainer(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      ProductDescription(
                        product: product,
                        pressOnSeeMore: () {},
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: getProportionateScreenWidth(20),
                        ),
                        child: CartCounter(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: getProportionateScreenHeight(10)),
                        child: Container(
                          height: getProportionateScreenHeight(2),
                          color: Color(0xFFEFF4F7),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: getProportionateScreenHeight(5),
                            horizontal: getProportionateScreenWidth(20)),
                        child: Row(
                          children: <Widget>[
                            InkWell(
                              onTap: () => Navigator.pushNamed(
                                context,
                                ServieProfileScreen.routeName,
                                arguments:
                                    ShopDetailsArguments(shop: demoShops),
                              ),
                              child: Row(children: [
                                Container(
                                  height: getProportionateScreenHeight(70),
                                  width: getProportionateScreenHeight(70),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/huy.jpg',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                SizedBox(
                                  width: getProportionateScreenWidth(20),
                                ),
                                Container(
                                  width: getProportionateScreenWidth(100),
                                  child: Text(
                                    "HuyKaisoul",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ]),
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(100),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Text(
                                "Theo dõi",
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Information(
                        rate: demoShops.rating,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: getProportionateScreenHeight(2)),
                        child: Container(
                          height: getProportionateScreenHeight(2),
                          color: Color(0xFFEFF4F7),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(100),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
      Positioned(
        bottom: 0,
        child: Container(
          height: 80,
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
            color: Color(0xFFDBDEE4),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: SizeConfig.screenWidth * 0.15,
              right: SizeConfig.screenWidth * 0.15,
              bottom: getProportionateScreenWidth(10),
              top: getProportionateScreenWidth(10),
            ),
            child: Container(
              child: DefaultButton(
                height: 200,
                text: "Add To Cart",
                press: () {},
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
