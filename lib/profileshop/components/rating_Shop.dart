import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';

class RatingShop extends StatefulWidget {
  @override
  _RatingShopState createState() => _RatingShopState();
}

class _RatingShopState extends State<RatingShop> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(40)),
            child: Container(
              width: getProportionateScreenWidth(300),
              child: Card(
                color: Colors.white,
                elevation: 4.0,
                child: ListTile(
                  leading: Icon(
                    Icons.create_rounded,
                    color: kPrimaryColor,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        width: getProportionateScreenWidth(150),
                        child: Text(
                          "Nhập bình luận",
                        ),
                      ),
                    ],
                  ),
                  onTap: () async {
                    // _showComment(context, serviceModel);
                  },
                ),
              ),
            ),
          )
        ]);
  }
}

// Future<void> _showComment(BuildContext context, ServiceModel serviceModel) {
//   var rating = 1.0;
//   TextEditingController cmntController = TextEditingController();
//   return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(32.0))),
//           contentPadding: EdgeInsets.only(top: 10.0),
//           content: Container(
//             width: 300.0,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     Text(
//                       "Rate",
//                       style: TextStyle(fontSize: 24.0),
//                     ),
//                     SmoothStarRating(
//                       rating: rating,
//                       isReadOnly: false,
//                       size: 26,
//                       filledIconData: Icons.star,
//                       halfFilledIconData: Icons.star_half,
//                       defaultIconData: Icons.star_border,
//                       starCount: 5,
//                       allowHalfRating: true,
//                       spacing: 2.0,
//                       onRated: (value) {
//                         rating = value;
//                         // print("rating value dd -> ${value.truncate()}");
//                       },
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 5.0,
//                 ),
//                 Divider(
//                   color: Colors.grey,
//                   height: 4.0,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(left: 30.0, right: 30.0),
//                   child: TextField(
//                     controller: cmntController,
//                     decoration: InputDecoration(
//                       hintText: "Add Review",
//                       border: InputBorder.none,
//                     ),
//                     maxLines: 8,
//                   ),
//                 ),
//                 InkWell(
//                   child: Container(
//                     padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
//                     decoration: BoxDecoration(
//                       color: kPrimaryColor,
//                       borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(32.0),
//                           bottomRight: Radius.circular(32.0)),
//                     ),
//                     child: Text(
//                       "Bình Luận",
//                       style: TextStyle(color: Colors.white),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   onTap: () async {
//                     SharedPreferences prefs =
//                         await SharedPreferences.getInstance();
//                     var username = prefs?.getString("username");

//                     try {
//                       final response = await http.post(url + "comment", body: {
//                         "username": username,
//                         "comment": cmntController.text,
//                         "serviceId": json.encode(serviceModel.username),
//                         "rating": json.encode(rating),
//                       });
//                       print(response.body);
//                       if (response.statusCode == 200) {
//                         setState(() {
//                           commentModel =
//                               downloadJSONComment(serviceModel.username);
//                         });
//                         Navigator.pop(context);
//                       }
//                     } catch (e) {
//                       print(e);
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       });
// }
