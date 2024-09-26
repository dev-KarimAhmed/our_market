import 'package:flutter/material.dart';
import 'package:our_market/views/auth/ui/widgets/custom_arrow_btn.dart';

class CustomRowWithArrowBtn extends StatelessWidget {
  const CustomRowWithArrowBtn({
    super.key,
    required this.text,
    this.onTap,
  });
  final String text;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        CustomArrowBtn(
          onTap: onTap,
        ),
      ],
    );
  }
}
