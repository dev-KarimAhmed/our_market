import 'package:flutter/material.dart';
import 'package:our_market/core/components/product_card.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({
    super.key, this.shrinkWrap, this.physics,
  });

  final bool? shrinkWrap;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: shrinkWrap ?? true,
        physics: physics ?? const NeverScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return const ProductCard();
        });
  }
}
