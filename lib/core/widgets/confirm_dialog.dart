import 'package:flutter/material.dart';

import '../constants/app_strings.dart';
import 'icon_badge.dart';

/// Показує діалог підтвердження незворотної дії (NFR-15).
/// Повертає `true`, якщо користувач підтвердив дію.
Future<bool> showConfirmDialog(
  BuildContext context, {
  required IconData icon,
  required String title,
  required String message,
  required String confirmLabel,
  String cancelLabel = AppStrings.cancel,
}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => ConfirmDialog(
      icon: icon,
      title: title,
      message: message,
      confirmLabel: confirmLabel,
      cancelLabel: cancelLabel,
    ),
  );
  return confirmed ?? false;
}

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    required this.confirmLabel,
    this.cancelLabel = AppStrings.cancel,
  });

  final IconData icon;
  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      icon: IconBadge(icon: icon),
      title: Text(title, textAlign: TextAlign.center),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(cancelLabel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(confirmLabel),
        ),
      ],
    );
  }
}
