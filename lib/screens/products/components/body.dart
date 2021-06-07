import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/models/Popular_product.dart';
import 'package:shop_app/models/request.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/screens/home/components/categories.dart';
import 'package:shop_app/screens/home/components/icon_btn_with_counter.dart';
import 'package:shop_app/screens/home/components/section_title.dart';
import 'package:shop_app/screens/list_favorite/list_favorite_screen.dart';
import 'package:shop_app/screens/list_followed/list_follow_screen.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  Body({Key key, this.search}) : super(key: key);
  final String search;

  @override
  _BodyState createState() => _BodyState(search: search);
}

class _BodyState extends State<Body> {
  _BodyState({this.search});
  String search;
  List<Map<String, dynamic>> categories2 = [
    {"icon": "assets/icons/Flash Icon.svg", "text": "Flash Deal"},
    {"icon": "assets/icons/Bill Icon.svg", "text": "Bill"},
    {"icon": "assets/icons/Game Icon.svg", "text": "Game"},
    {"icon": "assets/icons/Gift Icon.svg", "text": "Daily Gift"},
    {"icon": "assets/icons/Discover.svg", "text": "More"},
  ];
  List<String> categories = [
    "all".tr().toString(),
    "fan".tr().toString(),
    "rings".tr().toString(),
    "earring".tr().toString(),
    "glass bottle".tr().toString(),
    "accessories".tr().toString()
  ];
  // By default first one is selected
  int selectedIndex;
  String searchKey = "";
  double aspectRetio = 0.7;
  Future<List<Product>> productFuture;
  TextEditingController searchController = TextEditingController();
  Future<bool> checkfavorFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (search == "" || search.isEmpty || search == null) {
      searchController.text = "";
    } else {
      searchKey = search;
      searchController.text = search;
    }
    selectedIndex = 0;
    productFuture = downloadJSONProduct();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: SizeConfig.screenWidth * 0.6,
                    decoration: BoxDecoration(
                      color: kSecondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {
                          searchKey = value;
                        });
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(20),
                              vertical: getProportionateScreenWidth(9)),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: "search product".tr().toString(),
                          prefixIcon: Icon(Icons.search)),
                    ),
                  ),
                  IconBtnWithCounter(
                    svgSrc: "assets/icons/lovef.svg",
                    press: () => Navigator.pushNamed(
                        context, ListFavoriteScreen.routeName),
                  ),
                  IconBtnWithCounter(
                    svgSrc: "assets/icons/shopf.svg",
                    // numOfitem: 3,
                    press: () => Navigator.pushNamed(
                        context, ListFollowScreen.routeName),
                  ),
                ],
              ),
            ),
            SizedBox(height: getProportionateScreenWidth(10)),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 1),
              child: SizedBox(
                height: SizeConfig.defaultSize * 3.5, // 35
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        this.selectedIndex = index;
                        // print(this.selectedIndex);
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: SizeConfig.defaultSize * 1),
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.defaultSize * 1.5, //20
                        vertical: SizeConfig.defaultSize * 0.5, //5
                      ),
                      decoration: BoxDecoration(
                          color: selectedIndex == index
                              ? Color(0xFFEFF3EE)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(
                            SizeConfig.defaultSize * 1.6, // 16
                          )),
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: selectedIndex == index
                              ? kPrimaryColor
                              : Color(0xFFC2C2B5),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(getProportionateScreenWidth(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  categories2.length,
                  (index) => CategoryCard(
                    icon: categories2[index]["icon"],
                    text: categories2[index]["text"],
                    press: () {
                      setState(() {
                        this.selectedIndex = 6 + index;
                        // print(6 + index);
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenWidth(10)),
            Column(children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: SectionTitle(
                  title: "all products".tr().toString(),
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
                        List<Product> demoProducts;
                        if (this.selectedIndex == 0) {
                          demoProducts = snapshot.data
                              .where((element) => element.name.contains(
                                  new RegExp(searchKey, caseSensitive: false)))
                              .toList();
                        } else {
                          demoProducts = snapshot.data
                              .where((element) =>
                                  element.groupProduct == this.selectedIndex &&
                                  element.name.contains(new RegExp(searchKey,
                                      caseSensitive: false)))
                              .toList();
                        }
                        // print(demoProducts);
                        return GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: aspectRetio),
                          itemBuilder: (BuildContext context, int index) {
                            checkfavorFuture =
                                downloadFavorite(demoProducts[index].id);
                            // print(searchKey);
                            return Padding(
                                padding: EdgeInsets.all(5.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      DetailsScreen.routeName,
                                      arguments: ProductDetailsArguments(
                                          product: demoProducts[index],
                                          page: 2),
                                    );
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 8.0)
                                          ]),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            height:
                                                getProportionateScreenHeight(
                                                    150),
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
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        15),
                                                                topRight: Radius
                                                                    .circular(
                                                                        15)),
                                                            image:
                                                                DecorationImage(
                                                              image: NetworkImage(
                                                                  demoProducts[
                                                                          index]
                                                                      .images[0]),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      demoProducts[index]
                                                                  .discount !=
                                                              0
                                                          ? Positioned(
                                                              top: 0,
                                                              right: 0,
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .pink[50],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topRight: Radius
                                                                        .circular(
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
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              4),
                                                                  child: Text(
                                                                    '-' +
                                                                        "${demoProducts[index].discount.toString()}" +
                                                                        '%',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .red),
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
                                            padding:
                                                EdgeInsets.only(left: 10.0),
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
                                                          .difference(
                                                              DateTime.now())
                                                          .inDays >
                                                      1
                                              ? Row(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10.0),
                                                      child: Text(
                                                        "${demoProducts[index].priceDiscount}",
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
                                                        "${demoProducts[index].price.toString()}",
                                                        style: TextStyle(
                                                          fontSize:
                                                              getProportionateScreenWidth(
                                                                  11),
                                                          color:
                                                              Colors.grey[300],
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.0),
                                                  child: Text(
                                                    "${demoProducts[index].price.toString()}",
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
                                          // ----------------------END discount-----------------
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                RatingBarIndicator(
                                                  rating: demoProducts[index]
                                                      .rating,
                                                  itemBuilder:
                                                      (context, index) => Icon(
                                                    Icons.star,
                                                    color: Colors.yellow[600],
                                                  ),
                                                  itemCount: 5,
                                                  itemSize: 15.0,
                                                  direction: Axis.horizontal,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10.0),
                                                  child: Container(
                                                    child: FutureBuilder<bool>(
                                                      future: checkfavorFuture,
                                                      builder:
                                                          (context, snapshot) {
                                                        // print(snapshot.data);
                                                        if (snapshot.hasData) {
                                                          return InkWell(
                                                            onTap: () {
                                                              downloadCheckFavorite(
                                                                  demoProducts[
                                                                          index]
                                                                      .id,
                                                                  snapshot
                                                                      .data);
                                                              setState(() {
                                                                checkfavorFuture =
                                                                    downloadFavorite(
                                                                        demoProducts[index]
                                                                            .id);
                                                              });
                                                            },
                                                            child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                getProportionateScreenWidth(
                                                                    8),
                                                              ),
                                                              height:
                                                                  getProportionateScreenWidth(
                                                                      28),
                                                              width:
                                                                  getProportionateScreenWidth(
                                                                      28),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: snapshot
                                                                        .data
                                                                    ? kPrimaryColor
                                                                        .withOpacity(
                                                                            0.15)
                                                                    : kSecondaryColor
                                                                        .withOpacity(
                                                                            0.1),
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child: SvgPicture
                                                                  .asset(
                                                                "assets/icons/Heart Icon_2.svg",
                                                                color: snapshot
                                                                        .data
                                                                    ? Color(
                                                                        0xFFFF4848)
                                                                    : Color(
                                                                        0xFFDBDEE4),
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
            ]),
          ],
        ),
      ),
    );
  }

  Widget buildCategoriItem(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: SizeConfig.defaultSize * 1),
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultSize * 1.5, //20
          vertical: SizeConfig.defaultSize * 0.5, //5
        ),
        decoration: BoxDecoration(
            color:
                selectedIndex == index ? Color(0xFFEFF3EE) : Colors.transparent,
            borderRadius: BorderRadius.circular(
              SizeConfig.defaultSize * 1.6, // 16
            )),
        child: Text(
          categories[index],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: selectedIndex == index ? kPrimaryColor : Color(0xFFC2C2B5),
          ),
        ),
      ),
    );
  }
}
