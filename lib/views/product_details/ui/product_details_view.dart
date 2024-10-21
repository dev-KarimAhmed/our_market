import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:our_market/core/components/cache_image.dart';
import 'package:our_market/core/functions/build_appbar.dart';
import 'package:our_market/core/models/product_model/product_model.dart';
import 'package:our_market/views/product_details/ui/widgets/comments_list.dart';

import '../../auth/ui/widgets/custom_text_field.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, product.productName ?? "Product Name"),
      body: ListView(
        children: [
          CaheImage(
            url: product.imageUrl ??
                "https://img.freepik.com/premium-psd/kitchen-product-podium-display-background_1101917-13418.jpg?w=900",
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(product.productName ?? "Product Name"),
                    Text(product.price != null
                        ? "${product.price} LE"
                        : "... LE"),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("3 "),
                        Icon(Icons.star, color: Colors.amber),
                      ],
                    ),
                    Icon(Icons.favorite, color: Colors.grey),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(product.description ?? "Product Description"),
                const SizedBox(
                  height: 20,
                ),
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomTextFormField(
                  labelText: "Type your feedback",
                  suffIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.send),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Row(
                  children: [
                    Text(
                      "Comments",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const CommentsList(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
