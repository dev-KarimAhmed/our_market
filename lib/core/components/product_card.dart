import 'package:flutter/material.dart';
import 'package:our_market/core/app_colors.dart';
import 'package:our_market/core/components/cache_image.dart';
import 'package:our_market/core/functions/navigate_to.dart';
import 'package:our_market/core/models/product_model/product_model.dart';
import 'package:our_market/views/product_details/ui/product_details_view.dart';

import '../../views/auth/ui/widgets/custom_elevated_btn.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
  required this.product,
    super.key,
  });
 final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateTo(context, const ProductDetailsView()),
      child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                   ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                    child: CaheImage(
                      url:
                          product.imageUrl ?? "https://img.freepik.com/premium-psd/kitchen-product-podium-display-background_1101917-13418.jpg?w=900",
                    ),
                  ),
                  Positioned(
                    child: Container(
                      alignment: Alignment.center,
                      width: 65,
                      height: 35,
                      decoration: const BoxDecoration(
                          color: AppColors.kPrimaryColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          )),
                      child:  Text(
                        "${product.sale}% OFF",
                        style: TextStyle(
                          color: AppColors.kWhiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Text(
                            product.productName ?? "Product Name",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.favorite,
                                color: AppColors.kGreyColor,
                              ))
                        ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Column(
                          children: [
                            Text(
                              "${product.price} LE",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${product.oldPrice} LE",
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontWeight: FontWeight.bold,
                                color: AppColors.kGreyColor,
                              ),
                            ),
                          ],
                        ),
                        CustomEBtn(
                          text: "Buy Now",
                          onTap: () {},
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
