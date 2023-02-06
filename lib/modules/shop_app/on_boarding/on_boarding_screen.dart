import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/models/BoardingModel.dart';
import 'package:flutter_shop_app/modules/shop_app/on_boarding/shop_login/shop_login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/colors.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boardingList = [
    BoardingModel(
        image: 'assets/images/store.png',
        title: 'Boarding One',
        body: 'Content 1'),
    BoardingModel(
        image: 'assets/images/store.png',
        title: 'Boarding Two',
        body: 'Content 2'),
    BoardingModel(
        image: 'assets/images/store.png',
        title: 'Boarding Three',
        body: 'Content 3'),
  ];

  var boardingController = PageController();

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                  }else{
                    isLast= false;
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
                      navigateTo(context, ShopLoginScreen());
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
            height: 15,
          ),
          Text(
            "${model.body}",
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          )
        ],
      );

  void navigateTo(context, widget) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}
