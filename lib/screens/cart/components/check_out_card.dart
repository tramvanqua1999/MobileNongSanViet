// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shop_app/components/default_button.dart';
// import 'package:shop_app/models/Cart.dart';

// import '../../../constants.dart';
// import '../../../size_config.dart';
// import 'package:http/http.dart' as http;

// class CheckoutCard extends StatefulWidget {
//   const CheckoutCard({
//     Key key,
//     @required this.totals,
//   }) : super(key: key);
//   final double totals;
//   @override
//   _CheckoutCardState createState() => _CheckoutCardState(totals);
// }

// class _CheckoutCardState extends State<CheckoutCard> {
//   _CheckoutCardState(this.totals);
//   double totals;
//   var _listKey = GlobalKey<AnimatedListState>();
//   Future<void> _order() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final username = prefs?.getString("username");

//     var arrproductcode = new List();
//     var arramount = new List();

//     for (var s in demoCarts) {
//       arrproductcode.add(s.product.id);
//       arramount.add(s.numOfItem);
//     }

//     try {
//       final response = await http.post(url + "order", body: {
//         "username": username,
//         "arrproductcode": json.encode(arrproductcode),
//         "arramount": json.encode(arramount)
//       });
//       print(response.body);

//       if (response.statusCode == 200) {
//       } else {}
//     } catch (e) {}
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(
//         vertical: getProportionateScreenWidth(15),
//         horizontal: getProportionateScreenWidth(30),
//       ),
//       // height: 174,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(30),
//           topRight: Radius.circular(30),
//         ),
//         boxShadow: [
//           BoxShadow(
//             offset: Offset(0, -15),
//             blurRadius: 20,
//             color: Color(0xFFDADADA).withOpacity(0.15),
//           )
//         ],
//       ),
//       child: SafeArea(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(10),
//                   height: getProportionateScreenWidth(40),
//                   width: getProportionateScreenWidth(40),
//                   decoration: BoxDecoration(
//                     color: Color(0xFFF5F6F9),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: SvgPicture.asset("assets/icons/receipt.svg"),
//                 ),
//                 Spacer(),
//                 // Text("Add voucher code"),
//                 const SizedBox(width: 10),
//                 // Icon(
//                 //   Icons.arrow_forward_ios,
//                 //   size: 12,
//                 //   color: kTextColor,
//                 // )
//               ],
//             ),
//             SizedBox(height: getProportionateScreenHeight(20)),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text.rich(
//                   TextSpan(
//                     text: "Tổng tiền:\n",
//                     children: [
//                       TextSpan(
//                         text: "${totals.toString()}",
//                         style: TextStyle(fontSize: 16, color: Colors.black),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   width: getProportionateScreenWidth(190),
//                   child: DefaultButton(
//                     height: 56,
//                     text: "Thanh toán",
//                     press: () {
//                       // _order();
//                       setState(() {
//                         demoCarts.clear();
//                       });
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
