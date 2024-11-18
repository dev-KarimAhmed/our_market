import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:our_market/core/components/custom_search_field.dart';
import 'package:our_market/core/components/products_list.dart';

import '../../../core/functions/navigate_to.dart';
import '../../home/ui/search_view.dart';

class StoreView extends StatefulWidget {
  const StoreView({super.key});

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          const Center(
            child: Text(
              "Welcome To Our Market",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomSearchField(
            controller: _searchController,
            onPressed: () {
              if (_searchController.text.isNotEmpty) {
                navigateTo(
                  context,
                  SearchView(
                    query: _searchController.text,
                  ),
                );
                _searchController.clear();
              }
            },
          ),
          const SizedBox(
            height: 15,
          ),
          const ProductsList()
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
