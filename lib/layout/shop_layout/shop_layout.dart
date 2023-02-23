import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/layout/shop_layout/cubit/shop_cubit.dart';
import 'package:flutter_shop_app/layout/shop_layout/cubit/shop_states.dart';
import 'package:flutter_shop_app/modules/shop_search/shop_search.dart';
import 'package:flutter_shop_app/shared/components/components.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Salla'),
            titleTextStyle: TextStyle(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, ShopSearch());
                  },
                  icon: Icon(Icons.search))
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              cubit.changeBottomSheet(value);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: 'Categories'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favourites'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ],
            currentIndex: cubit.current_index,
          ),
          body: cubit.screens[cubit.current_index],
        );
      },
    );
  }
}
