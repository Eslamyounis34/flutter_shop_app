import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_shop_app/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:flutter_shop_app/modules/shop_app/shop_login/shop_login_screen.dart';
import 'package:flutter_shop_app/shared/data/local/chache_helper.dart';
import 'package:flutter_shop_app/shared/data/remote/dio_helper.dart';
import 'package:flutter_shop_app/shared/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();

  DioHelper.init();
  await CacheHelper.init();
  bool isBoarding = CacheHelper.getData(key: "onBoarding") ?? false;
  print("testboarding" + isBoarding.toString());
  runApp(MyApp(
    onBoarding: isBoarding,
  ));
}

class MyApp extends StatelessWidget {
  final bool onBoarding;
  MyApp({required this.onBoarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      home: onBoarding ? ShopLoginScreen() : OnBoardingScreen(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
