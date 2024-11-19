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
    favoriteProductsList = [];
    products = [];
    searchResults = [];
    categoryProducts = [];
    userProducts = [];

    emit(GetDataLoading());
    try {
      Response response = await _apiServices.getData(
          "products_table?select=*,favorite_products(*),purchase_table(*)");
      for (var product in response.data) {
        products.add(ProductModel.fromJson(product));
      }
      search(query);
      getProductsByCategory(category);
      getFavoriteProducts();
      getUserProducts();
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

  // add To Favorite
  Future<void> addToFavorite(String productId) async {
    emit(AddToFavoriteLoading());
    try {
      await _apiServices.postData("favorite_products", {
        "for_user": userId,
        "for_product": productId,
        "is_favorite": true,
      });
      // get products
      await getProducts();
      favoriteProducts.addAll({
        productId: true,
      });
      log(favoriteProducts.toString());
      emit(AddToFavoriteSuccess());
    } catch (e) {
      log(e.toString());
      emit(AddToFavoriteError());
    }
  }

  // remove From Favorite
  Future<void> removeFromFavorite(String productId) async {
    emit(RemoveFromFavoriteLoading());
    try {
      await _apiServices.deleteData(
        "favorite_products?for_product=eq.$productId&for_user=eq.$userId",
      );
      // get products
      await getProducts();
      favoriteProducts.removeWhere((key, value) => key == productId);
      log(favoriteProducts.toString());
      emit(RemoveFromFavoriteSuccess());
    } catch (e) {
      log(e.toString());
      emit(RemoveFromFavoriteError());
    }
  }

  bool checkIsFavorite(String productId) {
    return favoriteProducts.containsKey(productId);
  }

  List<ProductModel> favoriteProductsList = [];
  // get favorite products
  void getFavoriteProducts() {
    for (var product in products) {
      if (product.favoriteProducts != null &&
          product.favoriteProducts!.isNotEmpty) {
        for (var favProduct in product.favoriteProducts!) {
          if (favProduct.forUser == userId) {
            favoriteProductsList.add(product);
            favoriteProducts.addAll({
              favProduct.forProduct!: true,
            });
          }
        }
      }
    }
  }

  // Buy product
  Future<void> buyProduct(String productId) async {
    emit(BuyProductLoading());
    try {
      await _apiServices.postData("purchase_table", {
        "for_user": userId,
        "for_product": productId,
        "is_bought": true,
      });
      await getProducts();
      emit(BuyProductSuccess());
    } catch (e) {
      log(e.toString());
      emit(BuyProductError());
    }
  }

   List<ProductModel> userProducts = [];
  // get favorite products
  void getUserProducts() {
    for (var product in products) {
      if (product.purchaseTable != null &&
          product.purchaseTable!.isNotEmpty) {
        for (var userProuct in product.purchaseTable!) {
          if (userProuct.forUser == userId) {
            userProducts.add(product);
           
          }
        }
      }
    }
  }
   bool checkIsBought(String productId) {
    return userProducts.any((element) => element.productId == productId);
  }

}
