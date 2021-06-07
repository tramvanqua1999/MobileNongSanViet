import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'package:easy_localization/easy_localization.dart';

class SectionTitle extends StatelessWidget {
  SectionTitle({
    Key key,
    @required this.title,
    @required this.press,
    @required this.icon,
  }) : super(key: key);

  final String title;
  final GestureTapCallback press;
  IconData icon = Icons.arrow_right;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.black,
          ),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: press,
              child: Text(
                "see More".tr().toString(),
                style: TextStyle(color: Color(0xFFBBBBBB)),
              ),
            ),
            Icon(
              icon,
              color: Color(0xFFBBBBBB),
              size: 30.0,
            ),
          ],
        )
      ],
    );
  }
}
