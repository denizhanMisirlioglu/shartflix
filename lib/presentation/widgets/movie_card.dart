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
            errorBuilder: (_, __, ___) {
              final backupFileName = title
                  .toLowerCase()
                  .replaceAll(" ", "_")
                  .replaceAll(RegExp(r'[^\w_]'), '');
              return Image.asset(
                'assets/backup_posters/$backupFileName.webp',
                fit: BoxFit.cover,
              );
            },
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

          // 📄 Ortalanmış İçerik
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              bottom: AppPadding.movieCardBottom,
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.movieTitle,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppPadding.titleToDescriptionSpacing),
                  Text(
                    description,
                    style: AppTextStyles.movieDescription,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppPadding.descriptionToMoreSpacing),
                  Text(
                    "Daha Fazlası",
                    style: AppTextStyles.moreLink,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          // ❤️ Favori Butonu
          Positioned(
            bottom: 100,
            right: 18,
            child: GestureDetector(
              onTap: onFavoriteToggle,
              child: Container(
                width: 49,
                height: 71.7,
                decoration: BoxDecoration(
                  color: AppColors.favoriteButtonBackground,
                  border: Border.all(color: AppColors.white20),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.white, // 💡 Artık içi dolu olan da beyaz!
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
