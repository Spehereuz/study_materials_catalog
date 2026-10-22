import 'package:flutter/material.dart';

import '../constants/app_spacing.dart';

/// Верхня панель розділу: назва зліва, дії праворуч, лінія знизу.
class PageHeader extends StatelessWidget {
  const PageHeader({super.key, required this.title, this.actions = const []});

  final String title;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: AppSizes.headerHeight,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.large),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          bottom: BorderSide(color: theme.colorScheme.outlineVariant),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Semantics(
              header: true,
              child: Text(
                title,
                style: theme.textTheme.titleLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          for (final action in actions) ...[
            const SizedBox(width: AppSpacing.small),
            action,
          ],
        ],
      ),
    );
  }
}
