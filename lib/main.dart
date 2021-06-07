import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var check = prefs?.getString("username");

  final MyApp myApp = MyApp(
      initialRoute: check == null || check == ""
          ? SplashScreen.routeName
          : HomeScreen.routeName);

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en', 'EN'), Locale('vi', 'VN')],
        path: 'assets/translations', // <-- change patch to your
        fallbackLocale: Locale('vi', 'VN'),
        child: myApp),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  MyApp({this.initialRoute});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: theme(),
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      initialRoute: initialRoute,
      routes: routes,
    );
  }
}
