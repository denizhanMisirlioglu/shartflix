import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import '../../../constants/text_styles.dart';
import '../../../constants/app_padding.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  final bool obscureText;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;

  const CustomInputField({
    super.key,
    required this.controller,
    required this.icon,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.onSuffixTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppPadding.inputHeight,
      decoration: BoxDecoration(
        color: AppColors.inputBackground, // %10 beyaz
        borderRadius: BorderRadius.circular(AppPadding.inputRadius), // Figma: 18px
        border: Border.all(color: AppColors.inputBorder), // %20 beyaz
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Icon(icon, color: AppColors.hintText), // %50 beyaz
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              style: AppTextStyles.subtitle,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: AppColors.hintText, // %50 beyaz
                  fontSize: 14, // Figma ölçülerine göre uyarlanabilir
                ),
                border: InputBorder.none,
                isCollapsed: true,
              ),
            ),
          ),
          if (suffixIcon != null)
            GestureDetector(
              onTap: onSuffixTap,
              child: Icon(suffixIcon, color: AppColors.hintText),
            ),
        ],
      ),
    );
  }
}
