import 'package:flutter/material.dart';
import 'package:our_market/core/app_colors.dart';
import 'package:our_market/views/auth/ui/widgets/custom_elevated_btn.dart';
import 'package:our_market/views/auth/ui/widgets/custom_text_field.dart';

class ForgotView extends StatelessWidget {
  const ForgotView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Enter Your Email To Reset Password",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Card(
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
                  const CustomTextFormField(
                    labelText: "Email",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomEBtn(
                    text: "Sumbit",
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
