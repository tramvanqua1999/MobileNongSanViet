import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/size_config.dart';

import 'complete_profile_form.dart';

class Body extends StatelessWidget {
  Body({
    Key key,
    @required this.phone,
  }) : super(key: key);
  final String phone;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                Text("Hoàn thành đăng ký", style: headingStyle),
                Text("Điền đầy đủ thông tin bên dưới",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16)),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                CompleteProfileForm(phone: phone),
                SizedBox(height: getProportionateScreenHeight(20)),
                Text(
                  "Lưu ý: Tài khoản cửa hàng chỉ hoạt động trên website: https://abc.xyz.huy",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
