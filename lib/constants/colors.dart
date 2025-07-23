import 'package:flutter/material.dart';

class AppColors {
  // Genel Arka Plan ve Temel Renkler
  static const Color background = Colors.black;
  static const Color white = Color(0xFFFFFFFF);
  static const Color white50 = Color.fromRGBO(255, 255, 255, 0.5); // %50 opak beyaz

  // Temel Buton ve Aksiyon Renkleri
  static const Color brandRed = Color(0xFFE50914); // Giriş Yap butonu

  // Input Alanları
  static const Color inputFill = Color.fromRGBO(255, 255, 255, 0.1); // İç dolgu (%10 beyaz)
  //static const Color inputBorder = Color.fromRGBO(255, 255, 255, 0.2); // Kenarlık (%20 beyaz)
  static const Color inputIcon = white50; // İkonlar için (email, şifre)
  static const Color inputBackground = Color(0x1AFFFFFF); // %10 beyaz
  static const Color inputBorder = Color(0x33FFFFFF);     // %20 beyaz
  static const Color hintText = Color(0x80FFFFFF); // %50 beyaz


  // Sosyal İkonlar
  static const Color socialIconBorder = inputBorder; // Aynı input border
}
