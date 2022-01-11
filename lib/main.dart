import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shoping_app/shared/cubit/cubit.dart';
import 'package:shoping_app/shared/cubit/states.dart';
import 'package:shoping_app/shared/local/cache_helper.dart';
import 'package:shoping_app/shared/remote/dio_helper.dart';

import 'modules/shopping_app/login/shop_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit,AppStates> (
        listener: (context,state){},
        builder: (context,state){
          return const MaterialApp(
            debugShowCheckedModeBanner: false,

            home: ShopLoginScreen(),
          );
        },
      ),
    );
  }
}



