import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:our_market/core/models/product_model/favorite_product.dart';
import 'package:our_market/core/models/product_model/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../api_services.dart';
import '../models/product_model/purchase_table.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeCubitInitial());
  final ApiServices _apiServices = ApiServices();
  final String userId = Supabase.instance.client.auth.currentUser!.id;

  List<ProductModel> products = [];
  List<ProductModel> searchResults = [];
  List<ProductModel> categoryProducts = [];
  Future<void> getProducts({String? query, String? category}) async {
    products = [];
    searchResults = [];
    categoryProducts = [];
    favoriteProductList = [];
    userOrders = [];
    emit(GetDataLoading());
    try {
      Response response = await _apiServices.getData(
          "products_table?select=*,favorite_products(*),purchase_table(*)");
      for (var product in response.data) {
        products.add(ProductModel.fromJson(product));
      }
      getFavoriteProducts();
      search(query);
      getProductsByCategory(category);
      getUserOrdersProducts();
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

      await getProducts();
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
  // remove from favorite

  Future<void> removeFavorite(String productId) async {
    emit(RemoveFromFavoriteLoading());
    try {
      await _apiServices.deleteData(
          "favorite_products?for_user=eq.$userId&for_product=eq.$productId");
      await getProducts();
      favoriteProducts.removeWhere((key, value) => key == productId);
      emit(RemoveFromFavoriteSuccess());
    } catch (e) {
      log(e.toString());
      emit(RemoveFromFavoriteError());
    }
  }

  // get favorite products
  List<ProductModel> favoriteProductList = [];
  void getFavoriteProducts() {
    for (ProductModel product in products) {
      if (product.favoriteProducts != null &&
          product.favoriteProducts!.isNotEmpty) {
        for (FavoriteProduct favoriteProduct in product.favoriteProducts!) {
          if (favoriteProduct.forUser == userId) {
            favoriteProductList.add(product);
            favoriteProducts.addAll({product.productId!: true});
          }
        }
      }
    }
  }

  Future<void> buyProduct({required String productId}) async {
    emit(BuyProductLoading());
    try {
      await _apiServices.postData("purchase_table", {
        "for_user": userId,
        "is_bought": true,
        "for_product": productId,
      });
      emit(BuyProductDone());
    } catch (e) {
      log(e.toString());
      emit(BuyProductError());
    }
  }

  // get favorite products
  List<ProductModel> userOrders = [];
  void getUserOrdersProducts() {
    for (ProductModel product in products) {
      if (product.purchaseTable != null && product.purchaseTable!.isNotEmpty) {
        for (PurchaseTable userOrder in product.purchaseTable!) {
          if (userOrder.forUser == userId) {
            userOrders.add(product);
          }
        }
      }
    }
  }
}
