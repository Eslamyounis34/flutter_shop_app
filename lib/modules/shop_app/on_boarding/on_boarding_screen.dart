import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/models/BoardingModel.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/colors.dart';
import '../../../shared/components/components.dart';
import '../shop_login/shop_login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boardingList = [
    BoardingModel(
        image: 'assets/images/store_boarding.jpg',
        title: 'HY , ',
        body: 'Browse Our Online Store'),
    BoardingModel(
        image: 'assets/images/store_fourth.jpg',
        title: 'Hot Offers',
        body: 'Check Our Daily Offers And Don\'t Wasting Time'),
    BoardingModel(
        image: 'assets/images/store_boarding_second.jpg',
        title: 'Hurry Up',
        body: 'Order Your Favourite Items And Enjoy'),
  ];

  var boardingController = PageController();

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          TextButton(
              onPressed: () {
                navigteAndFinish(context, ShopLoginScreen());
              },
              child: Text(
                'SKIP',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) =>
                    buildingBoardingItem(boardingList[index]),
                itemCount: boardingList.length,
                physics: BouncingScrollPhysics(),
                controller: boardingController,
                onPageChanged: (int index) {
                  if (index == boardingList.length - 1) {
                    setState(() {
                      print('Last');
                      isLast = true;
                    });
                  } else {
                    isLast = false;
                  }
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingController,
                  count: boardingList.length,
                  effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      spacing: 5,
                      expansionFactor: 4,
                      dotWidth: 10,
                      dotHeight: 10,
                      activeDotColor: defaultColor),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      navigteAndFinish(context, ShopLoginScreen());
                    } else {
                      boardingController.nextPage(
                          duration: Duration(microseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildingBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage('${model.image}'))),
          SizedBox(
            height: 30,
          ),
          Text(
            "${model.title}",
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "${model.body}",
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey),
          )
        ],
      );
}
