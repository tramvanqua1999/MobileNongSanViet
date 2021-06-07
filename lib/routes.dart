import 'package:flutter/widgets.dart';
import 'package:shop_app/profileshop/profile_screen.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/screens/details_Shop/details_screen.dart';
import 'package:shop_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/login_success/login_success_screen.dart';
import 'package:shop_app/screens/otp/otp_screen.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/screens/products/products_screen.dart';
import 'package:shop_app/screens/update_profile/update_profile_screen.dart';
import 'screens/sign_up/sign_up_screen.dart';
import 'screens/register/sign_up_screen.dart';
import 'package:shop_app/screens/list_followed/list_follow_screen.dart';
import 'package:shop_app/screens/list_favorite/list_favorite_screen.dart';
import 'package:shop_app/screens/rules/rules_screen.dart';
import 'package:shop_app/screens/payment/payment_screen.dart';
import 'package:shop_app/screens/payment/components/existing-cards.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  DetailsScreenShop.routeName: (context) => DetailsScreenShop(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  ProductScreen.routeName: (context) => ProductScreen(),
  ServieProfileScreen.routeName: (context) => ServieProfileScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen(),
  UpdateProfileScreen.routeName: (content) => UpdateProfileScreen(),
  ListFollowScreen.routeName: (content) => ListFollowScreen(),
  ListFavoriteScreen.routeName: (content) => ListFavoriteScreen(),
  RulesScreen.routeName: (content) => RulesScreen(),
  PaymentScreen.routeName: (content) => PaymentScreen(),
  ExistingCardsPage.routeName: (content) => ExistingCardsPage()
};
