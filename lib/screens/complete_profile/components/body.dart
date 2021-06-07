import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/size_config.dart';
import 'package:easy_localization/easy_localization.dart';
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
                Text("complete registration".tr().toString(),
                    style: headingStyle),
                Text("fill out the information below".tr().toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16)),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                CompleteProfileForm(phone: phone),
                SizedBox(height: getProportionateScreenHeight(20)),
                Text(
                  "note: Store account only works on website: https: //abc.xyz.huy"
                      .tr()
                      .toString(),
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
