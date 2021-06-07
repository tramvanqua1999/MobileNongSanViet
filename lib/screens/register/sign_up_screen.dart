import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'components/body.dart';

class RegisterScreen extends StatelessWidget {
  static String routeName = "/sign_up";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("sign Up".tr().toString()),
      ),
      body: Body(),
    );
  }
}
