import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/layout/shop_layout/cubit/cubit.dart';
import 'package:shoping_app/layout/shop_layout/cubit/states.dart';
import 'package:shoping_app/shared/color/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state){
        return ListView.separated(
          itemBuilder: (context,index) => buildFavItem(),
          separatorBuilder: (context,index) =>  Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ),
          itemCount:10 ,
        );
      },
    );
  }

  Widget buildFavItem() => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120.0,
      child: Row(
        children:  [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(image: NetworkImage('https://student.valuxapps.com/storage/uploads/products/1615440322npwmU.71DVgBTdyLL._SL1500_.jpg'),
                width: 120.0,
                height: 120.0,
                fit: BoxFit.cover,
              ),
              if(1 != 0)
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
          const SizedBox(width: 20.0,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text('Apple iphone 12 pro',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 14.0,
                      height: 1.3
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      '20000',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: defaultColor,
                      ),
                    ),
                    const SizedBox(width: 5.0,),
                    if(1 != 0 )
                      Text(
                        '3000',
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
                        // ShopCubit.get(context).changeFavorites(model.id);
                        // print(model.id);
                      },
                      icon:  CircleAvatar(
                        radius: 15,
                        backgroundColor: true
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
    ),
  );

}
