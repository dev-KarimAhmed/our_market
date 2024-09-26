import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:our_market/core/app_colors.dart';

class MainHomeView extends StatelessWidget {
  const MainHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            child: const Text("Test View"),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.kWhiteColor,
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 15,
          ),
          child: GNav(
            
              rippleColor: AppColors
                  .kPrimaryColor, // tab button ripple color when pressed
              hoverColor: AppColors.kPrimaryColor, // tab button hover color
              duration: Duration(milliseconds: 400), // tab animation duration
              gap: 8, // the tab button gap between icon and text
              color: AppColors.kGreyColor, // unselected icon color
              activeColor:
                  AppColors.kWhiteColor, // selected icon and text color
              iconSize: 24, // tab button icon size
              tabBackgroundColor:
                  AppColors.kPrimaryColor, // selected tab background color
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ), // navigation bar padding
              tabs: [
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
  }
}
