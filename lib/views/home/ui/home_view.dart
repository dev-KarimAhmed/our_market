import 'package:flutter/material.dart';
import 'package:our_market/core/app_colors.dart';
import 'package:our_market/core/components/custom_search_field.dart';
import 'package:our_market/core/components/products_list.dart';
import 'package:our_market/core/functions/navigate_to.dart';
import 'package:our_market/core/sensitive_data.dart';
import 'package:our_market/views/home/ui/search_view.dart';
import 'package:our_market/views/home/ui/widgets/categories_list.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    PaymentData.initialize(
      apiKey:
          paymobApiKey, // Required: Found under Dashboard -> Settings -> Account Info -> API Key
      iframeId: iframeId, // Required: Found under Developers -> iframes
      integrationCardId:
          integrationCardId, // Required: Found under Developers -> Payment Integrations -> Online Card ID
      integrationMobileWalletId:
          integrationMobileWalletId, // Required: Found under Developers -> Payment Integrations -> Mobile Wallet ID

      // // Optional User Data
      // userData: UserData(
      //   email: "User Email", // Optional: Defaults to 'NA'
      //   phone: "User Phone", // Optional: Defaults to 'NA'
      //   name: "User First Name", // Optional: Defaults to 'NA'
      //   lastName: "User Last Name", // Optional: Defaults to 'NA'
      // ),

      // // Optional Style Customizations
      style: Style(
        primaryColor: AppColors.kPrimaryColor, // Default: Colors.blue
        appBarBackgroundColor: AppColors.kPrimaryColor, // Default: Colors.blue
        buttonStyle:
            ElevatedButton.styleFrom(
              backgroundColor: AppColors.kPrimaryColor,
              foregroundColor: Colors.white,
            ), // Default: ElevatedButton.styleFrom()
        circleProgressColor: AppColors.kPrimaryColor, // Default: Colors.blue
        unselectedColor: Colors.grey, // Default: Colors.grey
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          const SizedBox(
            height: 15,
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
            height: 20,
          ),
          Image.asset("assets/images/buy.jpg"),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Popular Categories",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const CategoriesList(),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Recently Products",
            style: TextStyle(
              fontSize: 20,
            ),
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
