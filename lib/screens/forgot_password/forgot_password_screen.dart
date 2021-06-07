import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'components/body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static String routeName = "/forgot_password";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("forgot Password".tr().toString()),
      ),
      body: Body(),
    );
  }
}
