import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../constants/colors.dart';
import '../../../constants/text_styles.dart';

class TokenPackageCard extends StatelessWidget {
  final String discountText;
  final Color badgeColor;
  final String oldToken;
  final String newToken;
  final String price;
  final VoidCallback? onTap;

  const TokenPackageCard({
    Key? key,
    required this.discountText,
    required this.badgeColor,
    required this.oldToken,
    required this.newToken,
    required this.price,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 115,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppColors.gradientStart,
                  AppColors.gradientEnd,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                Text(
                  oldToken,
                  style: AppTextStyles.tokenOld,
                ),
                const SizedBox(height: 4),
                Text(
                  newToken,
                  style: AppTextStyles.tokenBig,
                ),
                const SizedBox(height: 4),
                Text(
                  AppLocalizations.of(context)!.tokenLabel,
                  style: AppTextStyles.sectionTitle,
                ),
                const SizedBox(height: 16),
                Text(
                  price,
                  style: AppTextStyles.price,
                ),
                const SizedBox(height: 2),
                Text(
                  AppLocalizations.of(context)!.perWeekLabel,
                  style: AppTextStyles.perWeek,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Positioned(
            top: -14,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: badgeColor.withOpacity(0.5),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  discountText,
                  style: AppTextStyles.discountBadge,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
