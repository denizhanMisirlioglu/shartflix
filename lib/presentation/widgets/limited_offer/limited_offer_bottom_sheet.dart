import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../constants/colors.dart';
import '../../../constants/text_styles.dart';
import 'bonus_icon_item.dart';
import 'token_package_card.dart';

class LimitedOfferBottomSheet extends StatelessWidget {
  const LimitedOfferBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(
          top: -120,
          child: Container(
            width: 240,
            height: 240,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFE50914),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 180, sigmaY: 180),
              child: const SizedBox(),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                Text(AppLocalizations.of(context)!.limitedOfferTitle, style: AppTextStyles.heading),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context)!.limitedOfferDescription,
                  style: AppTextStyles.subtitle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.bonusCardBackground,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(AppLocalizations.of(context)!.bonusSectionTitle, style: AppTextStyles.sectionTitle),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          BonusIconItem(
                            iconPath: 'assets/icons/limited_offer/premium.png',
                            label: AppLocalizations.of(context)!.bonusPremiumAccount,
                            isLarge: true,
                          ),
                          BonusIconItem(
                            iconPath: 'assets/icons/limited_offer/match.png',
                            label: AppLocalizations.of(context)!.bonusMoreMatches,
                          ),
                          BonusIconItem(
                            iconPath: 'assets/icons/limited_offer/boost.png',
                            label: AppLocalizations.of(context)!.bonusBoost,
                          ),
                          BonusIconItem(
                            iconPath: 'assets/icons/limited_offer/like.png',
                            label: AppLocalizations.of(context)!.bonusMoreLikes,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(AppLocalizations.of(context)!.selectTokenPackageTitle, style: AppTextStyles.sectionTitle),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      TokenPackageCard(
                        discountText: '%10',
                        badgeColor: AppColors.redDiscount,
                        oldToken: '200',
                        newToken: '330',
                        price: '₺99,99',
                      ),
                      SizedBox(width: 12),
                      TokenPackageCard(
                        discountText: '%70',
                        badgeColor: AppColors.gradientStart,
                        oldToken: '2.000',
                        newToken: '3.375',
                        price: '₺799,99',
                      ),
                      SizedBox(width: 12),
                      TokenPackageCard(
                        discountText: '%35',
                        badgeColor: AppColors.redDiscount,
                        oldToken: '1.000',
                        newToken: '1.350',
                        price: '₺399,99',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.redDiscount,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      AppLocalizations.of(context)!.seeAllTokens,
                      style: AppTextStyles.buttonText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
