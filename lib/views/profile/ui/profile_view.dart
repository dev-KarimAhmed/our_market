import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_market/core/app_colors.dart';
import 'package:our_market/core/components/custom_circle_pro_ind.dart';
import 'package:our_market/core/functions/navigate_to.dart';
import 'package:our_market/core/functions/navigate_without_back.dart';
import 'package:our_market/views/auth/ui/login_view.dart';
import 'package:our_market/views/auth/logic/cubit/authentication_cubit.dart';
import 'package:our_market/views/auth/logic/models/user_model.dart';
import 'package:our_market/views/profile/ui/edit_name_view.dart';
import 'package:our_market/views/profile/ui/my_orders.dart';
import 'package:our_market/views/profile/ui/widgets/custom_row_btn.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationCubit()..getUserData(),
      child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            navigateWithoutBack(context, const LoginView());
          }
        },
        builder: (context, state) {
          UserDataModel? user =
              context.read<AuthenticationCubit>().userDataModel;
          return state is LogoutLoading || state is GetUserDataLoading
              ? const CustomCircleProgIndicator()
              : Center(
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
                            Text(
                              user?.name ?? "User Name",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(user?.email ?? "User Email"),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomRowBtn(
                              onTap: () =>
                                  navigateTo(context, const EditNameView()),
                              icon: Icons.person,
                              text: "Edit Name",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomRowBtn(
                              onTap: () =>
                                  navigateTo(context, const MyOrdersViwe()),
                              icon: Icons.shopping_basket,
                              text: "My Orders",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomRowBtn(
                              onTap: () async {
                                await context
                                    .read<AuthenticationCubit>()
                                    .signOut();
                              },
                              icon: Icons.logout,
                              text: "Logout",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
