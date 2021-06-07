import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'components/body.dart';

class UpdateProfileScreen extends StatelessWidget {
  static String routeName = "/updateProfile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('update'.tr().toString()),
      ),
      body: Body(),
    );
  }
}
