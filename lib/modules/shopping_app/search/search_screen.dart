import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/shared/components/compones.dart';
import 'cubit/cubit_search.dart';
import 'cubit/states_search.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final searchController = TextEditingController();


    return  BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return  Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultTextForm(
                        controller: searchController,
                        type: TextInputType.text,
                        validation: (String? value)
                        {
                          if(value!.isEmpty)
                            {
                              return 'error text to search';
                            }
                        },
                      onSubmit: (String text)
                      {
                        SearchCubit.get(context).search(text);
                      },
                        label: 'Search',
                        prefix: Icons.search,
                    ),
                    const SizedBox(height: 10.0,),
                   if(state is SearchLoadingState)
                   const LinearProgressIndicator(),
                    const SizedBox(height: 10.0,),
                    if(state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context,index) => buildListProduct(SearchCubit.get(context).model.data.data[index],context,isOldPrice: false),
                        separatorBuilder: (context,index) =>  Container(
                          width: double.infinity,
                          height: 1.0,
                          color: Colors.grey[300],
                        ),
                        itemCount:SearchCubit.get(context).model.data.data.length,
                      ),
                    ),
                  ],
                ),
              ),
            )
          );
        },
      ),
    );
  }
}
