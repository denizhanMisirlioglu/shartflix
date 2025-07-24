import 'package:flutter/material.dart';
import '../../../constants/text_styles.dart';

class BonusIconItem extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool isLarge;

  const BonusIconItem({
    Key? key,
    required this.iconPath,
    required this.label,
    this.isLarge = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double iconSize = isLarge ? 36 : 28; // 🔹 Sadece ikon büyür

    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color.fromRGBO(255, 255, 255, 0.1),
            boxShadow: [
              BoxShadow(
                color: Colors.pinkAccent.withOpacity(0.4),
                blurRadius: 12,
                spreadRadius: 1,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Image.asset(
              iconPath,
              width: iconSize,
              height: iconSize,
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: AppTextStyles.bonusLabel,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

