import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/screens/rules/rules_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';

import 'profile_menu.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("lang".tr().toString()),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 100,
                          child: Text("Việt Nam"),
                        ),
                        Image.asset(
                          "assets/images/vn.png",
                          width: 50,
                        )
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        EasyLocalization.of(context).locale =
                            Locale('vi', 'VN');
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 100,
                          child: Text("English"),
                        ),
                        Image.asset(
                          "assets/images/en.png",
                          width: 50,
                        )
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        EasyLocalization.of(context).locale =
                            Locale('en', 'EN');
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          // ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "account update".tr().toString(),
            icon: "assets/icons/User Icon.svg",
            icons: Icon(Icons.arrow_forward_ios),
            press: () => {
              Navigator.pushNamed(context, '/updateProfile'),
            },
          ),
          // ProfileMenu(
          //   text: "Notifications",
          //   icon: "assets/icons/Bell.svg",
          //   icons: Icon(Icons.arrow_forward_ios),
          //   press: () {},
          // ),
          ProfileMenu(
            text: "change language".tr().toString(),
            icon: "assets/icons/Settings.svg",
            icons: Icon(Icons.arrow_forward_ios),
            press: () {
              _showChoiceDialog(context);
            },
          ),
          ProfileMenu(
              text: "rules".tr().toString(),
              icon: "assets/icons/Question mark.svg",
              icons: Icon(Icons.arrow_forward_ios),
              press: () =>
                  {Navigator.pushNamed(context, RulesScreen.routeName)}),
          ProfileMenu(
            text: "log out".tr().toString(),
            icon: "assets/icons/Log out.svg",
            press: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs?.remove("isLoggedIn");
              prefs?.remove("username");
              prefs?.remove("type");
              Navigator.pushNamed(context, SignInScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
