import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:our_market/core/api_services.dart';
import 'package:our_market/views/product_details/logic/models/rate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());
  final ApiServices _apiServices = ApiServices();

  List<Rate> rates = []; // rate.forUser == user id
  //rate ==> int
  // for_user ==> String (user id)
  int averageRate = 0;
  int userRate = 5;

  Future<void> getRates({required String productId}) async {
    emit(GetRateLoading());
    try {
      Response response = await _apiServices
          .getData("rates_table?select=*&for_product=eq.$productId");
      for (var rate in response.data) {
        rates.add(Rate.fromJson(rate));
      }
      _getAverageRate();
      _getUserRate();
      emit(GetRateSuccess());
    } catch (e) {
      log(e.toString());
      emit(GetRateSuccess());
    }
  }

  void _getUserRate() {
       List<Rate> userRates = rates
        .where((Rate rate) =>
            rate.forUser == Supabase.instance.client.auth.currentUser!.id)
        .toList();
    if (userRates.isNotEmpty) {
      userRate = userRates[0].rate!; // user rate
    }
  }

  void _getAverageRate() {
    for (var userRate in rates) {
      if (userRate.rate != null) {
        //[4,2,1,5,3]
        averageRate += userRate.rate!; //15
      }
    }
    averageRate = averageRate ~/ rates.length;
  }
}
