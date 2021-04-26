import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/models/Popular_product.dart';
import 'package:shop_app/models/request.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/screens/home/components/section_title.dart';
import 'package:shop_app/size_config.dart';

import '../../../constants.dart';

class ListProduct extends StatefulWidget {
  // final List<Product> demoProducts = [];

  @override
  _ListProductState createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  double aspectRetio = 0.7;
  Future<List<Product>> productFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productFuture = downloadJSONProduct();
    // print(productFuture);
  }

  Future<bool> checkfavorFuture;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SectionTitle(
          title: "Tất cả sản phẩm",
          press: () {},
          icon: Icons.arrow_drop_down,
        ),
      ),
      SizedBox(
        height: getProportionateScreenWidth(20),
      ),
      Padding(
        padding: const EdgeInsets.all(15),
        child: FutureBuilder<List<Product>>(
            future: productFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Product> demoProducts = snapshot.data;
                // print(demoProducts);
                return GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: aspectRetio),
                  itemBuilder: (BuildContext context, int index) {
                    checkfavorFuture = downloadFavorite(demoProducts[index].id);
                    return Padding(
                        padding: EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: () => Navigator.pushNamed(
                            context,
                            DetailsScreen.routeName,
                            arguments: ProductDetailsArguments(
                                product: demoProducts[index], page: 1),
                          ),
                          child: Container(
                              padding: EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12, blurRadius: 8.0)
                                  ]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: getProportionateScreenHeight(150),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: Stack(
                                            children: [
                                              Hero(
                                                tag: demoProducts[index]
                                                    .id
                                                    .toString(),
                                                child: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(15),
                                                            topRight:
                                                                Radius.circular(
                                                                    15)),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          demoProducts[index]
                                                              .images[0]),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              demoProducts[index].discount !=
                                                          0 &&
                                                      demoProducts[index]
                                                              .lastday
                                                              .difference(
                                                                  DateTime
                                                                      .now())
                                                              .inDays >
                                                          1
                                                  ? Positioned(
                                                      top: 0,
                                                      right: 0,
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Colors.pink[50],
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    15),
                                                          ),
                                                        ),
                                                        height:
                                                            getProportionateScreenHeight(
                                                                20),
                                                        width:
                                                            getProportionateScreenWidth(
                                                                40),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 4),
                                                          child: Text(
                                                            '-' +
                                                                "${demoProducts[index].discount.toString()}" +
                                                                '%',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Container()
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      "${demoProducts[index].name}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                  // ----------------------Start discount-----------------
                                  demoProducts[index].discount != 0 &&
                                          demoProducts[index]
                                                  .lastday
                                                  .difference(DateTime.now())
                                                  .inDays >
                                              1
                                      ? Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10.0),
                                              child: Text(
                                                "${demoProducts[index].priceDiscount}",
                                                style: TextStyle(
                                                  fontSize:
                                                      getProportionateScreenWidth(
                                                          15),
                                                  fontWeight: FontWeight.w600,
                                                  color: kPrimaryColor,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10.0),
                                              child: Text(
                                                "${demoProducts[index].price.toString()}",
                                                style: TextStyle(
                                                  fontSize:
                                                      getProportionateScreenWidth(
                                                          11),
                                                  color: Colors.grey[300],
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Padding(
                                          padding: EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            "${demoProducts[index].price.toString()}",
                                            style: TextStyle(
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      15),
                                              fontWeight: FontWeight.w600,
                                              color: kPrimaryColor,
                                            ),
                                          ),
                                        ),
                                  // ----------------------END discount-----------------
                                  Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        RatingBarIndicator(
                                          rating: demoProducts[index].rating,
                                          itemBuilder: (context, index) => Icon(
                                            Icons.star,
                                            color: Colors.yellow[600],
                                          ),
                                          itemCount: 5,
                                          itemSize: 15.0,
                                          direction: Axis.horizontal,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: Container(
                                            child: FutureBuilder<bool>(
                                              future: checkfavorFuture,
                                              builder: (context, snapshot) {
                                                // print(snapshot.data);
                                                if (snapshot.hasData) {
                                                  return InkWell(
                                                    onTap: () {
                                                      downloadCheckFavorite(
                                                          demoProducts[index]
                                                              .id,
                                                          snapshot.data);
                                                      setState(() {
                                                        checkfavorFuture =
                                                            downloadFavorite(
                                                                demoProducts[
                                                                        index]
                                                                    .id);
                                                      });
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.all(
                                                        getProportionateScreenWidth(
                                                            8),
                                                      ),
                                                      height:
                                                          getProportionateScreenWidth(
                                                              28),
                                                      width:
                                                          getProportionateScreenWidth(
                                                              28),
                                                      decoration: BoxDecoration(
                                                        color: snapshot.data
                                                            ? kPrimaryColor
                                                                .withOpacity(
                                                                    0.15)
                                                            : kSecondaryColor
                                                                .withOpacity(
                                                                    0.1),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: SvgPicture.asset(
                                                        "assets/icons/Heart Icon_2.svg",
                                                        color: snapshot.data
                                                            ? Color(0xFFFF4848)
                                                            : Color(0xFFDBDEE4),
                                                      ),
                                                    ),
                                                  );
                                                }
                                                return new CircularProgressIndicator();
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ));
                  },
                  itemCount: demoProducts.length,
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              //return  a circular progress indicator.
              return new CircularProgressIndicator();
            }),
      )
    ]);
  }
}
