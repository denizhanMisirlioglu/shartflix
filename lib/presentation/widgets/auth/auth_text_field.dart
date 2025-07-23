import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import '../../../constants/text_styles.dart';

class AuthTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffixIcon;

  const AuthTextField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54.37, // veya AppPadding.inputHeight
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(18), // AppPadding.inputRadius
        border: Border.all(color: AppColors.inputBorder),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Center(
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          style: AppTextStyles.subtitle,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyles.subtitle.copyWith(color: AppColors.hintText),
            border: InputBorder.none,
            prefixIcon: Icon(icon, color: AppColors.white),
            suffixIcon: suffixIcon,
          ),
        ),
      ),
    );
  }
}
