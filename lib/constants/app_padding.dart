import 'package:flutter/material.dart';

class AppPadding {
  // 📱 Giriş/Kayıt Sayfaları için

  // Genel yatay boşluk (E-Posta bileşeni soldan-sağdan 44, Giriş Butonu 116.5 — en yaygın olan 39 seçilmişti)
  static const double horizontal = 39;

  // E-Posta ve Şifre bileşenleri arası: 13.63 ≈ 14, Giriş Yap ile ikonlar arası: 36.92 ≈ 37
  static const double verticalSpacing = 16;

  // Input (E-Posta, Şifre) yüksekliği: 54.37
  static const double inputHeight = 54.37;

  // Giriş Yap butonu yüksekliği: 53.31
  static const double buttonHeight = 53.31;

  // E-Posta, Şifre kutularının radius'u (yuvarlaklığı): 18
  static const double inputRadius = 18;

  // Sosyal ikonlar arası spacing (Figma’ya göre orijinalden daha yakın)
  static const double socialIconSpacing = 8;

  // Sosyal ikon container boyutu
  static const double socialIconSize = 60;

  // Başlık üst boşluğu (Merhabalar → yukarıdan): 300.5
  static const double topGreetingPadding = 300.5;

  // Giriş yap butonunun alt boşluğu (→ sosyal ikonlar): 36.92
  static const double buttonToIcons = 36.92;

  // Şifre kutusu ile “Şifremi unuttum” yazısı arası: 29.63
  static const double passwordToForgot = 29.63;

  // 🎬 Keşfet (Discover) Sayfası için

  /// MovieCard içeriği için genel yatay padding
  static const EdgeInsets movieCardContent = EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0);

  /// Favori butonunun bulunduğu container'ın içten sağ ve alt boşluğu
  static const EdgeInsets favoriteButton = EdgeInsets.only(right: 16.0, bottom: 24.0);

  /// Uygulama logosu ile içerik arası boşluk
  static const double logoToTextSpacing = 10.0;

  /// Başlık ile açıklama metni arası boşluk
  static const double titleToDescriptionSpacing = 4.0;

  /// Açıklama ile “Daha Fazlası” bağlantısı arası boşluk
  static const double descriptionToMoreSpacing = 2.0;
}
