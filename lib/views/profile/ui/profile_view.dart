import 'package:flutter/material.dart';
import 'package:our_market/core/app_colors.dart';
import 'package:our_market/core/functions/navigate_to.dart';
import 'package:our_market/views/profile/ui/edit_name_view.dart';
import 'package:our_market/views/profile/ui/my_orders.dart';
import 'package:our_market/views/profile/ui/widgets/custom_row_btn.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * .65,
        child: Card(
          color: AppColors.kWhiteColor,
          margin: const EdgeInsets.all(24),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 55,
                  backgroundColor: AppColors.kPrimaryColor,
                  foregroundColor: AppColors.kWhiteColor,
                  child: Icon(
                    Icons.person,
                    size: 45,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "User Name",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("User Email"),
                const SizedBox(
                  height: 10,
                ),
                CustomRowBtn(
                  onTap: () => navigateTo(context, const EditNameView()),
                  icon: Icons.person,
                  text: "Edit Name",
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomRowBtn(
                  onTap: () => navigateTo(context, const MyOrdersViwe()),
                  icon: Icons.shopping_basket,
                  text: "My Orders",
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomRowBtn(
                  onTap: () {},
                  icon: Icons.logout,
                  text: "Logout",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
