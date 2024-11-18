import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_market/core/components/custom_circle_pro_ind.dart';
import 'package:our_market/core/components/product_card.dart';
import 'package:our_market/core/cubit/home_cubit.dart';
import 'package:our_market/core/models/product_model/product_model.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({
    super.key,
    this.shrinkWrap,
    this.physics,
    this.query,
    this.category,
    this.isFavoriteView = false,
  });

  final bool? shrinkWrap;
  final ScrollPhysics? physics;
  final String? query;
  final String? category;
  final bool isFavoriteView;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeCubit()..getProducts(query: query, category: category),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
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
                    );
                  });
        },
      ),
    );
  }
}
