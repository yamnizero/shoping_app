import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/layout/shop_layout/cubit/cubit.dart';
import 'package:shoping_app/layout/shop_layout/cubit/states.dart';
import 'package:shoping_app/shared/components/compones.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final fromKey =GlobalKey<FormState>();

    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();

    return  BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state) =>
      {
      },
      builder: (context,state)
      {
        print('here---->  get data');
          final model =ShopCubit.get(context).userModel!;
           nameController.text = model.data!.name!;
          emailController.text = model.data!.email!;
          phoneController.text = model.data!.phone!;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: fromKey,
                  child: Column(
                    children: [
                      if(state is ShopLoadingUpdateUserState)
                     const LinearProgressIndicator(),
                      const SizedBox(height: 20.0,),
                      defaultTextForm(
                        controller: nameController,
                        type: TextInputType.name,
                        validation: (String? value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'name must not be empty';
                          }
                        },
                        label: 'Name',
                        prefix: Icons.person,
                      ),
                      const SizedBox(height: 20.0,),
                      defaultTextForm(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validation: (String? value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'email must not be empty';
                          }
                        },
                        label: 'Email Address',
                        prefix: Icons.email,
                      ),
                      const SizedBox(height: 20.0,),
                      defaultTextForm(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validation: (String? value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'phone must not be empty';
                          }
                        },
                        label: 'Phone',
                        prefix: Icons.phone,
                      ),
                      const SizedBox(height: 20.0,),
                      defaultButton(
                        function: ()
                        {
                          if(fromKey.currentState!.validate())
                            {
                              ShopCubit.get(context).updateUserDataSetting(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                              );
                            }
                          print('here----update');
                        },
                        text: 'Update',
                      ),
                      const SizedBox(height: 20.0,),
                      defaultButton(
                        function: ()
                        {
                          singOut(context);
                        },
                          text: 'Logout',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
