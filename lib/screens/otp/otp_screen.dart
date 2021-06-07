import 'package:flutter/material.dart';
import 'package:shop_app/size_config.dart';
import 'package:easy_localization/easy_localization.dart';

import 'components/body.dart';

class OtpScreen extends StatelessWidget {
  static String routeName = "/otp";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification".tr().toString()),
      ),
      body: Body(
        checkcode: args.checkcode,
        phone: args.phone,
      ),
    );
  }
}

class ScreenArguments {
  final String checkcode;
  final String phone;

  ScreenArguments(this.checkcode, this.phone);
}
