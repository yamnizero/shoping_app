import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/model/login/login_model.dart';
import 'package:shoping_app/modules/shopping_app/register/cubit/states.dart';
import 'package:shoping_app/shared/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);
   ShopLoginModel? loginModel;

  void userRegister({
  required String name,
  required String email,
  required String password,
  required String phone,
}) {

    emit(ShopRegisterLoadingState());

    DioHelper.postData(
        url: 'register',
        data: {
          'name':name,
          'email':email,
          'password':password,
          'phone':phone,
        },
    ).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((error){
      emit(ShopRegisterErrorState(error.toString()));
    });
  }


 IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined :Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordVisibilityState());

  }

}