import 'package:flutter/material.dart';
import '../../../constants/colors.dart';

class SocialIconGroup extends StatelessWidget {
  const SocialIconGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 16,
      runSpacing: 12,
      children: const [
        SocialIcon(assetPath: 'assets/icons/google_icon.png'),
        SocialIcon(assetPath: 'assets/icons/apple_icon.png'),
        SocialIcon(assetPath: 'assets/icons/facebook_icon.png'),
      ],
    );
  }
}

class SocialIcon extends StatelessWidget {
  final String assetPath;

  const SocialIcon({super.key, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        border: Border.all(color: AppColors.inputBorder),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Center(
        child: Image.asset(
          assetPath,
          width: 30,
          height: 30,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
