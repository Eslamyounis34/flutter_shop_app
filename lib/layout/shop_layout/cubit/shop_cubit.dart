import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/layout/shop_layout/cubit/shop_states.dart';
import 'package:flutter_shop_app/models/login_model.dart';
import 'package:flutter_shop_app/modules/shop_app/shop_categories/shop_categories.dart';
import 'package:flutter_shop_app/modules/shop_app/shop_favourites/shop_favourites.dart';
import 'package:flutter_shop_app/modules/shop_app/shop_home/shop_home.dart';
import 'package:flutter_shop_app/modules/shop_app/shop_settings/shop_settings.dart';
import 'package:flutter_shop_app/shared/data/local/chache_helper.dart';
import 'package:flutter_shop_app/shared/data/remote/dio_helper.dart';
import 'package:flutter_shop_app/shared/data/remote/end_points.dart';

import '../../../models/home_model.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int current_index = 0;
  late HomeModel homeModel;

  List<Widget> screens = [
    ShopHome(),
    ShopCategories(),
    ShopFavourites(),
    ShopSettings(),
  ];

  void changeBottomSheet(int index) {
    current_index = index;
    emit(ChangeBottomNav());
  }

  void getHomeData() {
    emit(ShopHomeDataLoading());
    String token = CacheHelper.getData(key: 'token');
    print('token ' + token.toString());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value!.data);
      // print(homeModel.data!.banners![0].image.toString());
      print(homeModel.status.toString());
      emit(ShopHomeDataSuccess());
    }).catchError((onError) {
      print('Error ' + onError.toString());
      emit(ShopHomeDataError());
    });
  }
}
