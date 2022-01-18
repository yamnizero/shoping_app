import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/layout/shop_layout/shop_layout.dart';
import 'package:shoping_app/modules/shopping_app/login/cubit/cubit.dart';
import 'package:shoping_app/modules/shopping_app/register/cubit/cubit.dart';
import 'package:shoping_app/modules/shopping_app/register/cubit/states.dart';
import 'package:shoping_app/shared/components/compones.dart';
import 'package:shoping_app/shared/components/constants.dart';
import 'package:shoping_app/shared/local/cache_helper.dart';

class ShopRegisterScreen extends StatelessWidget {
  const ShopRegisterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context)
  {
    final fromKey =GlobalKey<FormState>();

    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final phoneController = TextEditingController();

  return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
    child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
      listener: (context,state)
      {
        if(state is ShopRegisterSuccessState)
        {
          if(state.loginModel.status!)
          {
            // print(state.loginModel.message);
            //print(state.loginModel.data!.token);
            CacheHelper.saveData(
              key: 'token',
              value: state.loginModel.data!.token!,
            ).then((value)
            {
              token = state.loginModel.data!.token!;

              navigateAndFinish(context, const ShopLayout());
            });
          }else
          {
            print(state.loginModel.message);
            showToast(
              text: state.loginModel.message!,
              states: ToastStates.ERROR,
            );
          }
        }
      },
      builder: (context,state){
        return  Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: fromKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('REGISTER',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text('Register now to browse our hot offers',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey
                        ),
                      ),
                      const  SizedBox(height: 30,),
                      defaultTextForm(
                        controller: nameController,
                        type: TextInputType.name,
                        validation: (value)
                        {
                          if(value!.isEmpty){
                            return 'please enter your name';
                          }
                        },
                        label: 'Name',
                        prefix: Icons.person,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultTextForm(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validation: (value)
                        {
                          if(value!.isEmpty){
                            return 'please enter your email';
                          }
                        },
                        label: 'Email Address',
                        prefix: Icons.email_outlined,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultTextForm(
                        controller: passwordController,
                        isPassword:  ShopRegisterCubit.get(context).isPassword,
                        suffix: ShopRegisterCubit.get(context).suffix ,
                        suffixPressed: ()
                        {
                          ShopRegisterCubit.get(context).changePasswordVisibility();
                        },
                        type: TextInputType.visiblePassword,
                        validation: (value)
                        {
                          if(value!.isEmpty){
                            return 'password is too short';
                          }
                        },
                        label: 'Password',
                        prefix: Icons.lock,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultTextForm(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validation: (value)
                        {
                          if(value!.isEmpty){
                            return 'please enter your phone';
                          }
                        },
                        label: 'Phone',
                        prefix: Icons.phone,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ConditionalBuilder(
                        condition: state is! ShopRegisterLoadingState,
                        builder: (context) =>  defaultButton(
                          isUpper: true,
                          function: ()
                          {
                            if(fromKey.currentState!.validate())
                            {
                              ShopRegisterCubit.get(context).userRegister(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          text: 'register',
                        ),
                        fallback: (context) => const Center(child:  CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },

    ),
  );
  }
}
