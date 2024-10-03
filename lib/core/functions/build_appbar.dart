import 'package:flutter/material.dart';
import 'package:our_market/core/app_colors.dart';

AppBar buildCustomAppBar(BuildContext context, String title) {
  return AppBar(
    centerTitle: true,
    title: Text(
      title,
      style: const TextStyle(color: AppColors.kWhiteColor),
    ),
    backgroundColor: AppColors.kPrimaryColor,
    leading: IconButton(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(
        Icons.arrow_back_ios_new,
        color: AppColors.kWhiteColor,
      ),
    ),
  );
}
