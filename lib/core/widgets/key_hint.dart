import 'package:flutter/material.dart';

import '../constants/app_spacing.dart';

/// Підказка клавіатурного скорочення: «⌘F».
class KeyHint extends StatelessWidget {
  const KeyHint({super.key, required this.keys});

  final String keys;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ExcludeSemantics(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.tiny + 2,
          vertical: 1,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: theme.colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(AppSpacing.tiny),
        ),
        child: Text(
          keys,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
