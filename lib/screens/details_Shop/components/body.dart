import 'package:flutter/material.dart';
// import 'package:flutter_verification_code/generated/i18n.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/Popular_product.dart';
import 'package:shop_app/models/profileShop.dart';
import 'package:shop_app/models/request.dart';
import 'package:shop_app/size_config.dart';

import 'cart_counter.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatefulWidget {
  const Body({Key key, @required this.product, @required this.shop})
      : super(key: key);
  final Product product;
  final Shop shop;

  @override
  _BodyState createState() => _BodyState(product: product, shop: shop);
}

class _BodyState extends State<Body> {
  _BodyState({this.product, this.shop});
  Product product;
  Shop shop;
  int numOfItems = 1;

  @override
  void initState() {
    super.initState();
  }

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
                          child: Row(
                            children: <Widget>[
                              buildOutlineButton(
                                icon: Icons.remove,
                                press: () {
                                  if (numOfItems > 1) {
                                    setState(() {
                                      numOfItems--;
                                    });
                                  }
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: Text(
                                  // if our item is less  then 10 then  it shows 01 02 like that
                                  numOfItems.toString().padLeft(2, "0"),
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                              buildOutlineButton(
                                  icon: Icons.add,
                                  press: () {
                                    setState(() {
                                      numOfItems == product.amount
                                          ? numOfItems
                                          : numOfItems++;
                                    });
                                  }),
                            ],
                          )),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      FutureBuilder<Shop>(
                          future: downloadJSONShop(product.shopCode),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              Shop shop = snapshot.data;

                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          getProportionateScreenHeight(20),
                                    ),
                                    child: Text(
                                      "Lưu ý: \n" + "Phí ship : " + shop.price,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          getProportionateScreenHeight(20),
                                    ),
                                    child: Text(
                                      shop.price.isEmpty
                                          ? SizedBox()
                                          : "Mua hàng trên " +
                                              shop.fee +
                                              " được free ship",
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            getProportionateScreenHeight(10)),
                                    child: Container(
                                      height: getProportionateScreenHeight(2),
                                      color: Color(0xFFEFF4F7),
                                    ),
                                  ),
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            } else {
                              return Container();
                            }
                          }),
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
                press: () {
                  demoCarts.add(Cart(product: product, numOfItem: numOfItems));
                },
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  SizedBox buildOutlineButton({IconData icon, Function press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlineButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        onPressed: press,
        child: Icon(icon),
      ),
    );
  }
}
