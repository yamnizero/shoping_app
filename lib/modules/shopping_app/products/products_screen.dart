import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/layout/shop_layout/cubit/cubit.dart';
import 'package:shoping_app/layout/shop_layout/cubit/states.dart';
import 'package:shoping_app/model/categories/categories_model.dart';
import 'package:shoping_app/model/home/home_model.dart';
import 'package:shoping_app/shared/color/colors.dart';
import 'package:shoping_app/shared/components/compones.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state)
      {
        if(state is ShopSuccessChangeFavoritesState)
        {
          if(!state.model.status)
          {
            showToast(
                text: state.model.message,
                states: ToastStates.ERROR,
            );
          }
        }
      },
      builder: (context, state) {
        // if (state is ShopLoadingHomeDataState) {
        //   return const Center(child: CircularProgressIndicator());
        // }
        // if (state is ShopSuccessHomeDataState && state is ShopSuccessCategoriesState ) {
        //   return productsBuilder(ShopCubit.get(context).homeModel,ShopCubit.get(context).categoriesModel);
        // }
        //  return const Center(child: Text('Error'));
         return  ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null  &&
              ShopCubit.get(context).categoriesModel != null ,
          builder: (context) => builderWidget(ShopCubit.get(context).homeModel!,
              ShopCubit.get(context).categoriesModel,context),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget builderWidget(HomeModel model,CategoriesModel categoriesModel,context) => SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data.banners
                  .map((e) => Image(
                        image: NetworkImage(e.image),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 250.0,
                initialPage: 0,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Categories',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                  ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                   SizedBox(
                   height: 100.0,
                   child: ListView.separated(
                     physics: const BouncingScrollPhysics(),
                     scrollDirection: Axis.horizontal,
                       itemBuilder: (context,index) => buildCategoryItem(categoriesModel.data.data[index],),
                       separatorBuilder: (context,index) => const SizedBox(width: 10.0,),
                       itemCount: categoriesModel.data.data.length,
                   ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text('New Products',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics:  const  NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1/1.53,
                children: List.generate(
                  model.data.products.length,
                  (index) => buildGridProduct(model.data.products[index],context),
                ),
              ),
            ),
          ],
        ),
  );

  Widget buildCategoryItem(DataModel model,) => Stack(
    alignment:AlignmentDirectional.bottomCenter ,
    children: [
       Image(
        image: NetworkImage(model.image),
        height: 100.0,
        width: 100.0,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(.8,),
        width: 100.0,
        child:  Text(
          model.name,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ],
  );

  Widget buildGridProduct(ProductModel model,context) => Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image: NetworkImage(model.image),
              width: double.infinity,
              height: 200.0,
            ),
             if(model.discount != 0)
             Container(
               color: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 5.0,),
              child: const Text(
                  'DISCOUNT',
              style: TextStyle(
                fontSize: 8.0,
                color: Colors.white
              ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(model.name,
              maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14.0,
                  height: 1.3
                ),
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: defaultColor,
                    ),
                  ),
                  const SizedBox(width: 5.0,),
                  if(model.discount != 0 )
                  Text(
                    '${model.oldPrice.round()}',
                    style: const TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: ()
                    {
                      ShopCubit.get(context).changeFavorites(model.id);
                      print(model.id);
                    },
                      icon:  CircleAvatar(
                        radius: 15,
                        backgroundColor: ShopCubit.get(context).favorites[model.id]!
                        ? Colors.red : Colors.grey,
                        child: const  Icon(
                            Icons.favorite_border,
                          size: 14.0,
                          color: Colors.white,
                        ),
                      ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
