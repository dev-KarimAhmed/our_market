
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:our_market/core/app_colors.dart';
import 'package:our_market/views/favorite/ui/favorite_view.dart';
import 'package:our_market/views/home/ui/home_view.dart';
import 'package:our_market/views/nav_bar/logic/cubit/nav_bar_cubit.dart';
import 'package:our_market/views/profile/ui/profile_view.dart';
import 'package:our_market/views/store/ui/store_view.dart';

class MainHomeView extends StatelessWidget {
  MainHomeView({super.key});
  final List<Widget> views = [
    const HomeView(),
    const StoreView(),
    const FavoriteView(),
    const ProfileView(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavBarCubit(),
      child: BlocBuilder<NavBarCubit, NavBarState>(
        builder: (context, state) {
          NavBarCubit cubit = context.read<NavBarCubit>();
          return Scaffold(
            body: SafeArea(
              child: views[cubit.currentIndex],
            ),
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                color: AppColors.kWhiteColor,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 15,
                ),
                child: GNav(
                    onTabChange: (index) {
                      cubit.changeCurrentIndex(index);
                    },
                    rippleColor: AppColors
                        .kPrimaryColor, // tab button ripple color when pressed
                    hoverColor:
                        AppColors.kPrimaryColor, // tab button hover color
                    duration: const Duration(
                        milliseconds: 400), // tab animation duration
                    gap: 8, // the tab button gap between icon and text
                    color: AppColors.kGreyColor, // unselected icon color
                    activeColor:
                        AppColors.kWhiteColor, // selected icon and text color
                    iconSize: 24, // tab button icon size
                    tabBackgroundColor: AppColors
                        .kPrimaryColor, // selected tab background color
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ), // navigation bar padding
                    tabs: const [
                      GButton(
                        icon: Icons.home,
                        text: 'Home',
                      ),
                      GButton(
                        icon: Icons.store,
                        text: 'Store',
                      ),
                      GButton(
                        icon: Icons.favorite,
                        text: 'Favorite',
                      ),
                      GButton(
                        icon: Icons.person,
                        text: 'Profile',
                      )
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
