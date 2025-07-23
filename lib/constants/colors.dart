import 'package:flutter/material.dart';

class AppColors {
  // Genel Arka Plan ve Temel Renkler
  static const Color background = Colors.black;
  static const Color white = Color(0xFFFFFFFF);
  static const Color white50 = Color.fromRGBO(255, 255, 255, 0.5); // %50 opak beyaz
  static const Color white75 = Color.fromRGBO(255, 255, 255, 0.75); // %75 beyaz
  static const Color white20 = Color.fromRGBO(255, 255, 255, 0.20); // %20 beyaz

  // Temel Buton ve Aksiyon Renkleri
  static const Color brandRed = Color(0xFFE50914); // Giriş Yap butonu

  // Input Alanları
  static const Color inputFill = Color.fromRGBO(255, 255, 255, 0.1); // İç dolgu (%10 beyaz)
  static const Color inputIcon = white50; // İkonlar için (email, şifre)
  static const Color inputBackground = Color(0x1AFFFFFF); // %10 beyaz
  static const Color inputBorder = Color(0x33FFFFFF);     // %20 beyaz
  static const Color hintText = Color(0x80FFFFFF); // %50 beyaz

  // Sosyal İkonlar
  static const Color socialIconBorder = inputBorder; // Aynı input border

  // Keşfet Sayfası (Discover)
  static const Color overlayBlackStart = Color(0xFF000000); // Gradient %100 siyah
  static const Color overlayBlackEnd = Color.fromRGBO(0, 0, 0, 0); // Gradient %0 siyah
  static const Color favoriteButtonBackground = Color.fromRGBO(0, 0, 0, 0.20); // %20 siyah


  static const Color backgroundDark = Color(0xFF090909); // bottom nav bar zemini
  static const Color favoriteButtonBorder = Color(0x33FFFFFF); // %20 beyaz (0x33 = 20% alpha)
  static const Color bottomNavSelected = Colors.white; // aktif
  static const Color bottomNavUnselected = Colors.white60; // pasif
  static const Color navBarBackground = Color(0xFF090909);


  static const Color bonusCardBackground = Color.fromRGBO(0, 0, 0, 0.2);
  static const Color bonusCardBorder = Color.fromRGBO(255, 255, 255, 0.1);
  static const Color gradientStart = Color(0xFF5949E6); // mor
  static const Color gradientEnd = Color(0xFFE50914);   // kırmızı
  static const Color redDiscount = Color(0xFFE50914);


}
