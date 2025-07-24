import 'package:flutter/material.dart';
import 'colors.dart';

class AppTextStyles {
  // 🎯 Genel Başlıklar
  static const TextStyle heading = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600, // SemiBold
    color: AppColors.white,
    height: 1.0,
    fontFamily: 'Euclid Circular A',
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    height: 1.5,
    fontFamily: 'Euclid Circular A',
  );

  //  Bonus başlığı (Alacağınız Bonuslar / Jeton Seçimi)
  static const TextStyle sectionTitle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
    fontFamily: 'Euclid Circular A',
  );

  static const TextStyle bonusLabel = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: Colors.white,
    height: 1.3,
  );

  //  Kart Üzeri Büyük Jeton Sayısı
  static const TextStyle tokenBig = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
    fontFamily: 'Euclid Circular A',
  );

  //  Üstü çizili eski jeton sayısı
  static const TextStyle tokenOld = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.lineThrough,
    color: AppColors.white,
    fontFamily: 'Euclid Circular A',
  );

  //  Fiyat
  static const TextStyle price = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w900,
    color: AppColors.white,
    fontFamily: 'Montserrat',
  );

  //  "Başına haftalık"
  static const TextStyle perWeek = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    height: 1.5,
    fontFamily: 'Euclid Circular A',
  );

  //  % indirim rozeti içi
  static const TextStyle discountBadge = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
    fontFamily: 'Euclid Circular A',
  );

  //  Buton
  static const TextStyle buttonText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
    letterSpacing: 0.3,
    fontFamily: 'Euclid Circular A',
  );

  // 🧾 Kayıt & Form Metinleri
  static const TextStyle inputText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );

  static const TextStyle forgotPassword = TextStyle(
    color: Colors.white,
    fontSize: 12,
    decoration: TextDecoration.underline,
    decorationColor: Colors.white,
    decorationThickness: 0.8,
    decorationStyle: TextDecorationStyle.solid,
  );

  static const TextStyle registerText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.white50,
  );

  static const TextStyle registerBold = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  //  Discover Movie Card
  static const TextStyle movieTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    height: 1.0,
  );

  static const TextStyle movieDescription = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.white75,
    height: 1.4,
  );

  static const TextStyle moreLink = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    height: 1.4,
  );



}
