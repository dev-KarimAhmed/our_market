import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_market/core/components/custom_circle_pro_ind.dart';
import 'package:our_market/core/components/product_card.dart';
import 'package:our_market/core/cubit/home_cubit.dart';
import 'package:our_market/core/functions/navigate_to.dart';
import 'package:our_market/core/functions/show_msg.dart';
import 'package:our_market/core/models/product_model/product_model.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({
    super.key,
    this.shrinkWrap,
    this.physics,
    this.query,
    this.category,
    this.isFavoriteView = false,
    this.isUserOrderView = false,
  });

  final bool? shrinkWrap;
  final ScrollPhysics? physics;
  final String? query;
  final String? category;
  final bool isFavoriteView;
  final bool isUserOrderView;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeCubit()..getProducts(query: query, category: category),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is BuyProductSuccess) {
            showMsg(context, "Product Bought Successfully , check your orders");
          }
        },
        builder: (context, state) {
          HomeCubit homeCubit = context.read<HomeCubit>();

          List<ProductModel> products = query != null
              ? homeCubit.searchResults
              :
              // query == null
              category != null
                  ? homeCubit.categoryProducts
                  :
                  // query == null & category == null
                  isFavoriteView
                      ? homeCubit.favoriteProductsList
                      : isUserOrderView
                          ? homeCubit.userProducts
                          : homeCubit.products;
          return state is GetDataLoading ||
                  state is AddToFavoriteLoading ||
                  state is RemoveFromFavoriteLoading
              ? const CustomCircleProgIndicator()
              : ListView.builder(
                  shrinkWrap: shrinkWrap ?? true,
                  physics: physics ?? const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      isBught:
                          homeCubit.checkIsBought(products[index].productId!),
                      isFavorite:
                          homeCubit.checkIsFavorite(products[index].productId!),
                      product: products[index],
                      onTap: () {
                        bool isFavorite = homeCubit
                            .checkIsFavorite(products[index].productId!);

                        isFavorite
                            ? homeCubit
                                .removeFromFavorite(products[index].productId!)
                            : homeCubit
                                .addToFavorite(products[index].productId!);
                      },
                      buyProduct: () {
                        if (products[index].price != null) {
                          navigateTo(
                              context,
                              PaymentView(
                                onPaymentSuccess: () {
                                  homeCubit
                                      .buyProduct(products[index].productId!)
                                      .then((value) {});
                                },
                                onPaymentError: () {
                                  showMsg(context, "Payment Failed");
                                },
                                price: double.parse(products[index]
                                    .price!), // (Required) Total Price e.g. 100 => 100 LE
                              ));
                        }
                      },
                    );
                  });
        },
      ),
    );
  }
}
