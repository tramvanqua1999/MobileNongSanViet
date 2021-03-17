import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../size_config.dart';

class Information extends StatelessWidget {
  const Information({Key key, @required rate})
      : rate = rate,
        super(key: key);
  final double rate;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      margin: EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Đánh giá',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(25),
                child: RatingBarIndicator(
                  rating: rate,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.yellow[600],
                  ),
                  itemCount: 5,
                  itemSize: 20.0,
                  direction: Axis.horizontal,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Tổng sản phẩm',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(25),
                child: Text(
                  '99',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Lượt theo dõi',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(25),
                child: Text(
                  '100',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
