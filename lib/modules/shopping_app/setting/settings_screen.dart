import 'dart:math';

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
    var fromKey =GlobalKey<FormState>();
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();

    return  BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state) =>
      {
        if(state is ShopSuccessUserDataState)
        {

        }

      },
      builder: (context,state)
      {
        var model =ShopCubit.get(context).userModel;
        nameController.text = model.data.name;
        emailController.text = model.data.email;
       phoneController.text = model.data.phone;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: fromKey,
              child: Column(
                children: [
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
                ],
              ),
            ),
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
