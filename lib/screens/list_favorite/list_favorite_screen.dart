import 'package:flutter/material.dart';

import 'components/body.dart';
import 'components/custom_app_bar.dart';

class ListFavoriteScreen extends StatelessWidget {
  static String routeName = "/list_favorite";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Body(),
    );
  }
}
