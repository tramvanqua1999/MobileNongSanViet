import 'package:flutter/material.dart';
import 'package:shop_app/screens/rules/components/body.dart';
import 'package:easy_localization/easy_localization.dart';

class RulesScreen extends StatelessWidget {
  static String routeName = "/rulesScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("back".tr().toString()),
      ),
      body: Body(),
    );
  }
}
