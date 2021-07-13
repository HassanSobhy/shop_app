import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/search_states.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/network/remote/home_api_service.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  SearchModel searchModel;
  static SearchCubit get(BuildContext context) => BlocProvider.of(context);

  void searchProducts(String searchText) async {
    emit(SearchLoadingState());
    try{
      Response response = await HomeApiService.searchData(path: SEARCH, data: {
        "text": searchText,
      });
      searchModel = SearchModel.fromJson(response.data);
      if(searchModel.status){
        emit(SearchSuccessState());
      } else {
        emit(SearchErrorState());
      }
    } catch(e){

      print(e.toString());
      emit(SearchErrorState());

    }


  }
}
