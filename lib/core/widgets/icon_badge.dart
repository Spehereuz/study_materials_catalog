import 'package:flutter/material.dart';

/// Іконка в колі кольору primaryContainer: заголовки діалогів,
/// екран відновлення пароля, порожні стани.
class IconBadge extends StatelessWidget {
  const IconBadge({super.key, required this.icon, this.size = 48});

  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: size / 2, color: colors.onPrimaryContainer),
    );
  }
}
