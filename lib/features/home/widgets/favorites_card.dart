import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/study_material_tile.dart';
import '../../../data/models/catalog_snapshot.dart';
import '../../../data/models/study_material.dart';

/// Блок «Обране» (FR-20): матеріали, позначені зірочкою.
class FavoritesCard extends StatelessWidget {
  const FavoritesCard({
    super.key,
    required this.snapshot,
    required this.onOpen,
  });

  final CatalogSnapshot snapshot;
  final ValueChanged<StudyMaterial> onOpen;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final favorites = snapshot.favorites;

    return SectionCard(
      title: AppStrings.favorites,
      padding: const EdgeInsets.all(AppSpacing.medium),
      child: favorites.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(AppSpacing.small),
              child: Text(
                AppStrings.noFavorites,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            )
          : Column(
              children: [
                for (final material in favorites)
                  StudyMaterialTile(
                    material: material,
                    subtitle:
                        '${snapshot.disciplineOf(material)?.title ?? ''}, '
                        '${material.type.label}',
                    onTap: () => onOpen(material),
                  ),
              ],
            ),
    );
  }
}
