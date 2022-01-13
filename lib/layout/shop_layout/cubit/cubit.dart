import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/layout/shop_layout/cubit/states.dart';
import 'package:shoping_app/model/home/home_model.dart';
import 'package:shoping_app/modules/shopping_app/cateogries/cateogries_screen.dart';
import 'package:shoping_app/modules/shopping_app/favorites/favorites_screen.dart';
import 'package:shoping_app/modules/shopping_app/products/products_screen.dart';
import 'package:shoping_app/modules/shopping_app/setting/settings_screen.dart';
import 'package:shoping_app/shared/components/constants.dart';
import 'package:shoping_app/shared/end_points.dart';
import 'package:shoping_app/shared/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) =>BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreen = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const SettingsScreen(),
  ];
  void changeBottom(int index)
  {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

   HomeModel? homeModel;

  void getHomeData()
  {

    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
        url: HOME,
      token: token,
    ).then((value)
    {
      homeModel = HomeModel.fromJson(value.data);
      emit(ShopSuccessHomeDataState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }
}