import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoping_app/modules/shopping_app/login/cubit/cubit.dart';
import 'package:shoping_app/modules/shopping_app/login/cubit/states.dart';
import 'package:shoping_app/modules/shopping_app/register/shop_register.dart';
import 'package:shoping_app/shared/components/compones.dart';

class ShopLoginScreen extends StatelessWidget {
  const ShopLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var fromKey =GlobalKey<FormState>();
     var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit ,ShopLoginStates>(
        listener:(context,state) {
          if(state is ShopLoginSuccessState)
          {
            if(state.loginModel.status)
              {
                print(state.loginModel.message);
                print(state.loginModel.data.token);
                Fluttertoast.showToast(
                    msg: state.loginModel.message,
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 5,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0
                );

              }else
                {
                  print(state.loginModel.message);
                  Fluttertoast.showToast(
                      msg: state.loginModel.message,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 5,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                }
          }
        },
        builder: (context,state){
          return  Scaffold(
            appBar: AppBar(backgroundColor: Colors.white,
              elevation: 0.0,),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: fromKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('LOGIN',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text('Login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey
                          ),
                        ),
                        const  SizedBox(height: 30,),
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
                          isPassword:  ShopLoginCubit.get(context).isPassword,
                          suffix: ShopLoginCubit.get(context).suffix ,
                          suffixPressed: ()
                          {
                            ShopLoginCubit.get(context).changePasswordVisibility();
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
                          height: 40,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) =>  defaultButton(
                            isUpper: true,
                            function: ()
                            {
                              if(fromKey.currentState!.validate())
                              {
                                ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }

                            },
                            text: 'login',
                          ),
                          fallback: (context) => const Center(child:  CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children:  [
                            Text('Don\'t have an account?'),
                            defaultTextButton(
                              function: (){
                                navigateTo(
                                  context,
                                  ShopRegisterScreen(),
                                );
                              },
                              text: 'register',
                            ),
                          ],
                        )
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
