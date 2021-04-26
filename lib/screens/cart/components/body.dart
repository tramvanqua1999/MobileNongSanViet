import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:http/http.dart' as http;

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
            double.parse(s.product.priceDiscount.replaceAll(' ₫', '')) *
                s.numOfItem;
      });
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
                      // Text("Add voucher code"),
                      const SizedBox(width: 10),
                      // Icon(
                      //   Icons.arrow_forward_ios,
                      //   size: 12,
                      //   color: kTextColor,
                      // )
                    ],
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: "Tổng tiền:\n",
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
                          text: "Thanh toán",
                          press: () {
                            // _order();
                            Alert(
                              context: context,
                              type: AlertType.success,
                              title: "Đặt hàng thành công",
                              desc: "",
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "OK",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
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
                                      double.parse(s.product.priceDiscount
                                              .replaceAll(' ₫', '')) *
                                          s.numOfItem;
                                });
                              }
                              callback(demoCarts.length);
                            });
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
        double.parse(demoCarts.product.priceDiscount.replaceAll(' ₫', '')) *
            demoCarts.numOfItem;
  }

  Future<void> _order() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs?.getString("username");

    var arrproductcode = new List();
    var arramount = new List();

    for (var s in demoCarts) {
      arrproductcode.add(s.product.id);
      arramount.add(s.numOfItem);
    }

    try {
      final response = await http.post(url + "order", body: {
        "username": username,
        "arrproductcode": json.encode(arrproductcode),
        "arramount": json.encode(arramount)
      });
      print(response.body);

      if (response.statusCode == 200) {
      } else {}
    } catch (e) {}
  }
}
