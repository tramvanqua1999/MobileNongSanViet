import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/screens/payment/payment_screen.dart';
import 'package:shop_app/screens/products/products_screen.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'cart_card.dart';
import 'package:intl/intl.dart';

class Body extends StatefulWidget {
  Body({
    Key key,
    this.callback,
  }) : super(key: key);
  final Function callback;

  @override
  _BodyState createState() => _BodyState(callback);
}

class _BodyState extends State<Body> {
  Function callback;

  _BodyState(this.callback);
  double totals;

  var _listKey = GlobalKey<AnimatedListState>();
  @override
  void initState() {
    totals = 0;

    for (var s in demoCarts) {
      setState(() {
        totals = totals +
            double.parse(NumberFormat("#,###", "pt_BR")
                .format((s.priceship))
                .toString()) +
            double.parse(s.product.priceDiscount.replaceAll(' ₫', '')) *
                s.numOfItem;
      });
      print(s.priceship);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: demoCarts.length,
              itemBuilder: (context, index) {
                getTotals(demoCarts[index]);
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Dismissible(
                    key: Key(demoCarts[index].product.id.toString()),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        demoCarts.removeAt(index);
                        demoCarts.toList();
                        callback(demoCarts.length);
                        // print(CartScreen.of(context).count);
                        totals = 0;
                        for (var s in demoCarts) {
                          setState(() {
                            totals = totals +
                                double.parse(NumberFormat("#,###", "pt_BR")
                                    .format((s.priceship))
                                    .toString()) +
                                double.parse(s.product.priceDiscount
                                        .replaceAll(' ₫', '')) *
                                    s.numOfItem;
                          });
                        }
                      });
                    },
                    background: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFE6E6),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Spacer(),
                          SvgPicture.asset("assets/icons/Trash.svg"),
                        ],
                      ),
                    ),
                    child: CartCard(cart: demoCarts[index]),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenWidth(15),
              horizontal: getProportionateScreenWidth(30),
            ),
            // height: 174,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, -15),
                  blurRadius: 20,
                  color: Color(0xFFDADADA).withOpacity(0.15),
                )
              ],
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        height: getProportionateScreenWidth(40),
                        width: getProportionateScreenWidth(40),
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F6F9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SvgPicture.asset("assets/icons/receipt.svg"),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, ProductScreen.routeName);
                        },
                        child: Row(
                          children: [
                            Text(
                              "continue to buy".tr().toString(),
                              style: TextStyle(
                                color: Colors.red[500],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: Colors.red[500],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: "total money".tr().toString() + ":\n",
                          children: [
                            TextSpan(
                              // text: "${totals.toString()}",
                              text: NumberFormat("#,###", "pt_BR").format(
                                      double.parse(
                                          (totals * 1000).toString())) +
                                  " ₫",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(190),
                        child: DefaultButton(
                          height: 56,
                          text: "pay".tr().toString(),
                          press: () {
                            showAlertDialog(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  getTotals(Cart demoCarts) {
    totals = totals +
        double.parse(NumberFormat("#,###", "pt_BR")
            .format((demoCarts.priceship))
            .toString()) +
        double.parse(demoCarts.product.priceDiscount.replaceAll(' ₫', '')) *
            demoCarts.numOfItem;
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Trả sau"),
      onPressed: () {
        _order();
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Trả trước"),
      onPressed: () async {
        if (demoCarts.length > 0) {
          Navigator.pushNamed(context, PaymentScreen.routeName);
        } else {
          Alert(
            context: context,
            type: AlertType.warning,
            title: "Order Fail".tr().toString(),
            desc: "no products".tr().toString(),
            buttons: [
              DialogButton(
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                width: 50,
              )
            ],
          ).show();
        }
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Chọn hình thức thanh toán"),
      content: Text("Trả trước hoặc trả sau qua thẻ ngân hàng !!"),
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

  //  _order();
  Future<void> _order() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs?.getString("username");

    var arrproductcode = new List();
    var arramount = new List();
    var price = new List();
    var priceship = new List();
    // print(demoCarts.length);
    if (demoCarts.length > 0) {
      for (var s in demoCarts) {
        arrproductcode.add(s.product.id);
        arramount.add(s.numOfItem);
        priceship.add(s.priceship);
        print(s.priceship);
        if (s.product.lastday.difference(DateTime.now()).inDays < 1) {
          price.add(double.parse(s.product.price.replaceAll(' ₫', '')));
          // print(double.parse(s.product.price.replaceAll(' ₫', '')));
        } else {
          price.add(double.parse(s.product.priceDiscount.replaceAll(' ₫', '')));
          // print(double.parse(s.product.priceDiscount.replaceAll(' ₫', '')));
        }
      }

      try {
        final response = await http.post(url + "order", body: {
          "username": username,
          "arrproductcode": json.encode(arrproductcode),
          "arramount": json.encode(arramount),
          "price": json.encode(price),
          "priceship": json.encode(priceship)
        });
        // print(response.body);

        if (response.statusCode == 200) {
          Alert(
            context: context,
            type: AlertType.success,
            title: "Order Success".tr().toString(),
            desc: "",
            buttons: [
              DialogButton(
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                width: 50,
              )
            ],
          ).show();
          setState(() {
            demoCarts.clear();
            setState(() => _listKey = GlobalKey());
            totals = 0;
            for (var s in demoCarts) {
              setState(() {
                totals = totals +
                    double.parse(s.product.priceDiscount.replaceAll(' ₫', '')) *
                        s.numOfItem;
              });
            }
            callback(demoCarts.length);
          });
        } else {}
      } catch (e) {}
    } else {
      Alert(
        context: context,
        type: AlertType.warning,
        title: "Order Fail".tr().toString(),
        desc: "no products".tr().toString(),
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 50,
          )
        ],
      ).show();
    }
  }
}
