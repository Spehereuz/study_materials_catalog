import 'package:flutter/material.dart';

import '../constants/app_spacing.dart';
import '../theme/app_colors.dart';

/// Іконка на тонованому квадраті: тип матеріалу, іконка дисципліни.
class TintedIcon extends StatelessWidget {
  const TintedIcon({
    super.key,
    required this.icon,
    required this.accent,
    this.size = AppSizes.iconBox,
  });

  final IconData icon;
  final AccentColor accent;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = accent.resolve(Theme.of(context).colorScheme);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: colors.container,
        borderRadius: BorderRadius.circular(AppRadius.small),
      ),
      child: Icon(icon, size: size / 2, color: colors.foreground),
    );
  }
}
