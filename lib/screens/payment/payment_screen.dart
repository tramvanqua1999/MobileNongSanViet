import 'package:flutter/material.dart';
import 'components/custom_app_bar.dart';
import 'components/home.dart';
import 'package:easy_localization/easy_localization.dart';

class PaymentScreen extends StatelessWidget {
  static String routeName = "/payment";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: CustomAppBar(),
      body: HomePage(),
    );
  }
}
