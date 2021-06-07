import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Popular_product.dart';
import 'package:shop_app/models/request.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  Future<List<Product>> productFuture = downloadJSONHighestDiscount();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: "discount".tr().toString() + " HOT",
            press: () {},
            icon: Icons.arrow_right,
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: FutureBuilder<List<Product>>(
              future: productFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Product> demoProducts = snapshot.data;

                  return Row(
                    children: [
                      ...List.generate(
                        demoProducts.length,
                        (index) {
                          if (demoProducts[index].discount != 0)
                            return ProductCard(product: demoProducts[index]);

                          return SizedBox
                              .shrink(); // here by default width and height is 0
                        },
                      ),
                      SizedBox(width: getProportionateScreenWidth(20)),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                //return  a circular progress indicator.
                return new CircularProgressIndicator();
              }),
        )
      ],
    );
  }
}
