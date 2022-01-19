import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/model/search/search_model.dart';
import 'package:shoping_app/modules/shopping_app/search/cubit/states_search.dart';
import 'package:shoping_app/shared/end_points.dart';
import 'package:shoping_app/shared/local/cache_helper.dart';
import 'package:shoping_app/shared/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit  () : super(SearchInitialState());

  static  SearchCubit get(context) => BlocProvider.of(context);

  late SearchModel model;

  void search(String text)
  {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: 'products/search',
      data:
      {
        'text' :  text,
      },
      token: CacheHelper.getData(key: 'token')
    ).then((value)
    {
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}