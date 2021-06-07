import 'package:flutter/material.dart';
import 'package:shop_app/models/profileShop.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../size_config.dart';

class Inf extends StatefulWidget {
  const Inf({
    @required this.shop,
    Key key,
  }) : super(key: key);
  final Shop shop;

  @override
  _InfState createState() => _InfState(shop);
}

class _InfState extends State<Inf> {
  Shop shop;
  _InfState(this.shop);
  @override
  void initState() {
    super.initState();
    // print(shop.nameShop);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(350),
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.store,
                color: Colors.grey[500],
              ),
              title: Text("name of the store".tr().toString()),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: getProportionateScreenWidth(150),
                    child: Text(
                      shop.nameShop.toString(),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.location_on,
                color: Colors.grey[500],
              ),
              title: Text("address".tr().toString()),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: getProportionateScreenWidth(150),
                    child: Text(
                      shop.address.toString(),
                    ),
                  ),
                ],
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.email,
                color: Colors.grey[500],
              ),
              title: Text("Email"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: getProportionateScreenWidth(150),
                    child: Text(
                      shop.email.toString(),
                    ),
                  ),
                ],
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.phone,
                color: Colors.grey[500],
              ),
              title: Text("phone".tr().toString()),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: getProportionateScreenWidth(150),
                    child: Text(checkphone()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String checkphone() {
    if (shop.phone != null) {
      return shop.phone.toString();
    } else {
      return "no".tr().toString();
    }
  }
}
