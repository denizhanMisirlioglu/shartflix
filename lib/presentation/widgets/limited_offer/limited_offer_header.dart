import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LimitedOfferHeader extends StatelessWidget {
  const LimitedOfferHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -110,
          child: Image.asset(
            'assets/images/glow_effect_circle.png',
            width: 230,
            height: 230,
            fit: BoxFit.cover,
          ),
        ),
        Column(
          children: [
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.limitedOfferTitle,
              style: const TextStyle(
                fontSize: 20,
                fontFamily: 'Euclid Circular A',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              AppLocalizations.of(context)!.limitedOfferDescription,
              textAlign: TextAlign.center,
              style: const TextStyle(
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
