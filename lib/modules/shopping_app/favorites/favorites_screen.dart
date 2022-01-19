import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/layout/shop_layout/cubit/cubit.dart';
import 'package:shoping_app/layout/shop_layout/cubit/states.dart';
import 'package:shoping_app/model/favorites/fav_model.dart';
import 'package:shoping_app/shared/color/colors.dart';
import 'package:shoping_app/shared/components/compones.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state){
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder: (context) => ListView.separated(
            itemBuilder: (context,index) => buildListProduct(ShopCubit.get(context).favoritesModel!.data.data[index].product!,context),
            separatorBuilder: (context,index) =>  Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
            itemCount:ShopCubit.get(context).favoritesModel!.data.data.length,
          ),
          fallback: (context) => const  Center(child: CircularProgressIndicator()),
        );
      },
    );
  }



}
