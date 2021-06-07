import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/models/comments.dart';
import 'package:shop_app/models/request.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../constants.dart';
import '../../size_config.dart';
import 'package:http/http.dart' as http;

class RatingShop extends StatefulWidget {
  RatingShop({
    @required this.id,
    Key key,
  }) : super(key: key);
  final int id;
  @override
  _RatingShopState createState() => _RatingShopState(id);
}

class _RatingShopState extends State<RatingShop> {
  int id;
  _RatingShopState(this.id);
  Future<List<CommentModel>> commentModelfuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    commentModelfuture = downloadJSONComment(id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(40)),
            child: Container(
              width: getProportionateScreenWidth(300),
              child: Card(
                color: Colors.white,
                elevation: 4.0,
                child: ListTile(
                  leading: Icon(
                    Icons.create_rounded,
                    color: kPrimaryColor,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        width: getProportionateScreenWidth(150),
                        child: Text(
                          "enter comments".tr().toString(),
                        ),
                      ),
                    ],
                  ),
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    var username = prefs?.getString("username");
                    _showComment(context, id);
                  },
                ),
              ),
            ),
          ),
          FutureBuilder<List<CommentModel>>(
            future: commentModelfuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<CommentModel> commentModel = snapshot.data;
                // print(commentModel);
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: commentModel.length,
                      itemBuilder: (context, index) {
                        return CommentBody(
                          commentModel: commentModel[index],
                        );
                      },
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              //return  a circular progress indicator.
              return new CircularProgressIndicator();
            },
          ),
          SizedBox(
            height: getProportionateScreenHeight(50),
          )
        ]);
  }

  Future<void> _showComment(BuildContext context, int id) {
    var rating = 1.0;
    TextEditingController cmntController = TextEditingController();

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "evaluate".tr().toString(),
                        style: TextStyle(fontSize: 24.0),
                      ),
                      SmoothStarRating(
                        rating: rating,
                        isReadOnly: false,
                        size: 26,
                        filledIconData: Icons.star,
                        halfFilledIconData: Icons.star_half,
                        defaultIconData: Icons.star_border,
                        starCount: 5,
                        allowHalfRating: true,
                        spacing: 2.0,
                        onRated: (value) {
                          rating = value;
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 15.0, right: 15.0, bottom: 10, top: 10),
                    child: TextField(
                      controller: cmntController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "enter comments".tr().toString(),
                      ),
                      maxLines: 8,
                    ),
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0),
                            // topLeft: Radius.circular(32.0),
                            // topRight: Radius.circular(32.0),
                          )),
                      child: Text(
                        "comment".tr().toString(),
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      var username = prefs?.getString("username");

                      try {
                        final response =
                            await http.post(url + "commentshop", body: {
                          "username": username,
                          "comment": cmntController.text,
                          "id": json.encode(id),
                          "rating": json.encode(rating),
                        });
                        print(response.body);
                        if (response.statusCode == 200) {
                          setState(() {
                            commentModelfuture = downloadJSONComment(id);
                          });
                          Navigator.pop(context);
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class CommentBody extends StatefulWidget {
  CommentBody({Key key, @required this.commentModel}) : super(key: key);
  final CommentModel commentModel;
  @override
  _CommentBodyState createState() => _CommentBodyState(commentModel);
}

class _CommentBodyState extends State<CommentBody> {
  _CommentBodyState(this.commentModel);
  CommentModel commentModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(350),
      child: Card(
        color: Colors.white,
        elevation: 4.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      new SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Text(
                            commentModel.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          new Text(
                            getText(DateTime.parse(commentModel.create)),
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  // new IconButton(
                  //   icon: Icon(Icons.more_vert),
                  //   onPressed: null,
                  // )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: getProportionateScreenWidth(27)),
              child: Text(
                commentModel.content,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: getProportionateScreenWidth(27)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "evaluate".tr().toString() + ": ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      RatingBarIndicator(
                        rating: commentModel.rating,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.yellow[600],
                        ),
                        itemCount: 5,
                        itemSize: 15.0,
                        direction: Axis.horizontal,
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

String getText(DateTime day) {
  if (DateTime.now().difference(day).inMilliseconds < 60) {
    return "${DateTime.now().difference(day).inMinutes} " +
        "seconds ago".tr().toString();
  } else if (DateTime.now().difference(day).inMinutes < 60) {
    return "${DateTime.now().difference(day).inMinutes} " +
        "minutes ago".tr().toString();
  } else if (DateTime.now().difference(day).inHours < 24) {
    return "${DateTime.now().difference(day).inHours} " +
        "hours ago".tr().toString();
  } else {
    if (DateTime.now().difference(day).inDays < 30) {
      return "${DateTime.now().difference(day).inDays} " +
          "yesterday".tr().toString();
    } else if (DateTime.now().difference(day).inDays >= 30 &&
        DateTime.now().difference(day).inDays < 365) {
      double temp = (DateTime.now().difference(day).inDays / 30);
      int value = temp.toInt();
      return "${value.toString()} " + "last month".tr().toString();
    } else {
      double temp = (DateTime.now().difference(day).inDays / 365);
      int value = temp.toInt();
      return "${value.toString()} " + "last year".tr().toString();
    }
  }
}
