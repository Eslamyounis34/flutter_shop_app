import 'package:flutter/material.dart';
import 'package:flutter_shop_app/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:flutter_shop_app/shared/styles.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      home: OnBoardingScreen(),
    );
  }
}


