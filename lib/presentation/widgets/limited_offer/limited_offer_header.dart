import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LimitedOfferHeader extends StatelessWidget {
  const LimitedOfferHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        // Glow efekt (arkadaki blur)
        Positioned(
          top: -110,
          child: Image.asset(
            'assets/images/glow_effect_circle.png',
            width: 230,
            height: 230,
            fit: BoxFit.cover,
          ),
        ),
        // Başlık ve açıklama yazısı
        Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'Sınırlı Teklif',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Euclid Circular A',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Jeton paketini seçerek bonus kazan\nve yeni bölümlerin kilidini açın!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Euclid Circular A',
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ],
    );
  }
}
