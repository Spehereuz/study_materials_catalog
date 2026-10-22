import 'package:flutter/material.dart';

import '../../data/models/discipline.dart';
import '../constants/app_spacing.dart';
import '../constants/app_strings.dart';
import 'tinted_icon.dart';

extension DisciplineIconUi on DisciplineIcon {
  IconData get data => switch (this) {
    DisciplineIcon.code => Icons.code,
    DisciplineIcon.database => Icons.storage_outlined,
    DisciplineIcon.requirements => Icons.assignment_outlined,
    DisciplineIcon.terminal => Icons.terminal,
    DisciplineIcon.diagram => Icons.account_tree_outlined,
    DisciplineIcon.language => Icons.translate,
  };
}

/// Картка дисципліни: іконка, назва, кількість тем і матеріалів (FR-08).
class DisciplineCard extends StatelessWidget {
  const DisciplineCard({super.key, required this.discipline, this.onTap});

  final Discipline discipline;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.medium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TintedIcon(
                icon: discipline.icon.data,
                accent: discipline.accent,
                size: 40,
              ),
              const SizedBox(height: AppSpacing.large),
              Text(
                discipline.title,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.tiny),
              Text(
                '${AppStrings.topicsCount(discipline.topicCount)}, '
                '${AppStrings.materialsCount(discipline.materialCount)}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
