import 'package:flutter/material.dart';
import 'package:our_market/core/components/custom_search_field.dart';
import 'package:our_market/core/components/products_list.dart';

class StoreView extends StatelessWidget {
  const StoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: const [
          Center(
            child: Text(
              "Welcome To Our Market",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          CustomSearchField(),
          SizedBox(
            height: 15,
          ),
          ProductsList()
        ],
      ),
    );
  }
}
