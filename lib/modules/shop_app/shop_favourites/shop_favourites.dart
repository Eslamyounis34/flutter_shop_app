// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/models/user_favorites_model.dart';
import 'package:flutter_shop_app/shared/colors.dart';

import '../../../layout/shop_layout/cubit/shop_cubit.dart';
import '../../../layout/shop_layout/cubit/shop_states.dart';
import '../../../shared/components/components.dart';

class ShopFavourites extends StatelessWidget {
  const ShopFavourites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ListView.separated(
            itemBuilder: (context, index) =>
                buildFavGridItem(cubit.userFavoritesModel!.data!.data![index]),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: cubit.userFavoritesModel!.data!.data!.length);
      },
      listener: (context, state) {},
    );
  }

  Widget buildFavGridItem(ProductData product) => Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: NetworkImage(product.product!.image!),
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  height: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.product!.name!),
                      const Spacer(),
                      Text(
                        product.product!.price.toString(),
                        style: const TextStyle(color: defaultColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
