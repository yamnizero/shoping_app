import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/layout/shop_layout/cubit/cubit.dart';
import 'package:shoping_app/layout/shop_layout/cubit/states.dart';
import 'package:shoping_app/model/categories/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state){
         return ListView.separated(
           itemBuilder: (context,index) => buildCatItem(ShopCubit.get(context).categoriesModel.data.data[index]),
           separatorBuilder: (context,index) =>  Container(
             width: double.infinity,
             height: 1.0,
             color: Colors.grey[300],
           ),
           itemCount:ShopCubit.get(context).categoriesModel.data.data.length  ,
         );
        },
        );
  }
  Widget buildCatItem(DataModel model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage(model.image),
          width: 80.0,
          height: 80.0,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          width: 20.0,
        ),
        Text(
          model.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        const Spacer(),
        const Icon(
          Icons.arrow_forward_ios,
        )
      ],
    ),
  );
}
