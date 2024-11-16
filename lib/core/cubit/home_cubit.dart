import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:our_market/core/models/product_model/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../api_services.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeCubitInitial());
  final ApiServices _apiServices = ApiServices();
  final String userId = Supabase.instance.client.auth.currentUser!.id;

  List<ProductModel> products = [];
  List<ProductModel> searchResults = [];
  List<ProductModel> categoryProducts = [];
  Future<void> getProducts({String? query, String? category}) async {
    emit(GetDataLoading());
    try {
      Response response = await _apiServices.getData(
          "products_table?select=*,favorite_products(*),purchase_table(*)");
      for (var product in response.data) {
        products.add(ProductModel.fromJson(product));
      }
      search(query);
      getProductsByCategory(category);
      emit(GetDataSuccess());
    } catch (e) {
      log(e.toString());
      emit(GetDataError());
    }
  }

  void search(String? query) {
    if (query != null) {
      for (var product in products) {
        if (product.productName!.toLowerCase().contains(query.toLowerCase())) {
          searchResults.add(product);
        }
      }
    }
  }

  void getProductsByCategory(String? category) {
    if (category != null) {
      for (var product in products) {
        // "sports"
        if (product.category!.trim().toLowerCase() ==
            category.trim().toLowerCase()) {
          categoryProducts.add(product);
        }
      }
    }
  }

  Map<String, bool> favoriteProducts = {};
  // "product_id" : true
  // add To Favorite
  Future<void> addToFavorite(String productId) async {
    emit(AddToFavoriteLoading());
    try {
      await _apiServices.postData("favorite_products", {
        "is_favorite": true,
        "for_user": userId,
        "for_product": productId,
      });
      favoriteProducts.addAll({
        productId: true,
      });
      emit(AddToFavoriteSuccess());
    } catch (e) {
      log(e.toString());
      emit(AddToFavoriteError());
    }
  }

  bool checkIsFavorite(String productId) {
    return favoriteProducts.containsKey(productId);
  }
}
