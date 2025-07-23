import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import '../../../constants/text_styles.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  const AuthButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 53.31, // AppPadding.buttonHeight
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.brandRed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18), // AppPadding.inputRadius
          ),
        ),
        child: isLoading
            ? const CircularProgressIndicator(color: AppColors.white)
            : Text(text, style: AppTextStyles.buttonText),
      ),
    );
  }
}
