import 'package:flutter/material.dart';
import '../../../constants/colors.dart';

class SocialIconGroup extends StatelessWidget {
  const SocialIconGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 16, // ikonlar arası yatay boşluk
      runSpacing: 12, // dar ekranlarda alt alta geçerse dikey boşluk
      children: const [
        SocialIcon(icon: Icons.g_mobiledata),
        SocialIcon(icon: Icons.apple),
        SocialIcon(icon: Icons.facebook),
      ],
    );
  }
}

class SocialIcon extends StatelessWidget {
  final IconData icon;

  const SocialIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.socialIconBorder),
      ),
      child: Icon(icon, color: AppColors.white, size: 32),
    );
  }
}
