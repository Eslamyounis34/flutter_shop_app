import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_shop_app/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:flutter_shop_app/shared/data/remote/dio_helper.dart';
import 'package:flutter_shop_app/shared/styles.dart';

void main() async {
  HttpOverrides.global = new MyHttpOverrides();

  DioHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      home: OnBoardingScreen(),
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
