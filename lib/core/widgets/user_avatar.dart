import 'package:flutter/material.dart';

import '../constants/app_spacing.dart';

/// Аватар користувача з ініціалами (стандартний, коли фото не завантажене).
class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.initials,
    this.size = AppSizes.avatarSmall,
  });

  final String initials;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return CircleAvatar(
      radius: size / 2,
      backgroundColor: colors.primaryContainer,
      foregroundColor: colors.onPrimaryContainer,
      child: Text(
        initials,
        style: TextStyle(fontSize: size * 0.38, fontWeight: FontWeight.w600),
      ),
    );
  }
}
