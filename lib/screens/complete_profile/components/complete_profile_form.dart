import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm({
    Key key,
    @required this.phone,
  }) : super(key: key);
  final String phone;

  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState(phone);
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  _CompleteProfileFormState(this.phone);
  String phone;
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String firstName;
  // String lastName;
  String phoneNumber;
  String address;
  int checkradio = 1;

  String password;
  String conform_password;
  String email;
  // ---------------------
  TextEditingController _name = TextEditingController();
  TextEditingController _mail = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _pass = TextEditingController();
  // ---------------------

  String radioButtonItem = 'ONE';
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

  Future _register() async {
    print("phone: " + phone);
    print("check: " + checkradio.toString());
    print("name: " + _name.text);
    print("mail: " + _mail.text);
    print("address: " + _address.text);
    print("pass: " + _pass.text);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final response = await http.post(url + "register", body: {
        "phone": phone,
        "check": json.encode(checkradio),
        "name": _name.text,
        "mail": _mail.text,
        "address": _address.text,
        "pass": _pass.text,
      });

      if (response.body == "1") {
        print("Sucessfully: " + response.body);
        prefs?.setString("isLoggedIn", "0");
        prefs?.setString("username", phone);
        prefs?.setString("type", "0");
        Alert(
          context: context,
          type: AlertType.success,
          title: "Thành công",
          desc: "Tạo tài khoản thành công",
          buttons: [
            DialogButton(
              child: Text(
                "OK",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () =>
                  Navigator.pushNamed(context, HomeScreen.routeName),
              width: 50,
            )
          ],
        ).show();
      } else if (response.body == "2") {
        print("Sucessfully: " + response.body);
        Alert(
          context: context,
          type: AlertType.success,
          title: "Tạo tài khoản thành công",
          desc:
              "Vui lòng đến địa chỉ Website sau để tiến hành bán hàng \n http:\\ShopHandmade.abc.xyz.vn",
          buttons: [
            DialogButton(
              child: Text(
                "OK",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () =>
                  Navigator.pushNamed(context, SignInScreen.routeName),
              width: 50,
            )
          ],
        ).show();
      } else {
        print("Fail: " + response.body);
      }
      // if (response.body != "999") {
      //   ProcessDialog.closeLoadingDialog();
      //   if (response.body == "0") {
      //     if (remember) {
      //       prefs?.setString("isLoggedIn", response.body);
      //     }

      //     prefs?.setString("username", userController.text);
      //     prefs?.setString("type", "0");
      //     // var session = FlutterSession();
      //     // await session.set("username", userController.text);
      //     // await session.set("type", 0);
      //     Navigator.pushNamed(context, LoginSuccessScreen.routeName);
      //   }
      // } else {
      //   ProcessDialog.closeLoadingDialog();
      //   passController.clear();
      //   userController.clear();
      //   addError(error: kInvalidPasPhoneError);
      // }
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
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildAddressFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildConformPassFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          // -------------------------------
          Text("Vui lòng chọn loại tài khoản",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Radio(
                value: 1,
                groupValue: id,
                onChanged: (val) {
                  setState(() {
                    radioButtonItem = 'ONE';
                    checkradio = val;

                    id = 1;
                  });
                },
              ),
              Text(
                'Khách Hàng',
                style: new TextStyle(fontSize: 17.0),
              ),
              Radio(
                value: 2,
                groupValue: id,
                onChanged: (val) {
                  setState(() {
                    radioButtonItem = 'TWO';
                    checkradio = val;
                    id = 2;
                  });
                },
              ),
              Text(
                'Cửa hàng',
                style: new TextStyle(
                  fontSize: 17.0,
                ),
              ),
            ],
          ),

          // -------------------------------
          DefaultButton(
            height: 56,
            text: "Đăng ký",
            press: () {
              if (_formKey.currentState.validate()) {
                _register();
                // Navigator.pushNamed(context, OtpScreen.routeName);
                // Navigator.pushNamed(context, CompleteProfileScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildAddressFormField() {
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
        labelText: "Địa chỉ",
        hintText: "Nhập địa chỉ hiện tại",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
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
        labelText: "Họ và tên",
        hintText: "Nhập tên khách hàng/cửa hàng",
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
        labelText: "Xác nhận mật khẩu",
        hintText: "Nhập lại mật khẩu của bạn",
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
        labelText: "Mật khẩu",
        hintText: "Nhập mật khẩu của bạn",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
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
        hintText: "Nhập email của bạn",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
