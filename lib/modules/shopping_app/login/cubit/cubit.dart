import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/modules/shopping_app/login/cubit/states.dart';
import 'package:shoping_app/shared/end_points.dart';
import 'package:shoping_app/shared/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
  required String email,
  required String password,
}) {

    emit(ShopLoginLoadingState());

    DioHelper.postData(
        url: LOGIN,
        data: {
          'email':email,
          'password':password,
        },
    ).then((value) {
      print(value.data);
      emit(ShopLoginSuccessState());
    }).catchError((error){
      emit(ShopLoginErrorState(error.toString()));
    });
  }
}