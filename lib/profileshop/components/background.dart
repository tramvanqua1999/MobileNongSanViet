import 'package:flutter/material.dart';
import 'package:shop_app/size_config.dart';

class Background extends StatelessWidget {
  const Background({
    Key key,
    @required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(200),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/backgroundshop.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
