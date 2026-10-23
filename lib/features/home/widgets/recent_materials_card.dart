import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/study_material_tile.dart';
import '../../../data/models/catalog_snapshot.dart';
import '../../../data/models/study_material.dart';

/// Блок «Нещодавні матеріали» з датою відкриття і зіркою «Обране».
class RecentMaterialsCard extends StatelessWidget {
  const RecentMaterialsCard({
    super.key,
    required this.snapshot,
    required this.onShowAll,
    required this.onOpen,
    required this.onFavoriteChanged,
  });

  final CatalogSnapshot snapshot;
  final VoidCallback onShowAll;
  final ValueChanged<StudyMaterial> onOpen;
  final void Function(StudyMaterial material, bool value) onFavoriteChanged;

  @override
  Widget build(BuildContext context) {
    final recent = snapshot.recent;

    return SectionCard(
      title: AppStrings.recentMaterials,
      padding: const EdgeInsets.all(AppSpacing.medium),
      trailing: TextButton(
        onPressed: onShowAll,
        child: const Text(AppStrings.allMaterials),
      ),
      child: recent.isEmpty
          ? const _EmptyHint(AppStrings.noRecentMaterials)
          : Column(
              children: [
                for (final material in recent)
                  StudyMaterialTile(
                    material: material,
                    subtitle: _pathOf(material),
                    dateText: DateFormatter.relative(material.lastOpenedAt!),
                    onTap: () => onOpen(material),
                    onFavoriteChanged: (value) =>
                        onFavoriteChanged(material, value),
                  ),
              ],
            ),
    );
  }

  String _pathOf(StudyMaterial material) {
    final discipline = snapshot.disciplineOf(material)?.title ?? '';
    final topic = snapshot.topicOf(material)?.title ?? '';
    return AppStrings.materialPath(discipline, topic);
  }
}

class _EmptyHint extends StatelessWidget {
  const _EmptyHint(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.small),
      child: Text(
        text,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
