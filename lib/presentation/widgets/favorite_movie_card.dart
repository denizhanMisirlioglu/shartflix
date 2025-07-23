import 'package:flutter/material.dart';

class FavoriteMovieCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  const FavoriteMovieCard({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  String _generateAssetPathFromTitle(String title) {
    return 'assets/backup_posters/${title.toLowerCase().replaceAll(RegExp(r"[^\w]+"), "_")}.webp';
  }

  @override
  Widget build(BuildContext context) {
    final backupImagePath = _generateAssetPathFromTitle(title);

    return SizedBox(
      width: 153.13,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: 153.13,
              height: 213.82,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Image.asset(
                backupImagePath,
                width: 153.13,
                height: 213.82,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 153.13,
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'EuclidCircularA',
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
