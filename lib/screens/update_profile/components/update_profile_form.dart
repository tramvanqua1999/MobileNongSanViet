import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/models/Customer.dart';
import 'package:shop_app/models/request.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm({
    Key key,
  }) : super(key: key);

  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String firstName;
  String phoneNumber;
  String address;

  String password;
  String conform_password;
  String email;

  TextEditingController _name = TextEditingController();
  TextEditingController _mail = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _pass = TextEditingController();

  int id = 1;

  @override
  void initState() {
    super.initState();
  }

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

  Future saveprofile() async {
    print("name: " + _name.text);
    print("mail: " + _mail.text);
    print("address: " + _address.text);
    print("pass: " + _pass.text);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs?.getString("username");
    try {
      final response = await http.post(url + "saveprofile", body: {
        "name": _name.text,
        "mail": _mail.text,
        "address": _address.text,
        "pass": _pass.text,
        "username": json.encode(username),
      });
      print(response.body);
      if (response.body == "1") {
        final snackBar = SnackBar(
          content: Text('update successful'.tr().toString()),
          duration: Duration(seconds: 2),
          action: new SnackBarAction(
            label: 'success'.tr().toString(),
            onPressed: () {},
          ),
        );
        Scaffold.of(context).showSnackBar(snackBar);
      } else {
        final snackBar = SnackBar(
          content: Text('update failed'.tr().toString()),
          duration: Duration(seconds: 2),
          action: new SnackBarAction(
            label: 'Success',
            onPressed: () {
              // Some code to undo the change!
            },
          ),
        );
        Scaffold.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          FutureBuilder<Customer>(
              future: downloadJSONGetProfile(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Customer customer = snapshot.data;
                  _name.text = customer.name;
                  _address.text = customer.address;
                  _mail.text = customer.email;
                  return Column(children: [
                    buildFirstNameFormField(customer.name),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    buildEmailFormField(customer.email),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    buildAddressFormField(customer.address),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    buildPasswordFormField(),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    buildConformPassFormField(),
                    FormError(errors: errors),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    DefaultButton(
                      height: 56,
                      text: "update".tr().toString(),
                      press: () {
                        if (_formKey.currentState.validate()) {
                          saveprofile();
                          setState(() {});
                        }
                      },
                    ),
                  ]);
                } else {
                  return Container();
                }
              })
        ],
      ),
    );
  }

  TextFormField buildAddressFormField(String address) {
    return TextFormField(
      controller: _address,
      onSaved: (newValue) => address = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "address".tr().toString(),
        // hintText: address,

        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField(String name) {
    return TextFormField(
      controller: _name,
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "first and last name".tr().toString(),
        // hintText: name,
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

// -----------------------------------Pass
  TextFormField buildConformPassFormField() {
    return TextFormField(
      controller: _pass,
      obscureText: true,
      onSaved: (newValue) => conform_password = newValue,
      onChanged: (value) {
        removeError(error: kMatchPassError);
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        }
        conform_password = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "confirm password".tr().toString(),
        hintText: "re-enter your password".tr().toString(),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        removeError(error: kShortPassError);
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        }
        password = value;
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
        labelText: "password".tr().toString(),
        hintText: "enter your password".tr().toString(),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField(String email) {
    return TextFormField(
      controller: _mail,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        removeError(error: kInvaliEmailNullErrorreal);
        if (value.isNotEmpty) {
          removeError(error: kEmailNullErrorreal);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullErrorreal);
          return "";
        } else if (!emailValidatorRegExpreal.hasMatch(value)) {
          addError(error: kInvaliEmailNullErrorreal);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        // hintText: email,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
