import 'package:flutter/material.dart';

import '../constants/app_spacing.dart';

enum StatusBannerType { error, success }

/// Повідомлення про результат дії: помилка входу, лист надіслано,
/// непідтримуваний формат фото тощо (NFR-15).
class StatusBanner extends StatelessWidget {
  const StatusBanner({
    super.key,
    required this.message,
    this.details,
    this.type = StatusBannerType.error,
  });

  final String message;
  final String? details;
  final StatusBannerType type;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final (background, foreground, iconColor, icon) = switch (type) {
      StatusBannerType.error => (
        colors.errorContainer,
        colors.onErrorContainer,
        colors.error,
        Icons.error_outline,
      ),
      StatusBannerType.success => (
        colors.primaryContainer,
        colors.onPrimaryContainer,
        colors.onPrimaryContainer,
        Icons.check_circle_outline,
      ),
    };

    return Semantics(
      liveRegion: true,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.medium,
          vertical: AppSpacing.normal,
        ),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(AppRadius.small),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 20, color: iconColor),
            const SizedBox(width: AppSpacing.medium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: foreground,
                      fontWeight: details == null ? null : FontWeight.w500,
                    ),
                  ),
                  if (details != null)
                    Text(
                      details!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: foreground,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
