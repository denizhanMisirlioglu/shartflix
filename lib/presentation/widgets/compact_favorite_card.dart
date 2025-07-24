import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CompactFavoriteCard extends StatelessWidget {
  final String title;
  final String posterUrl;
  final VoidCallback onFavoriteToggle;

  const CompactFavoriteCard({
    super.key,
    required this.title,
    required this.posterUrl,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isValidPoster = posterUrl.trim().isNotEmpty &&
        Uri.tryParse(posterUrl)?.hasAbsolutePath == true;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AspectRatio(
          aspectRatio: 2 / 3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: isValidPoster
                ? Image.network(
              posterUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              errorBuilder: (_, __, ___) => _fallbackPoster(),
            )
                : _fallbackPoster(),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title.isNotEmpty
                      ? title
                      : AppLocalizations.of(context)!.titleNotFound,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.favorite, color: Colors.red, size: 20),
                onPressed: onFavoriteToggle,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _fallbackPoster() {
    return Container(
      color: Colors.grey[300],
      alignment: Alignment.center,
      child: const Icon(Icons.broken_image, size: 48, color: Colors.grey),
    );
  }
}
