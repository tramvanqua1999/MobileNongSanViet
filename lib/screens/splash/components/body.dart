import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/size_config.dart';
import 'package:easy_localization/easy_localization.dart';

// This is the best practice
import '../components/splash_content.dart';
import '../../../components/default_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "welcome to Văn Quá Shop, Let’s shop!" ,
      "image": "assets/images/1.4.jpg"
    },
    {
      "text": "we help people conect with store"  +
          "\n" +
          "all over Vietnam" ,
      "image": "assets/images/1.3.jpg"
    },
    {
      "text": "we show the easy way to shop"  +
          "\n" +
          "just stay at home with us" ,
      "image": "assets/images/holiday-shopping-clipart-2.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 3),
                    DefaultButton(
                      height: 56,
                      text: "Tiếng Việt",
                      press: () {
                        setState(() {
                          setState(() {
                            EasyLocalization.of(context).locale =
                                Locale('vi', 'VN');
                          });
                        });
                        Navigator.pushNamed(context, SignInScreen.routeName);
                      },
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    DefaultButton(
                      height: 56,
                      text: "Tiếng Anh",
                      press: () {
                        setState(() {
                          EasyLocalization.of(context).locale =
                              Locale('en', 'EN');
                        });
                        Navigator.pushNamed(context, SignInScreen.routeName);
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
