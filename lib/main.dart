import 'package:flutter/material.dart';
import 'package:our_market/core/app_colors.dart';
import 'package:our_market/views/auth/ui/login_view.dart';
import 'package:our_market/views/nav_bar/ui/main_home_view.dart';

void main() {
  runApp(const OurMarket());
}

class OurMarket extends StatelessWidget {
  const OurMarket({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Our Market',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.kScaffoldColor,
        useMaterial3: true,
      ),
      home:  MainHomeView(),
    );
  }
}
