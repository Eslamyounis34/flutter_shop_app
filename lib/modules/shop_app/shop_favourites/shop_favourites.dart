// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

import '../../../shared/colors.dart';

class ShopFavourites extends StatelessWidget {
  const ShopFavourites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Settings"));  }

  // Widget buildGridItem() => Container(
  //       color: Colors.white,
  //       child: Row(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           const Image(
  //             image: NetworkImage(
  //                 'https://student.valuxapps.com/storage/uploads/products/1615441020ydvqD.item_XXL_51889566_32a329591e022.jpeg'),
  //             height: 120,
  //             width: 120,
  //             fit: BoxFit.cover,
  //           ),
  //           const SizedBox(
  //             width: 10,
  //           ),
  //           Expanded(
  //             child: Column(
  //               children: const [
  //                 Text(
  //                     'تليفزيون سمارت 65 بوصة 4K الترا اتش دي منحني من سامسونج UA65RU7300RXUM'),
  //                 Spacer(),
  //                 Text('2000')
  //               ],
  //             ),
  //           )
  //         ],
  //       ),
  //     );
}
