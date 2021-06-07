import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_verification_code/generated/i18n.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/Popular_product.dart';
import 'package:shop_app/models/profileShop.dart';
import 'package:shop_app/models/request.dart';
import 'package:shop_app/profileshop/components/information.dart';
import 'package:shop_app/profileshop/profile_screen.dart';
import 'package:shop_app/size_config.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../constants.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  const Body({Key key, @required this.product, this.page}) : super(key: key);
  final Product product;
  final int page;

  @override
  _BodyState createState() => _BodyState(product: product, page: page);
}

class _BodyState extends State<Body> {
  _BodyState({this.product, this.page});
  Product product;
  int page;
  int numOfItems = 1;
  var rating = 3.5;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<bool> futureFollow;
  Future<void> checkfutureFollow;
  Future<int> countFollow;

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("cancel".tr().toString()),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("confirm".tr().toString()),
      onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var username = prefs?.getString("username");

        try {
          final response = await http.post(url + "ratingproduct", body: {
            "username": username,
            "id": json.encode(product.id),
            "rating": json.encode(rating),
          });
          print(response.body);
          if (response.statusCode == 200) {
            Navigator.pop(context);
            final snackBar = SnackBar(
              content: Text('successful product reviews'.tr().toString()),
              duration: Duration(seconds: 2),
              action: new SnackBarAction(
                label: 'success'.tr().toString(),
                onPressed: () {
                  // Some code to undo the change!
                },
              ),
            );
            Scaffold.of(context).showSnackBar(snackBar);
          } else if (response.statusCode == 201) {
            Navigator.pop(context);
            final snackBar = SnackBar(
              content:
                  Text('you have already rated this product'.tr().toString()),
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
        } catch (e) {
          print(e);
        }
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("evaluate".tr().toString()),
      content: Text("confirmed reviews of this product?".tr().toString()),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    countFollow = downloadCountFollow(product.shopCode);
    return FutureBuilder<Shop>(
        future: downloadJSONShop(product.shopCode),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Shop shop = snapshot.data;
            futureFollow = downloadFollow(shop.id);

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
                                ),
                              ),
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
                                          ": " +
                                          shop.price,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          getProportionateScreenHeight(20),
                                    ),
                                    child: Text(shop.price.isEmpty
                                        ? SizedBox()
                                        : "buy on".tr().toString() +
                                            " " +
                                            shop.fee +
                                            "exempt from ship".tr().toString()),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            getProportionateScreenHeight(20),
                                        vertical:
                                            getProportionateScreenHeight(10)),
                                    child: Row(
                                      children: [
                                        Text(
                                          "evaluate".tr().toString() + ": ",
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                        SmoothStarRating(
                                          rating: product.rating,
                                          isReadOnly: false,
                                          size: 26,
                                          filledIconData: Icons.star,
                                          halfFilledIconData: Icons.star_half,
                                          defaultIconData: Icons.star_border,
                                          starCount: 5,
                                          allowHalfRating: true,
                                          spacing: 2.0,
                                          onRated: (value) {
                                            rating = value;
                                          },
                                        ),
                                        InkWell(
                                          onTap: () {
                                            showAlertDialog(context);
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left:
                                                    getProportionateScreenWidth(
                                                        20)),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.green,
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(
                                                    getProportionateScreenHeight(
                                                        4.5)),
                                                child: Text(
                                                  "confirm".tr().toString(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
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
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            getProportionateScreenHeight(5),
                                        horizontal:
                                            getProportionateScreenWidth(20)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () => Navigator.pushNamed(
                                            context,
                                            ServieProfileScreen.routeName,
                                            arguments: ShopDetailsArguments(
                                                id: shop,
                                                product: product,
                                                page: page),
                                          ),
                                          child: Row(children: [
                                            Container(
                                              height:
                                                  getProportionateScreenHeight(
                                                      70),
                                              width:
                                                  getProportionateScreenHeight(
                                                      70),
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    shop.img,
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  getProportionateScreenWidth(
                                                      20),
                                            ),
                                            Container(
                                              width:
                                                  getProportionateScreenWidth(
                                                      160),
                                              child: Text(
                                                shop.nameShop,
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
                                        FutureBuilder<bool>(
                                            future: futureFollow,
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return InkWell(
                                                  onTap: () {
                                                    downloadCheckFollow(
                                                        shop.id);
                                                    setState(() {
                                                      futureFollow =
                                                          downloadFollow(
                                                              shop.id);
                                                      countFollow =
                                                          downloadCountFollow(
                                                              product.shopCode);
                                                    });
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color:
                                                          snapshot.data == true
                                                              ? Colors.green
                                                              : Colors.red,
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.all(
                                                          getProportionateScreenHeight(
                                                              4.5)),
                                                      child: Text(
                                                        snapshot.data == true
                                                            ? "followed"
                                                                .tr()
                                                                .toString()
                                                            : "follow"
                                                                .tr()
                                                                .toString(),
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              } else if (snapshot.hasError) {
                                                return Text(
                                                    "${snapshot.error}");
                                              } else {
                                                return Container();
                                              }
                                            }),
                                      ],
                                    ),
                                  ),
                                  FutureBuilder<int>(
                                      future: countFollow,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Information(
                                            rate: shop.ratingShop,
                                            sumproduct: shop.sumproduct,
                                            follow: snapshot.data.toString(),
                                          );
                                        }
                                      })
                                ],
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
                        text: "add To Cart".tr().toString(),
                        press: () {
                          if ((demoCarts.where(
                                  (element) => element.product == product))
                              .isEmpty) {
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
