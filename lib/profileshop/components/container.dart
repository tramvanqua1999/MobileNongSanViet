import 'package:flutter/material.dart';
import 'package:shop_app/size_config.dart';

class ContainerCP extends StatelessWidget {
  const ContainerCP({
    Key key,
    @required String status,
  })  : _status = status,
        super(key: key);

  final String _status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 4.0, horizontal: getProportionateScreenWidth(30)),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        _status,
        style: TextStyle(
          fontFamily: 'Spectral',
          color: Colors.black,
          fontSize: 18.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
