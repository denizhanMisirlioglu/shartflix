import 'package:flutter/material.dart';
import '../../../constants/app_padding.dart';
import '../../constants/colors.dart';
import '../../constants/text_styles.dart';

class MovieCard extends StatelessWidget {
  final String title;
  final String description;
  final String posterUrl;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const MovieCard({
    super.key,
    required this.title,
    required this.description,
    required this.posterUrl,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SizedBox(
      height: screenSize.height,
      width: screenSize.width,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 🎞 Arka Plan Posteri
          Image.network(
            posterUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.broken_image, color: Colors.white)),
          ),

          // 🌫️ Gradient Overlay
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  AppColors.overlayBlackStart,
                  AppColors.overlayBlackEnd,
                ],
              ),
            ),
          ),

          // 📄 İçerik (Başlık, Açıklama, Daha Fazlası)
          Padding(
            padding: AppPadding.movieCardContent,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🧠 Başlık
                  Text(
                    title,
                    style: AppTextStyles.movieTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppPadding.titleToDescriptionSpacing),

                  // 📖 Açıklama
                  Text(
                    description,
                    style: AppTextStyles.movieDescription,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppPadding.descriptionToMoreSpacing),

                  // 🔗 Daha Fazlası
                  Text(
                    "Daha Fazlası",
                    style: AppTextStyles.moreLink,
                  ),
                ],
              ),
            ),
          ),

          // ❤️ Favori Butonu
          Positioned(
            bottom: AppPadding.favoriteButton.bottom,
            right: AppPadding.favoriteButton.right,
            child: Container(
              width: 49,
              height: 71.7,
              decoration: BoxDecoration(
                color: AppColors.favoriteButtonBackground,
                border: Border.all(color: AppColors.white20),
                borderRadius: BorderRadius.circular(16),
              ),
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.white,
                  size: 24,
                ),
                onPressed: onFavoriteToggle,
              ),
            ),
          ),

          // 🟣 Logo (sol üstte, opsiyonel)
          Positioned(
            top: 40,
            left: 20,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1.5),
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: const Center(
                child: FlutterLogo(size: 24), // logo yerine kendi assetini koyabilirsin
              ),
            ),
          ),
        ],
      ),
    );
  }
}
