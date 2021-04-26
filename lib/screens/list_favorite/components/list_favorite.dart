import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/models/Popular_product.dart';

import 'package:shop_app/models/request.dart';
import 'package:shop_app/profileshop/profile_screen.dart';
import 'package:shop_app/screens/details/details_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ListFavorite extends StatefulWidget {
  @override
  _ListFavoriteState createState() => _ListFavoriteState();
}

class _ListFavoriteState extends State<ListFavorite> {
  Future<List<Product>> product;
  @override
  void initState() {
    super.initState();
    product = downloadJSONListProductFollow();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text("Sản phẩm đã thích", style: headingStyle),
      Padding(
        padding:
            EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
        child: Container(
          height: getProportionateScreenHeight(2),
          color: Color(0xFFEFF4F7),
        ),
      ),
      FutureBuilder<List<Product>>(
        future: product,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> product = snapshot.data;
            return ListView.builder(
              itemCount: product.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () => Navigator.pushNamed(
                          context,
                          DetailsScreen.routeName,
                          arguments: ProductDetailsArguments(
                              product: product[index], page: 20),
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
                                  backgroundImage:
                                      NetworkImage(product[index].images[0]),
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
                                          product[index].name,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        product[index].discount != 0 &&
                                                product[index]
                                                        .lastday
                                                        .difference(
                                                            DateTime.now())
                                                        .inDays >
                                                    1
                                            ? Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 0.0),
                                                    child: Text(
                                                      "${product[index].priceDiscount}",
                                                      style: TextStyle(
                                                        fontSize:
                                                            getProportionateScreenWidth(
                                                                15),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: kPrimaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10.0),
                                                    child: Text(
                                                      "${product[index].price.toString()}",
                                                      style: TextStyle(
                                                        fontSize:
                                                            getProportionateScreenWidth(
                                                                11),
                                                        color: Colors.grey[300],
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Padding(
                                                padding:
                                                    EdgeInsets.only(left: 0.0),
                                                child: Text(
                                                  "${product[index].price.toString()}",
                                                  style: TextStyle(
                                                    fontSize:
                                                        getProportionateScreenWidth(
                                                            15),
                                                    fontWeight: FontWeight.w600,
                                                    color: kPrimaryColor,
                                                  ),
                                                ),
                                              ),
                                        RatingBarIndicator(
                                          rating: product[index].rating,
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
                          // InkWell(
                          //   onTap: () {
                          //     // downloadCheckFollow(product[index].id);
                          //     // setState(() {
                          //     //   // shopFollow = downloadJSONListFollow();
                          //     // });
                          //   },
                          //   child: Text(
                          //     " ",
                          //     style: TextStyle(
                          //       color: Colors.red[500],
                          //       fontSize: 12,
                          //       fontWeight: FontWeight.bold,
                          //       decoration: TextDecoration.underline,
                          //       // fontWeight: widget.isMessageRead
                          //       //     ? FontWeight.bold
                          //       //     : FontWeight.normal
                          //     ),
                          //   ),
                          // ),
                          Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: InkWell(
                              onTap: () {
                                downloadCheckFavorite(product[index].id, true);
                                setState(() {
                                  product.removeAt(index);
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(
                                  getProportionateScreenWidth(8),
                                ),
                                height: getProportionateScreenWidth(28),
                                width: getProportionateScreenWidth(28),
                                decoration: BoxDecoration(
                                  color: kPrimaryColor.withOpacity(0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                  "assets/icons/Heart Icon_2.svg",
                                  color: Color(0xFFFF4848),
                                ),
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
