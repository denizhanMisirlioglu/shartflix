import 'dart:ui';
import 'package:flutter/material.dart';
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
        // 🔴 Dairesel Glow Efekti
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

        // 🧱 İçerik Kutusu
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

                // Başlık
                Text("Sınırlı Teklif", style: AppTextStyles.heading),
                const SizedBox(height: 8),
                Text(
                  "Jeton paketi’ni seçerek bonus kazanın ve yeni bölümlerin kilidini açın!",
                  style: AppTextStyles.subtitle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // 🎁 Bonuslar
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
                      Text("Alacağınız Bonuslar", style: AppTextStyles.sectionTitle),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          BonusIconItem(
                            iconPath: 'assets/icons/limited_offer/premium.png',
                            label: 'Premium\nHesap',
                            isLarge: true,
                          ),
                          BonusIconItem(
                            iconPath: 'assets/icons/limited_offer/match.png',
                            label: 'Daha\nFazla Eşleşme',
                          ),
                          BonusIconItem(
                            iconPath: 'assets/icons/limited_offer/boost.png',
                            label: 'Öne\nÇıkarma',
                          ),
                          BonusIconItem(
                            iconPath: 'assets/icons/limited_offer/like.png',
                            label: 'Daha\nFazla Beğeni',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Jeton Başlık
                Text("Kilidi açmak için bir jeton paketi seçin", style: AppTextStyles.sectionTitle),
                const SizedBox(height: 16),

                // Jeton Paketleri
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

                // Alt Buton
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
                    child: const Text(
                      "Tüm Jetonları Gör",
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
