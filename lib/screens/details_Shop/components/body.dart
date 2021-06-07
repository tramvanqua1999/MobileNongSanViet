import 'package:flutter/material.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/Popular_product.dart';
import 'package:shop_app/models/profileShop.dart';
import 'package:shop_app/models/request.dart';
import 'package:shop_app/size_config.dart';
import 'package:easy_localization/easy_localization.dart';

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
    return FutureBuilder<Shop>(
        future: downloadJSONShop(product.shopCode),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Shop shop = snapshot.data;

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
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
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
                              SizedBox(
                                  height: getProportionateScreenHeight(10)),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          getProportionateScreenHeight(20),
                                    ),
                                    child: Text(
                                      "note".tr().toString() +
                                          ": \n" +
                                          "shipping fee".tr().toString() +
                                          " : " +
                                          shop.price,
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
                                          : "buy on".tr().toString() +
                                              " " +
                                              shop.fee +
                                              " " +
                                              "exempt from ship"
                                                  .tr()
                                                  .toString(),
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
                        text: "add To Cart".tr().toString(),
                        press: () {
                          if ((demoCarts.where(
                                  (element) => element.product == product))
                              .isEmpty) {
                            // print(double.parse(product.priceDiscount
                            //         .replaceAll(' ₫', '')) *
                            //     numOfItems *
                            //     1000);
                            // print(double.parse(shop.fee.replaceAll(' ₫', '')));
                            // print(double.parse(shop.fee.replaceAll(' ₫', '')) *
                            //     1000);
                            if (double.parse(product.priceDiscount
                                        .replaceAll(' ₫', '')) *
                                    numOfItems *
                                    1000 >=
                                double.parse(shop.fee.replaceAll(' ₫', '')) *
                                    1000) {
                              demoCarts.add(Cart(
                                  product: product,
                                  numOfItem: numOfItems,
                                  priceship: 0));
                            } else {
                              demoCarts.add(Cart(
                                  product: product,
                                  numOfItem: numOfItems,
                                  priceship: double.parse(
                                          shop.price.replaceAll(' ₫', '')) *
                                      1000));
                            }

                            final snackBar = SnackBar(
                              content: Text(
                                  'add to cart successfully'.tr().toString()),
                              duration: Duration(seconds: 2),
                              action: new SnackBarAction(
                                label: 'success'.tr().toString(),
                                onPressed: () {
                                  // Some code to undo the change!
                                },
                              ),
                            );
                            Scaffold.of(context).showSnackBar(snackBar);
                          } else {
                            final snackBar = SnackBar(
                              content: Text('the product has been added to cart'
                                  .tr()
                                  .toString()),
                              duration: Duration(seconds: 2),
                              action: new SnackBarAction(
                                label: 'failure'.tr().toString(),
                                onPressed: () {
                                  // Some code to undo the change!
                                },
                              ),
                            );
                            Scaffold.of(context).showSnackBar(snackBar);
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ]);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else {
            return Container();
          }
        });
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
