import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/layout/shop_layout/cubit/cubit.dart';
import 'package:shoping_app/layout/shop_layout/cubit/states.dart';
import 'package:shoping_app/model/home/home_model.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return  BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        print(state);
      },
      builder: (context,state)
      {
        if(state is ShopLoadingHomeDataState){
          return const  Center(child:CircularProgressIndicator());
        }
        if (state is ShopSuccessHomeDataState)
          {
            return productsBuilder(ShopCubit.get(context).homeModel!);
          }
        return const Center(child:Text('Error'));

      },

    );
  }


  Widget productsBuilder(HomeModel model) => Column(
    children:   [
      CarouselSlider(
          items: model.data.banners.map((e) =>  Image(
              image:  NetworkImage('${e.image}'),
              width: double.infinity,
              fit: BoxFit.cover,
            )
          ).toList(),
          options: CarouselOptions(
            height: 250.0,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(seconds:1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          ),
      )
    ],
  );

}
