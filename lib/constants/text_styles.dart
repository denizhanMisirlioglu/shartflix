import 'package:flutter/material.dart';
import 'colors.dart';

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
    height: 1.2,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    height: 1.4,
  );

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

  static const TextStyle buttonText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
    letterSpacing: 0.3,
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

  // 🎬 Discover (Movie Card) İçin
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
