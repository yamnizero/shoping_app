import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
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
            title: const Text('Salla'),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  navigateTo(context, const SearchScreen());
                },
              )
            ],
          ),
          body: OfflineBuilder(
            connectivityBuilder: (
              BuildContext context,
              ConnectivityResult connectivity,
              Widget child,
            ) {
              final bool connected = connectivity != ConnectivityResult.none;
              if (connected) {
                return cubit.bottomScreen[cubit.currentIndex];
              } else {
                return Stack(

                  fit: StackFit.expand,
                  children: [
                    Positioned(
                      height: 40.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        color:
                            connected ? const Color(0xFF00EE44) : const Color(0xFFEE4400),
                        child: Column(
                          children: [
                           const LinearProgressIndicator(),
                            Center(
                              child: Text(connected ? 'ONLINE' : 'OFFLINE',
                                style: const TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),

                    const Center(
                      child:  Text(
                        'Just turn on your internet!',
                        style: TextStyle(
                            color: Colors.black
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
            child: Container()
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps), label: 'Categories'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favorites'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ],
          ),
        );
      },
    );
  }
}
