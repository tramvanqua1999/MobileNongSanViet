import 'package:flutter/material.dart';
import 'package:shop_app/screens/products/products_screen.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:easy_localization/easy_localization.dart';

class SearchField extends StatelessWidget {
  SearchField({
    Key key,
  }) : super(key: key);
  String search;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.6,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: (value) {
          search = value;
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenWidth(9)),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "search product".tr().toString(),
            prefixIcon: InkWell(
                onTap: () => Navigator.pushNamed(
                      context,
                      ProductScreen.routeName,
                      arguments: ProductDetailsArguments(search: search),
                    ),
                child: Icon(Icons.search))),
      ),
    );
  }
}
