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
  String userId = Supabase.instance.client.auth.currentUser!.id;

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
    List<Rate> userRates = rates.where((Rate rate) {
      return rate.forUser == userId;
    }).toList();
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
    if (rates.isNotEmpty) {
      averageRate = averageRate ~/ rates.length;
    }
  }

  bool _isUserRateExist({required String productId}) {
    for (var rate in rates) {
      if ((rate.forUser == userId) && (rate.forProduct == productId)) {
        return true;
      }
    }
    return false;
  }

  Future<void> addOrUpdateUserRate(
      {required String productId, required Map<String, dynamic> data}) async {
    // user rate exist ==> update for user rate
    // user doesn't exist ==> add rate
    String path =
        "rates_table?select=*&for_user=eq.$userId&for_product=eq.$productId";
    emit(AddOrUpdateRateLoading());
    try {
      if (_isUserRateExist(productId: productId)) {
        // user rate exist ==> update for user rate
        // patch data
        await _apiServices.patchData(path, data);
      } else {
        // post rate
        await _apiServices.postData(path, data);
      }

      emit(AddOrUpdateRateSuccess());
    } catch (e) {
      log(e.toString());
      emit(AddOrUpdateRateError());
    }
  }

  Future<void> addComment({required Map<String, dynamic> data}) async {
    emit(AddCommentLoading());
    try {
      await _apiServices.postData("comments_table", data);
      emit(AddCommentSuccess());
    } catch (e) {
      log(e.toString());
      emit(AddCommentError());
    }
  }
}
