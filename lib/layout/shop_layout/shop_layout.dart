import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/layout/shop_layout/cubit/cubit.dart';
import 'package:shoping_app/layout/shop_layout/cubit/states.dart';
import 'package:shoping_app/modules/shopping_app/search/search_screen.dart';
import 'package:shoping_app/shared/components/compones.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Salla'),
            actions: [
              IconButton(
               icon: const Icon(Icons.search),
                  onPressed: ()
                  {
                    navigateTo(context, const SearchScreen());
                  },
              )
            ],
          ),
          body: cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index)
            {
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex ,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home
                ),
                label: 'Home'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.apps
                ),
                label: 'Categories'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite
                ),
                label: 'Favorites'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings
                ),
                label: 'Settings'
              ),
            ],
          ),
        );
      },
    );
  }
}
