import 'package:flutter/material.dart';

class AppPadding {
  // 📱 Giriş/Kayıt Sayfaları için

  static const double horizontal = 39;
  static const double verticalSpacing = 16;
  static const double inputHeight = 54.37;
  static const double buttonHeight = 53.31;
  static const double inputRadius = 18;
  static const double socialIconSpacing = 8;
  static const double socialIconSize = 60;
  static const double topGreetingPadding = 300.5;
  static const double buttonToIcons = 36.92;
  static const double passwordToForgot = 29.63;

  // 🎬 Keşfet (HomePage) / MovieCard için

  /// İçerik (başlık + açıklama + daha fazlası) alanının sol, sağ ve alt boşlukları
  static const double movieCardLeft = 90.0;
  static const double movieCardRight = 33.0;
  static const double movieCardBottom = 26.0;

  static const EdgeInsets movieCardContent = EdgeInsets.only(
    left: movieCardLeft,
    right: movieCardRight,
    bottom: movieCardBottom,
  );

  /// Başlık ile açıklama metni arası (Figma'da 0.79, minimum 2.0 kullanılabilir)
  static const double titleToDescriptionSpacing = 2.0;

  /// Açıklama ile favori butonu arası (Figma: 30.29)
  static const double descriptionToFavoriteSpacing = 30.0;

  /// Favori butonun ekranın sağ alt köşesinden uzaklığı (buton yerleşimi için)
  static const EdgeInsets favoriteButton = EdgeInsets.only(
    right: 20.0,
    bottom: movieCardBottom + descriptionToFavoriteSpacing, // 26 + 30
  );

  /// Logo ile içerik arası boşluk (description ile logo arası: 16px)
  static const double logoToDescriptionSpacing = 16.0;

  // Açıklama ile “Daha Fazlası” bağlantısı arası boşluk
  static const double descriptionToMoreSpacing = 2.0;

  static const double favoriteCardHorizontalSpacing = 15.66;
  static const double favoriteCardTitleSpacing = 16.0;
  static const double favoriteCardVerticalSpacing = 65.21;
  static const double profileImageNameSpacing = 9.56;
  static const double offerPhotoButtonSpacing = 55.34;
  static const double backButtonTitleSpacing = 87.71;
}
