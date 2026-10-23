import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/info_chip.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/status_banner.dart';
import '../../../core/widgets/user_avatar.dart';
import '../../../data/models/user_profile.dart';

/// Картка з фото, ім'ям, поштою і статистикою користувача (FR-05, FR-06).
class ProfileSummaryCard extends StatelessWidget {
  const ProfileSummaryCard({
    super.key,
    required this.user,
    required this.disciplineCount,
    required this.materialCount,
    required this.onPickPhoto,
    this.onRemovePhoto,
    this.photoError,
  });

  final UserProfile user;
  final int disciplineCount;
  final int materialCount;
  final VoidCallback onPickPhoto;

  /// `null`, якщо фото не завантажене і видаляти нічого.
  final VoidCallback? onRemovePhoto;

  /// Повідомлення про файл, який не пройшов перевірку.
  final String? photoError;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.colorScheme.onSurfaceVariant;

    return SectionCard(
      child: Column(
        children: [
          _AvatarWithMenu(
            initials: user.initials,
            onPickPhoto: onPickPhoto,
            onRemovePhoto: onRemovePhoto,
          ),
          const SizedBox(height: AppSpacing.medium),
          Text(
            user.name,
            style: theme.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          Text(
            user.email,
            style: theme.textTheme.bodyMedium?.copyWith(color: muted),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.normal),
          Wrap(
            spacing: AppSpacing.small,
            runSpacing: AppSpacing.small,
            alignment: WrapAlignment.center,
            children: [
              InfoChip(
                icon: Icons.school_outlined,
                label: AppStrings.disciplinesCount(disciplineCount),
              ),
              InfoChip(
                icon: Icons.description_outlined,
                label: AppStrings.materialsCount(materialCount),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.medium),
          if (photoError != null)
            StatusBanner(
              message: photoError!,
              details: AppStrings.photoFormatHint,
            )
          else
            Text(
              AppStrings.photoHint,
              style: theme.textTheme.bodySmall?.copyWith(color: muted),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}

/// Аватар з кнопкою-камерою; натискання відкриває меню дій з фото.
class _AvatarWithMenu extends StatelessWidget {
  const _AvatarWithMenu({
    required this.initials,
    required this.onPickPhoto,
    required this.onRemovePhoto,
  });

  final String initials;
  final VoidCallback onPickPhoto;
  final VoidCallback? onRemovePhoto;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return MenuAnchor(
      alignmentOffset: const Offset(AppSizes.avatarLarge - 24, -8),
      menuChildren: [
        MenuItemButton(
          leadingIcon: const Icon(Icons.image_outlined),
          shortcut: const SingleActivator(LogicalKeyboardKey.keyO, meta: true),
          onPressed: onPickPhoto,
          child: const Text(AppStrings.chooseImage),
        ),
        const Divider(),
        MenuItemButton(
          leadingIcon: Icon(
            Icons.delete_outline,
            color: onRemovePhoto == null ? null : colors.error,
          ),
          onPressed: onRemovePhoto,
          child: Text(
            AppStrings.removePhoto,
            style: onRemovePhoto == null
                ? null
                : TextStyle(color: colors.error),
          ),
        ),
      ],
      builder: (context, controller, _) {
        return Semantics(
          button: true,
          label: AppStrings.changePhoto,
          child: Tooltip(
            message: AppStrings.changePhoto,
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () =>
                  controller.isOpen ? controller.close() : controller.open(),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  UserAvatar(initials: initials, size: AppSizes.avatarLarge),
                  Positioned(
                    right: -2,
                    bottom: -2,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: colors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: colors.surface, width: 2),
                      ),
                      child: Icon(
                        Icons.photo_camera_outlined,
                        size: 16,
                        color: colors.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
