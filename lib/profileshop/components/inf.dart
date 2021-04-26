import 'package:flutter/material.dart';
import 'package:shop_app/models/profileShop.dart';

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
              title: Text("Tên cửa hàng"),
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
              title: Text("Địa chỉ"),
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
              title: Text("Số điện thoại"),
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
      return "Không";
    }
  }
}
