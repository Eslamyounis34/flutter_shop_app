import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/modules/shop_app/shop_login/cubit/login_states.dart';
import 'package:flutter_shop_app/shared/data/remote/dio_helper.dart';


class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({required String email, required String password}) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: 'login', data:
    {
      'email': email,
      'password': password,
    },).then((value) {
      print('Response '+value.toString());
      emit(ShopLoginSuccessState());
    }).catchError((error) {
      print('Error '+error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }
}
