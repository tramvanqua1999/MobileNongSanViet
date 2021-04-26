import 'package:flutter/material.dart';
import 'package:shop_app/size_config.dart';

const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);
// --------------backend-------------
const url = "http://10.0.2.2:8000/api/phone/";
// const url = "http://192.168.10.2:8000/api/phone/";
// --------------end-----------------

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp = RegExp(r'(0[3|5|7|8|9])+([0-9]{8})$');
final RegExp emailValidatorRegExpreal =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Vui lòng nhập số điện thoại";
const String kEmailNullErrorreal = "Vui lòng nhập email";

const String kInvaliEmailNullErrorreal = "Vui lòng kiểm tra lại email";
const String kInvalidEmailError = "Số điện thoại không chính xác";
const String kPassNullError = "Vui lòng nhập mật khẩu của bạn";
const String kShortPassError =
    "Mật khẩu quá ngắn ( mật khẩu cần lớn hơn 8 ký tự )";
const String kMatchPassError = "Mật khẩu không trùng khớp";
const String kNamelNullError = "Vui lòng nhập tên của bạn";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Vui lòng nhập địa chỉ";
// -------------------
const String kInvalidPasPhoneError = "Phone Or Password don't correct";
// -------------------
final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}

// ------------------------Error--------------------
// Error:Login --- https://gitmemory.com/issue/flutter/flutter/66275/696447343
