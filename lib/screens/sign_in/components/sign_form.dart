import 'package:flutter/material.dart';
// import 'package:flutter_session/flutter_session.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/helper/keyboard.dart';
import 'package:shop_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:shop_app/screens/login_success/login_success_screen.dart';
import 'package:shop_app/straintion/load_screen.dart';

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
// import http
import 'package:http/http.dart' as http;

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool remember = false;
  final List<String> errors = [];

  // ----------backend-----------
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();

  // ----------end---------------

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

  // ----------backend-----------
  Future _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final response = await http.post(url + "login", body: {
        "username": userController.text,
        "password": passController.text,
      });
      print(response.body);
      if (response.body != "999") {
        ProcessDialog.closeLoadingDialog();
        if (response.body == "0") {
          if (remember) {
            prefs?.setString("isLoggedIn", response.body);
          }

          prefs?.setString("username", userController.text);
          prefs?.setString("type", "0");
          // var session = FlutterSession();
          // await session.set("username", userController.text);
          // await session.set("type", 0);
          Navigator.pushNamed(context, LoginSuccessScreen.routeName);
        }
      } else {
        ProcessDialog.closeLoadingDialog();
        passController.clear();
        userController.clear();
        addError(error: kInvalidPasPhoneError);
      }
    } catch (e) {
      print(e);
    }
  }

  // ----------end---------------

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text("Remember me"),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            height: 56,
            text: "Continue",
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                // if all are valid then go to success screen
                KeyboardUtil.hideKeyboard(context);
                // --------------backend--------------
                ProcessDialog.showLoadingDialog(context);
                _login();
                // --------------end--------------
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: passController,
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        // --------------backend--------------
        removeError(error: kInvalidPasPhoneError);
        // --------------end--------------
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: userController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        // --------------backend--------------
        removeError(error: kInvalidPasPhoneError);
        // --------------end--------------
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
        labelText: "Phone",
        hintText: "Enter your Phone",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/smartphone.svg"),
      ),
    );
  }
}
