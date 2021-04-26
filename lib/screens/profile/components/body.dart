import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          // ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "Cập nhật tài khoản",
            icon: "assets/icons/User Icon.svg",
            icons: Icon(Icons.arrow_forward_ios),
            press: () => {
              Navigator.pushNamed(context, '/updateProfile'),
            },
          ),
          ProfileMenu(
            text: "Notifications",
            icon: "assets/icons/Bell.svg",
            icons: Icon(Icons.arrow_forward_ios),
            press: () {},
          ),
          ProfileMenu(
            text: "Settings",
            icon: "assets/icons/Settings.svg",
            icons: Icon(Icons.arrow_forward_ios),
            press: () {},
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            icons: Icon(Icons.arrow_forward_ios),
            press: () {},
          ),
          ProfileMenu(
            text: "Đăng xuất",
            icon: "assets/icons/Log out.svg",
            press: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs?.remove("isLoggedIn");
              prefs?.remove("username");
              prefs?.remove("type");
              // prefs?.setString("isLoggedIn", '');
              // prefs?.setString("username", '');
              // prefs?.setString("type", '');
              // var session = FlutterSession();
              // await session.set("username", "");
              // await session.set("type", "");
              Navigator.pushNamed(context, SignInScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
