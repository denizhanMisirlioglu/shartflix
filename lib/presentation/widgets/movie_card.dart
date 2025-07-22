import 'package:flutter/material.dart';

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
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            // 🎬 Poster
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                posterUrl,
                height: 100,
                width: 70,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.image),
              ),
            ),
            const SizedBox(width: 12),

            // 📄 Başlık + Açıklama
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // ❤️ Kalp ikonu
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                print("🟢 UI: Kalp ikonuna tıklandı → isFavorite: $isFavorite");
                onFavoriteToggle();
              },
            ),
          ],
        ),
      ),
    );
  }
}
