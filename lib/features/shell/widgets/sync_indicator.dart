import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';

/// Індикатор стану синхронізації в бічній панелі (FR-23).
/// Поки що дані локальні, тому стан завжди «Синхронізовано».
class SyncIndicator extends StatelessWidget {
  const SyncIndicator({super.key, this.compact = false});

  /// У вузькій розкладці показується лише іконка з підказкою.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.onSurfaceVariant;
    final icon = Icon(Icons.cloud_done_outlined, size: 18, color: color);

    if (compact) {
      return Tooltip(message: AppStrings.synced, child: icon);
    }
    return Row(
      children: [
        icon,
        const SizedBox(width: AppSpacing.small),
        Text(
          AppStrings.synced,
          style: theme.textTheme.labelMedium?.copyWith(color: color),
        ),
      ],
    );
  }
}
