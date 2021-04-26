import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:shop_app/models/profileShop.dart';
import 'package:shop_app/models/request.dart';
import 'package:shop_app/profileshop/profile_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ListFollow extends StatefulWidget {
  @override
  _ListFollowState createState() => _ListFollowState();
}

class _ListFollowState extends State<ListFollow> {
  Future<List<Shop>> shopFollow;
  @override
  void initState() {
    super.initState();
    shopFollow = downloadJSONListFollow();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text("Đang theo dõi ", style: headingStyle),
      Padding(
        padding:
            EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
        child: Container(
          height: getProportionateScreenHeight(2),
          color: Color(0xFFEFF4F7),
        ),
      ),
      FutureBuilder<List<Shop>>(
        future: shopFollow,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Shop> shop = snapshot.data;
            return ListView.builder(
              itemCount: shop.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () => Navigator.pushNamed(
                          context,
                          ServieProfileScreen.routeName,
                          arguments:
                              ShopDetailsArguments(id: shop[index], page: 10),
                        ),
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 16, right: 16, top: 10, bottom: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage: AssetImage(shop[index].img),
                                  maxRadius: 30,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          shop[index].nameShop,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        RatingBarIndicator(
                                          rating: shop[index].ratingShop,
                                          itemBuilder: (context, index) => Icon(
                                            Icons.star,
                                            color: Colors.yellow[600],
                                          ),
                                          itemCount: 5,
                                          itemSize: 15.0,
                                          direction: Axis.horizontal,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              downloadCheckFollow(shop[index].id);
                              setState(() {
                                shopFollow = downloadJSONListFollow();
                              });
                            },
                            child: Text(
                              " Bỏ theo dõi",
                              style: TextStyle(
                                color: Colors.red[500],
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                // decoration: TextDecoration.underline,
                                // fontWeight: widget.isMessageRead
                                //     ? FontWeight.bold
                                //     : FontWeight.normal
                              ),
                            ),
                          ),
                        ],
                      ),
                    ));
              },
            );
          } else if (snapshot.hasError) {
            return Container();
          }
          return Center(child: CircularProgressIndicator());
        },
      )
    ]);
  }
}
