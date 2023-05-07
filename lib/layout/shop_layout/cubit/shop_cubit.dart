import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/layout/shop_layout/cubit/shop_states.dart';
import 'package:flutter_shop_app/models/categories_model.dart';
import 'package:flutter_shop_app/models/change_favorites_model.dart';
import 'package:flutter_shop_app/models/user_favorites_model.dart';
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
  HomeModel? homeModel;
  CategoriesModel? categoriesModel;
  FavoritesModel? favoritesModel;
  UserFavoritesModel? userFavoritesModel;
  Map<int, bool> favorites = {};
  var token = CacheHelper.getData(key: 'token');

  List<Widget> screens = [
    const ShopHome(),
    const ShopCategories(),
    const ShopFavourites(),
    const ShopSettings(),
  ];

  void changeBottomSheet(int index) {
    current_index = index;
    emit(ChangeBottomNav());
  }

  void getHomeData() {
    emit(ShopHomeDataLoading());
    DioHelper.getData(url: HOME, token: '').then((value) {
      emit(ShopHomeDataSuccess());
      homeModel = HomeModel.fromJson(value.data);
      for (var element in homeModel!.data!.products) {
        favorites.addAll({
          element.id!: element.inFavorite!,
        });
      }
      print(homeModel!.status.toString());
    }).catchError((onError) {
      print('Error ' + onError.toString());
      emit(ShopHomeDataError());
    });
  }

  void getCategoriesData() {
    // emit(ShopCategoriesDataLoading());
    DioHelper.getData(url: CATEGORIES, token: '').then((value) {
      emit(ShopCategoriesDataSuccess());
      categoriesModel = CategoriesModel.fromjson(value.data);
      print(categoriesModel!.status.toString());
    }).catchError((onError) {
      print('Error ' + onError.toString());
      emit(ShopCategoriesDataError());
    });
  }

  void changeFavourite(int productID) {
    favorites[productID] = !favorites[productID]!;
    emit(ShopChangeFavoritesSuccess());

    print(token);
    DioHelper.postData(
            url: FAVORITES, data: {'product_id': productID}, token: token)
        .then((value) {
      print('Favourites Value : ' + value.toString());
      favoritesModel = FavoritesModel.fromJson(value.extra);
      if (!favoritesModel!.status!) {
        favorites[productID] = !favorites[productID]!;
      }
      emit(ShopChangeFavoritesSuccess());
    }).catchError((onError) {
      favorites[productID] = !favorites[productID]!;
      emit(ShopChangeFavoritesError());
      print('Error Favorites : ' + onError.toString());
    });
  }

  void getFavourites() {
    DioHelper.getData(url: FAVORITES, token: CacheHelper.getData(key: 'token'))
        .then((value) {
      emit(ShopGetFavoritesSuccess());
      print('Favorites : ' + value.toString());
      userFavoritesModel = UserFavoritesModel.fromJson(value.data);
    }).catchError((onError) {
      emit(ShopGetFavoritesError());
      print(onError.toString());
    });
  }
}
