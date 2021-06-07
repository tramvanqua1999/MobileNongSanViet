import 'package:flutter/material.dart';
import 'package:shop_app/size_config.dart';

class Background extends StatelessWidget {
  const Background({Key key, @required this.screenSize, @required this.imgbg})
      : super(key: key);
  final String imgbg;

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(200),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imgbg),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
