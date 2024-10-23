import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:our_market/core/api_services.dart';
import 'package:our_market/views/product_details/logic/models/rate.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());
  final ApiServices _apiServices = ApiServices();

  List<Rate> rates = []; //rate ==> int
  int averageRate = 0;

  Future<void> getRates({required String productId}) async {
    emit(GetRateLoading());
    try {
      Response response = await _apiServices
          .getData("rates_table?select=*&for_product=eq.$productId");
      for (var rate in response.data) {
        rates.add(Rate.fromJson(rate));
      }
      _getAverageRate();
      log(averageRate.toString());
      emit(GetRateSuccess());
    } catch (e) {
      log(e.toString());
      emit(GetRateSuccess());
    }
  }

  void _getAverageRate() {
    for (var userRate in rates) {
      log(userRate.rate.toString());
      if (userRate.rate != null) {
        //[4,2,1,5,3]
        averageRate += userRate.rate!; //15
      }
    }
    averageRate = averageRate ~/ rates.length;
  }
}
