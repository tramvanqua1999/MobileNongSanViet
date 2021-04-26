import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/update_profile/components/update_profile_form.dart';
import 'package:shop_app/size_config.dart';

class Body extends StatelessWidget {
  Body({
    Key key,
  }) : super(key: key);

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
                Text("Cập nhật lại thông tin", style: headingStyle),
                Text("Vui lòng nhập đủ thông tin bên dưới",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16)),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                CompleteProfileForm(),
                SizedBox(height: getProportionateScreenHeight(20)),
                Text(
                  "",
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
