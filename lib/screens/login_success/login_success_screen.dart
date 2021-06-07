import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'components/body.dart';

class LoginSuccessScreen extends StatelessWidget {
  static String routeName = "/login_success";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text("login Success".tr().toString()),
      ),
      body: Body(),
    );
  }
}
