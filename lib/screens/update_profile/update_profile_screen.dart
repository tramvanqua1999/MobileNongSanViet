import 'package:flutter/material.dart';

import 'components/body.dart';

class UpdateProfileScreen extends StatelessWidget {
  static String routeName = "/updateProfile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cập nhật'),
      ),
      body: Body(),
    );
  }
}
