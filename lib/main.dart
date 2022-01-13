import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/layout/shop_layout/cubit/cubit.dart';
import 'package:shoping_app/layout/shop_layout/cubit/states.dart';
import 'package:shoping_app/layout/shop_layout/shop_layout.dart';
import 'package:shoping_app/modules/on_bording/on_boarding_screen.dart';
import 'package:shoping_app/shared/local/cache_helper.dart';
import 'package:shoping_app/shared/remote/dio_helper.dart';
import 'package:shoping_app/shared/theme.dart';


import 'modules/shopping_app/login/shop_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();

  Widget widget;
  //bool isDark = CacheHelper.getData(key: 'isDark');
     bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
     String? token = CacheHelper.getData(key: 'token');

     if(onBoarding != null)
     {
       if( token != null) widget =  ShopLayout();
       else widget = ShopLoginScreen();
     } else
       {
       widget = OnBoardScreen();
     }

  runApp( MyApp(

    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  //final bool isDark;
  final Widget startWidget;
   MyApp({Key? key,required this.startWidget}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => ShopCubit()..getHomeData(),
      child: BlocConsumer<ShopCubit,ShopStates> (
        listener: (context,state){},
        builder: (context,state){
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
           theme:lightTheme,
            //darkTheme: darkTheme,
            home: startWidget,
          );

        },
      ),
    );
  }
}



