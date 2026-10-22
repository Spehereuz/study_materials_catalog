import 'package:flutter/material.dart';

import '../../data/models/study_material.dart';
import '../constants/app_spacing.dart';
import '../constants/app_strings.dart';
import '../theme/app_colors.dart';
import 'tinted_icon.dart';

/// Оформлення типів матеріалів: іконка, колір і назва.
extension StudyMaterialTypeUi on StudyMaterialType {
  IconData get icon => switch (this) {
    StudyMaterialType.note => Icons.description_outlined,
    StudyMaterialType.link => Icons.link,
    StudyMaterialType.file => Icons.attach_file,
  };

  AccentColor get accent => switch (this) {
    StudyMaterialType.note => AccentColor.indigo,
    StudyMaterialType.link => AccentColor.teal,
    StudyMaterialType.file => AccentColor.orange,
  };

  String get label => switch (this) {
    StudyMaterialType.note => AppStrings.materialTypeNote,
    StudyMaterialType.link => AppStrings.materialTypeLink,
    StudyMaterialType.file => AppStrings.materialTypeFile,
  };
}

/// Рядок матеріалу в списку: іконка типу, назва, шлях або опис,
/// дата і зірка «Обране» (FR-08, FR-20).
class StudyMaterialTile extends StatelessWidget {
  const StudyMaterialTile({
    super.key,
    required this.material,
    required this.subtitle,
    this.dateText,
    this.onTap,
    this.onFavoriteChanged,
  });

  final StudyMaterial material;
  final String subtitle;
  final String? dateText;
  final VoidCallback? onTap;

  /// Якщо задано, показується кнопка-зірка для перемикання «Обране».
  final ValueChanged<bool>? onFavoriteChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mutedStyle = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.small),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.small,
          vertical: AppSpacing.small,
        ),
        child: Row(
          children: [
            TintedIcon(icon: material.type.icon, accent: material.type.accent),
            const SizedBox(width: AppSpacing.medium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    material.title,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    subtitle,
                    style: mutedStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (dateText != null) ...[
              const SizedBox(width: AppSpacing.medium),
              Text(dateText!, style: mutedStyle),
            ],
            if (onFavoriteChanged != null) ...[
              const SizedBox(width: AppSpacing.tiny),
              _FavoriteButton(
                isFavorite: material.isFavorite,
                onChanged: onFavoriteChanged!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  const _FavoriteButton({required this.isFavorite, required this.onChanged});

  final bool isFavorite;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onChanged(!isFavorite),
      tooltip: isFavorite
          ? AppStrings.removeFromFavorites
          : AppStrings.addToFavorites,
      isSelected: isFavorite,
      icon: Icon(
        Icons.star_border,
        size: 20,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      selectedIcon: const Icon(Icons.star, size: 20, color: AppColors.favorite),
    );
  }
}
