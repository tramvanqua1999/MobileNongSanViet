import 'package:flutter/material.dart';
import 'package:shop_app/models/Shop.dart';

import '../../constants.dart';
import '../../size_config.dart';
import 'Unline.dart';
import 'background.dart';
import 'container.dart';
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

  List<String> categories = [
    "Thông tin",
    "Giảm giá",
    "Tất cả sản phẩm",
  ];
  int selectedIndex = 0;
  final String _bio =
      "\"Hi, I am a Freelance developer working for hourly basis. If you wants to contact me to build your product leave a message.\"";

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Background(screenSize: screenSize),
                SafeArea(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: screenSize.height / 6.4),
                      Logo(logopath: shop.images[0]),
                      Name(fullName: shop.title),
                      ContainerCP(status: shop.description),
                      Unline(screenSize: screenSize),
                      Information(
                        rate: shop.rating,
                      ),
                      Description(bio: _bio),
                      Unline(screenSize: screenSize),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenHeight(20),
                        ),
                        child: SizedBox(
                          height: getProportionateScreenHeight(25), // 35
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
                                  horizontal: getProportionateScreenHeight(7),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      left: getProportionateScreenHeight(5)),
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        getProportionateScreenHeight(20), //20
                                  ),
                                  decoration: BoxDecoration(
                                      color: selectedIndex == index
                                          ? Color(0xFFEFF3EE)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(
                                        getProportionateScreenHeight(10), // 16
                                      )),
                                  child: Text(
                                    categories[index],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
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
                      ),
                    ],

                    // GetContent(selectedIndex, shop),
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
