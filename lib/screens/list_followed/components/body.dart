import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'list_follow.dart';

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
                ListFollow(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
