import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/layout/shop_layout/cubit/shop_cubit.dart';
import 'package:flutter_shop_app/layout/shop_layout/cubit/shop_states.dart';
import 'package:flutter_shop_app/models/categories_model.dart';
import 'package:flutter_shop_app/shared/components/components.dart';

class ShopCategories extends StatelessWidget {
  const ShopCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ListView.separated(
            itemBuilder: (context, index) => buildCategoryScreenItem(
                cubit.categoriesModel!.data!.data[index]),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: cubit.categoriesModel!.data!.data.length);
      },
      listener: (context, state) {},
    );
  }

  Widget buildCategoryScreenItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image(height: 100, width: 100, image: NetworkImage(model.image!)),
            SizedBox(
              width: 10,
            ),
            Text(model.name!),
            Spacer(),
            IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios))
          ],
        ),
      );
}
