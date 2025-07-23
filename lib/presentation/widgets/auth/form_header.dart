import 'package:flutter/material.dart';
import '../../../constants/text_styles.dart';

class FormHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const FormHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: AppTextStyles.heading, textAlign: TextAlign.center),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: AppTextStyles.subtitle.copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
