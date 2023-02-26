import 'package:buildcondition/buildcondition.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/layout/shop_layout/cubit/shop_cubit.dart';
import 'package:flutter_shop_app/layout/shop_layout/cubit/shop_states.dart';
import 'package:flutter_shop_app/models/home_model.dart';
import 'package:flutter_shop_app/shared/colors.dart';

class ShopHome extends StatelessWidget {
  const ShopHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);

          return BuildCondition(
            condition: cubit.homeModel != null,
            builder: (context) => homeBuilder(cubit.homeModel!),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        });
  }

  Widget homeBuilder(HomeModel model) => SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: CarouselSlider(
                  items: model.data!.banners
                      .map((e) => Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(35),
                                      bottomLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8)),
                                  image: DecorationImage(
                                      image: NetworkImage(e.image),
                                      fit: BoxFit.cover)),
                              width: 600,
                            ),
                          ))
                      .toList(),
                  options: CarouselOptions(
                      height: 180,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 5,
                      viewportFraction: 1,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(seconds: 1),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      scrollDirection: Axis.horizontal)),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: 1,
                crossAxisSpacing: 2,
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.7,
                children: List.generate(model.data!.products.length,
                    (index) => buildGridItem(model.data!.products[index])),
              ),
            )
          ],
        ),
      );

  Widget buildGridItem(ProductModel product) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(product.image!),
                  width: double.infinity,
                  height: 200,
                ),
                if (product.oldPrice! != product.price!)
                  Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(fontSize: 8, color: Colors.white),
                      ),
                    ),
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name!!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(height: 1.3, fontSize: 13),
                  ),
                  Row(
                    children: [
                      Text(
                        '${product.price!.round()}',
                        style: TextStyle(
                            height: 1.3, fontSize: 13, color: defaultColor),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      if (product.oldPrice != 0)
                        Text(
                          '${product.oldPrice!.round()}',
                          style: TextStyle(
                              height: 1.3,
                              fontSize: 11,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.favorite_border))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      );
}
