import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:our_market/core/app_colors.dart';
import 'package:our_market/core/components/cache_image.dart';
import 'package:our_market/core/functions/navigate_to.dart';
import 'package:our_market/core/models/product_model/product_model.dart';
import 'package:our_market/views/product_details/ui/product_details_view.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';

import '../../views/auth/ui/widgets/custom_elevated_btn.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.product,
    super.key,
    this.onTap,
    required this.isFavorite,required this.onPaymentSuccess,
  });
  final ProductModel product;
  final Function()? onTap;
  final VoidCallback onPaymentSuccess;
  final bool isFavorite;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateTo(
          context,
          ProductDetailsView(
            product: product,
          )),
      child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                    child: CaheImage(
                      url: product.imageUrl ??
                          "https://img.freepik.com/premium-psd/kitchen-product-podium-display-background_1101917-13418.jpg?w=900",
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
                      child: Text(
                        "${product.sale}% OFF",
                        style: const TextStyle(
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
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                              onPressed: onTap,
                              icon: Icon(
                                Icons.favorite,
                                color: isFavorite
                                    ? AppColors.kPrimaryColor
                                    : AppColors.kGreyColor,
                              ))
                        ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "${product.price} LE",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${product.oldPrice} LE",
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontWeight: FontWeight.bold,
                                color: AppColors.kGreyColor,
                              ),
                            ),
                          ],
                        ),
                        CustomEBtn(
                          text: "Buy Now",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentView(
                                  onPaymentSuccess:onPaymentSuccess,
                                  onPaymentError: () {
                                     log("Payment Failure");

                                  },
                                  price:
                                      double.parse(product.price!), // Required: Total price (e.g., 100 for 100 EGP)
                                ),
                              ),
                            );
                          },
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
