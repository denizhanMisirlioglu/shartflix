import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FavoriteMovieCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  const FavoriteMovieCard({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  String _generateAssetPathFromTitle(String title) {
    // Tüm harfleri küçült, boşlukları ve özel karakterleri alt çizgiyle değiştir
    return 'assets/backup_posters/${title.toLowerCase().replaceAll(RegExp(r"[^\w]+"), "_")}.webp';
  }

  @override
  Widget build(BuildContext context) {
    final backupImagePath = _generateAssetPathFromTitle(title);

    return SizedBox(
      width: 153.13,
      height: 213.82,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: 153.13,
              height: 153.13,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Image.asset(
                backupImagePath,
                width: 153.13,
                height: 153.13,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'EuclidCircularA',
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
