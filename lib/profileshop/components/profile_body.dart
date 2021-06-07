import 'package:flutter/material.dart';
import 'package:shop_app/models/profileShop.dart';
import 'package:shop_app/profileshop/components/inf.dart';
import 'package:shop_app/profileshop/components/productShop.dart';
import 'package:shop_app/profileshop/components/productShopSale.dart';
import 'package:shop_app/models/request.dart';
import 'package:shop_app/profileshop/components/rating_Shop.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../size_config.dart';
import 'Unline.dart';
import 'background.dart';
// import 'container.dart';
import 'decription.dart';
import 'information.dart';
import 'logo.dart';
import 'name.dart';

class ShopProfilePage extends StatefulWidget {
  const ShopProfilePage({
    Key key,
    @required this.shop,
  }) : super(key: key);
  final Shop shop;

  @override
  _ShopProfilePageState createState() => _ShopProfilePageState(shop);
}

class _ShopProfilePageState extends State<ShopProfilePage> {
  Shop shop;
  _ShopProfilePageState(this.shop);
  @override
  void initState() {
    super.initState();
  }

  List<String> categories = [
    "information".tr().toString(),
    "discount".tr().toString(),
    "product".tr().toString(),
    "evaluate".tr().toString()
  ];
  int selectedIndex = 0;
  // final String _bio =
  //     "\"Hi, I am a Freelance developer working for hourly basis. If you wants to contact me to build your product leave a message.\"";
  Future<bool> futureFollow;
  Future<void> checkfutureFollow;
  Future<int> countFollow;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    futureFollow = downloadFollow(shop.id);
    countFollow = downloadCountFollow(shop.id);
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Background(screenSize: screenSize, imgbg: shop.imgBg),
                SafeArea(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: screenSize.height / 6.4),
                      Logo(logopath: shop.img),
                      Name(fullName: shop.nameShop),
                      FutureBuilder<bool>(
                          future: futureFollow,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: getProportionateScreenHeight(8)),
                                child: InkWell(
                                  onTap: () {
                                    downloadCheckFollow(shop.id);
                                    setState(() {
                                      futureFollow = downloadFollow(shop.id);
                                      countFollow =
                                          downloadCountFollow(shop.id);
                                    });
                                  },
                                  child: Container(
                                    width: getProportionateScreenWidth(150),
                                    height: getProportionateScreenHeight(35),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: snapshot.data == true
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Icon(
                                            Icons.check_circle,
                                            color: Colors.white,
                                            size: 30.0,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(
                                              getProportionateScreenHeight(
                                                  4.5)),
                                          child: Center(
                                            child: Text(
                                              snapshot.data == true
                                                  ? "followed".tr().toString()
                                                  : "follow".tr().toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Container();
                            }
                            return Center(child: CircularProgressIndicator());
                          }),
                      // ContainerCP(),
                      Unline(screenSize: screenSize),
                      FutureBuilder<int>(
                          future: countFollow,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Information(
                                rate: shop.ratingShop,
                                follow: snapshot.data.toString(),
                                sumproduct: shop.sumproduct,
                                // sumproduct: snapshot.hasData,
                              );
                            } else if (snapshot.hasError) {
                              return Container();
                            }
                            return Center(child: CircularProgressIndicator());
                          }),
                      Description(
                          bio: shop.description == null
                              ? "shop has not added description".tr().toString()
                              : shop.description),
                      Unline(screenSize: screenSize),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenHeight(20),
                        ),
                        child: Container(
                          color: Colors.blue[50],
                          height: getProportionateScreenHeight(40), // 35
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenHeight(0),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      left: getProportionateScreenHeight(0)),
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        getProportionateScreenHeight(20), //20
                                  ),
                                  decoration: BoxDecoration(
                                      // color: selectedIndex == index
                                      //     ? Color(0xFFEFF3EE)
                                      //     : Colors.transparent,
                                      borderRadius: BorderRadius.circular(
                                    getProportionateScreenHeight(10), // 16
                                  )),
                                  child: Text(
                                    categories[index],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: selectedIndex == index
                                          ? Colors.lightBlue
                                          : Color(0xFFC2C2B5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      selectedIndex == 0
                          ? Inf(
                              shop: shop,
                            )
                          : Container(),
                      selectedIndex == 1
                          ? ProductSale(
                              shop: shop,
                            )
                          : Container(),
                      selectedIndex == 2
                          ? ProductShop(
                              shop: shop,
                            )
                          : Container(),
                      selectedIndex == 3
                          ? RatingShop(id: shop.id)
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
