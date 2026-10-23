import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/section_card.dart';

/// Картка «Безпека»: зміна пароля (FR-07) і вихід з облікового запису (FR-04).
class SecurityCard extends StatelessWidget {
  const SecurityCard({
    super.key,
    required this.passwordChangedAt,
    required this.onChangePassword,
    required this.onSignOut,
  });

  final DateTime passwordChangedAt;
  final VoidCallback onChangePassword;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.colorScheme.onSurfaceVariant;

    return SectionCard(
      title: AppStrings.security,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(Icons.lock_outline, size: 20, color: muted),
              const SizedBox(width: AppSpacing.normal),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.passwordLabel,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      AppStrings.passwordChangedOn(
                        DateFormatter.full(passwordChangedAt),
                      ),
                      style: theme.textTheme.bodySmall?.copyWith(color: muted),
                    ),
                  ],
                ),
              ),
              AppButton(
                label: AppStrings.change,
                variant: AppButtonVariant.secondary,
                onPressed: onChangePassword,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.medium),
          AppButton(
            label: AppStrings.signOut,
            icon: Icons.logout,
            variant: AppButtonVariant.danger,
            expanded: true,
            onPressed: onSignOut,
          ),
        ],
      ),
    );
  }
}
