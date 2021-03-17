import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/models/Popular_product.dart';
import 'package:shop_app/models/request.dart';
import 'package:shop_app/screens/details/details_screen.dart';

import '../constants.dart';
import '../size_config.dart';

class ProductSaleCard extends StatefulWidget {
  const ProductSaleCard({
    Key key,
    this.width = 140,
    this.aspectRetio = 1.02,
    @required this.product,
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;
  @override
  _ProductSaleCardState createState() =>
      _ProductSaleCardState(aspectRetio, product, width);
}

class _ProductSaleCardState extends State<ProductSaleCard> {
  _ProductSaleCardState(this.aspectRetio, this.product, this.width);
  double width, aspectRetio;
  Product product;
  Future<bool> favoriteFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favoriteFuture = downloadFavorite(product.id);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            DetailsScreen.routeName,
            arguments: ProductDetailsArguments(product: product),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: <Widget>[
                AspectRatio(
                  aspectRatio: 1.02,
                  child: Hero(
                    tag: product.id.toString() + "Sale_product",
                    child: Container(
                      padding: EdgeInsets.only(
                          left: getProportionateScreenWidth(20),
                          bottom: getProportionateScreenWidth(20)),
                      decoration: BoxDecoration(
                        color: kSecondaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: NetworkImage(product.images[0]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                product.discount != 0
                    ? Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          height: 20,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.pink[50],
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 4),
                            child: Text(
                              '-' + '${product.discount}' + '%',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                          ),
                        ),
                      )
                    : Container()
              ]),
              const SizedBox(height: 10),
              Text(
                product.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black),
                maxLines: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // -------------------------- Start Discount------------------
                  product.discount != 0 &&
                          product.lastday.difference(DateTime.now()).inDays > 1
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${product.priceDiscount}",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(15),
                                fontWeight: FontWeight.w600,
                                height: 1,
                                color: kPrimaryColor,
                              ),
                            ),
                            Text(
                              "${product.price}",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(11),
                                color: Colors.grey[300],
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${product.price}",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(15),
                                fontWeight: FontWeight.w600,
                                height: 1,
                                color: kPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                  // -------------------------- END Discount------------------

                  FutureBuilder<bool>(
                      future: favoriteFuture,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () {
                              downloadCheckFavorite(product.id, snapshot.data);
                              setState(() {
                                favoriteFuture = downloadFavorite(product.id);
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(
                                  getProportionateScreenWidth(8)),
                              height: getProportionateScreenWidth(28),
                              width: getProportionateScreenWidth(28),
                              decoration: BoxDecoration(
                                color: snapshot.data
                                    ? kPrimaryColor.withOpacity(0.15)
                                    : kSecondaryColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                "assets/icons/Heart Icon_2.svg",
                                color: snapshot.data
                                    ? Color(0xFFFF4848)
                                    : Color(0xFFDBDEE4),
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                      }),
                ],
              ),
              RatingBarIndicator(
                rating: product.rating,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.yellow[600],
                ),
                itemCount: 5,
                itemSize: 15.0,
                direction: Axis.horizontal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
