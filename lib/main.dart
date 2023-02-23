import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/layout/shop_layout/cubit/shop_cubit.dart';
import 'package:flutter_shop_app/layout/shop_layout/shop_layout.dart';
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

  Widget startingWidget;
  String token = CacheHelper.getData(key: "token") ?? "";
  bool isBoarding = CacheHelper.getData(key: "onBoarding") ?? false;

  if (isBoarding != false) {
    if (token.isEmpty)
      startingWidget = ShopLoginScreen();
    else
      startingWidget = ShopLayout();
  } else {
    startingWidget = OnBoardingScreen();
  }
  print("testboarding" + isBoarding.toString());
  runApp(MyApp(
    widget: startingWidget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget widget;
  MyApp({required this.widget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ShopCubit()..getHomeData()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: lightTheme,
            darkTheme: darkTheme,
            home: widget));
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
