import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/key_hint.dart';

/// Поле пошуку на головному екрані (FR-08). Відкриває розділ «Пошук».
class SearchLauncher extends StatelessWidget {
  const SearchLauncher({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Semantics(
      button: true,
      label: AppStrings.searchMaterialsHint,
      excludeSemantics: true,
      child: Material(
        color: colors.surfaceContainerHigh,
        shape: const StadiumBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            width: 272,
            height: 36,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.normal,
              ),
              child: Row(
                children: [
                  Icon(Icons.search, size: 20, color: colors.onSurfaceVariant),
                  const SizedBox(width: AppSpacing.small),
                  Expanded(
                    child: Text(
                      AppStrings.searchMaterialsHint,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const KeyHint(keys: AppStrings.searchShortcut),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
