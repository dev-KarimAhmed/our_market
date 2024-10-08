import 'package:flutter/material.dart';
import 'package:our_market/core/components/cache_image.dart';
import 'package:our_market/core/functions/build_appbar.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, "Product Name"),
      body: ListView(
        children: const [
          CaheImage(
            url:
                "https://img.freepik.com/premium-psd/kitchen-product-podium-display-background_1101917-13418.jpg?w=900",
          ),
        ],
      ),
    );
  }
}
