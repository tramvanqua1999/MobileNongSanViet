import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'components/body.dart';

class CompleteProfileScreen extends StatelessWidget {
  static String routeName = "/complete_profile";
  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('sign Up'.tr().toString()),
      ),
      body: Body(
        phone: args.phone,
      ),
    );
  }
}

class ScreenArguments {
  final String phone;
  ScreenArguments(this.phone);
}
