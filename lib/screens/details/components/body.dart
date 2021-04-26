import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
// import 'package:flutter_verification_code/generated/i18n.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/Popular_product.dart';
import 'package:shop_app/models/profileShop.dart';
import 'package:shop_app/models/request.dart';
import 'package:shop_app/profileshop/components/information.dart';
import 'package:shop_app/profileshop/profile_screen.dart';
import 'package:shop_app/size_config.dart';

import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<bool> futureFollow;
  Future<void> checkfutureFollow;
  Future<int> countFollow;

  @override
  Widget build(BuildContext context) {
    countFollow = downloadCountFollow(product.shopCode);
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
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      FutureBuilder<Shop>(
                          future: downloadJSONShop(product.shopCode),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              Shop shop = snapshot.data;
                              futureFollow = downloadFollow(shop.id);

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
                                                  image: AssetImage(
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
                                                            ? " Đã theo dõi "
                                                            : " Theo dõi ",
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
                              );
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            } else {
                              return Container();
                            }
                          }),
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
                press: () {
                  if ((demoCarts.where((element) => element.product == product))
                      .isEmpty) {
                    demoCarts
                        .add(Cart(product: product, numOfItem: numOfItems));
                    final snackBar = SnackBar(
                      content: Text('Thêm vào giỏ hàng thành công'),
                      duration: Duration(seconds: 2),
                      action: new SnackBarAction(
                        label: 'Success',
                        onPressed: () {
                          // Some code to undo the change!
                        },
                      ),
                    );
                    Scaffold.of(context).showSnackBar(snackBar);
                  } else {
                    final snackBar = SnackBar(
                      content: Text('Sản phẩm đã được thêm vào giỏ hàng'),
                      duration: Duration(seconds: 2),
                      action: new SnackBarAction(
                        label: 'Fail',
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
