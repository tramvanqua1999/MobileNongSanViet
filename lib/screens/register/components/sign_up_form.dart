import 'package:flutter/material.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/helper/keyboard.dart';
import 'package:shop_app/screens/otp/otp_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/straintion/load_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:shop_app/components/notificationPlugin.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  String conform_password;
  bool remember = false;

  final List<String> errors = [];

  ////////////////////
  TextEditingController phoneController = TextEditingController();
  Future<void> _phone() async {
    try {
      final response = await http.post(url + "phone", body: {
        "phone": phoneController.text,
      });
      print(response.statusCode);
      ProcessDialog.closeLoadingDialog();

      if (response.statusCode == 201) {
        await notificationPlugin.showNotification(response.body);
        Navigator.pushNamed(
          context,
          OtpScreen.routeName,
          arguments: ScreenArguments(response.body, phoneController.text),
        );
        // Navigator.pushNamed(
        //   context,
        //   OtpScreen.routeName,
        // );
      } else {
        Alert(
          context: context,
          type: AlertType.error,
          title: "Lỗi",
          desc: "Số điện thoại đã được dùng",
          buttons: [
            DialogButton(
              child: Text(
                "OK",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 50,
            )
          ],
        ).show();
      }
    } catch (e) {}
  }

  ////////////////////
  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationPlugin
        .setListenerForLowerVersions(onNotificationInLowerVersions);
    notificationPlugin.setOnNotificationClick(onNotificationClick);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            height: 56,
            text: "Tiếp tục",
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                // Navigator.pushNamed(context, CompleteProfileScreen.routeName);
                KeyboardUtil.hideKeyboard(context);
                ProcessDialog.showLoadingDialog(context);
                _phone();
                // Navigator.pushNamed(
                //   context,
                //   OtpScreen.routeName,
                // );
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: phoneController,
      onSaved: (newValue) => email = newValue,
      onTap: () {
        removeError(error: kEmailNullError);
        removeError(error: kInvalidEmailError);
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Số điện thoại",
        hintText: "Nhập số điện thoại của bạn",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/smartphone.svg"),
      ),
    );
  }

  onNotificationInLowerVersions(ReceivedNotification receivedNotification) {}

  onNotificationClick(String payload) {}
}

// class ScreenArguments {
//   final String checkcode;
//   final String phone;

//   ScreenArguments(this.checkcode, this.phone);
// }
