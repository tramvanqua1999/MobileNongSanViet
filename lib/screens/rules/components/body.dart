import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../size_config.dart';

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
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Text(
                  "rules".tr().toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "welcome to the Handmade Shop".tr().toString() +
                      "  \n" +
                      "through website interface or mobile application"
                          .tr()
                          .toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.01),
                Text("1rules".tr().toString()),
                SizedBox(height: SizeConfig.screenHeight * 0.01),
                Text("2rules".tr().toString()),
                SizedBox(height: SizeConfig.screenHeight * 0.01),
                Text("3rules".tr().toString()),
                SizedBox(height: SizeConfig.screenHeight * 0.01),
                Text("4rules".tr().toString()),
                SizedBox(height: SizeConfig.screenHeight * 0.01),
                Text("5rules".tr().toString()),
                SizedBox(height: SizeConfig.screenHeight * 0.01),
                Text("6rules".tr().toString()),
                SizedBox(height: SizeConfig.screenHeight * 0.01),
                Text("7rules".tr().toString()),
                SizedBox(height: SizeConfig.screenHeight * 0.01),
                Text("8rules".tr().toString()),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SizedBox(height: getProportionateScreenHeight(20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
