import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/app_logo.dart';
import '../../../core/widgets/key_hint.dart';
import '../../../core/widgets/user_avatar.dart';
import '../../../data/models/discipline.dart';
import '../../../data/models/user_profile.dart';
import '../app_section.dart';
import 'sync_indicator.dart';

/// Постійна бічна панель широкої розкладки (від 840 pt, NFR-13).
class AppSidebar extends StatelessWidget {
  const AppSidebar({
    super.key,
    required this.user,
    required this.disciplines,
    required this.selected,
    required this.onSelect,
  });

  final UserProfile user;
  final List<Discipline> disciplines;
  final AppSection selected;
  final ValueChanged<AppSection> onSelect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      width: AppSizes.sidebarWidth,
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        border: Border(right: BorderSide(color: colors.outlineVariant)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.large,
              AppSpacing.large,
              AppSpacing.medium,
              AppSpacing.medium,
            ),
            child: Row(
              children: [
                const AppLogo(size: AppSizes.logoSmall),
                const SizedBox(width: AppSpacing.normal),
                Expanded(
                  child: Text(
                    AppStrings.appShortTitle,
                    style: theme.textTheme.titleSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          for (final section in AppSection.primary)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.normal,
              ),
              child: _NavItem(
                section: section,
                isSelected: section == selected,
                onTap: () => onSelect(section),
                trailing: section == AppSection.search
                    ? const KeyHint(keys: AppStrings.searchShortcut)
                    : null,
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.large,
              AppSpacing.large,
              AppSpacing.medium,
              AppSpacing.small,
            ),
            child: Text(
              AppStrings.myDisciplines,
              style: theme.textTheme.labelMedium?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.normal,
              ),
              children: [
                for (final discipline in disciplines)
                  _DisciplineItem(
                    discipline: discipline,
                    onTap: () => onSelect(AppSection.disciplines),
                  ),
              ],
            ),
          ),
          const Divider(
            indent: AppSpacing.medium,
            endIndent: AppSpacing.medium,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.large,
              AppSpacing.normal,
              AppSpacing.medium,
              AppSpacing.tiny,
            ),
            child: SyncIndicator(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.small,
              0,
              AppSpacing.small,
              AppSpacing.small,
            ),
            child: _UserTile(
              user: user,
              isSelected: selected == AppSection.profile,
              onOpenProfile: () => onSelect(AppSection.profile),
              onOpenSettings: () => onSelect(AppSection.settings),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.section,
    required this.isSelected,
    required this.onTap,
    this.trailing,
  });

  final AppSection section;
  final bool isSelected;
  final VoidCallback onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final foreground = isSelected
        ? colors.onSecondaryContainer
        : colors.onSurfaceVariant;

    return Semantics(
      selected: isSelected,
      button: true,
      child: Material(
        color: isSelected ? colors.secondaryContainer : Colors.transparent,
        shape: const StadiumBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            height: AppSizes.buttonHeight,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.normal,
              ),
              child: Row(
                children: [
                  Icon(
                    isSelected ? section.selectedIcon : section.icon,
                    size: 20,
                    color: foreground,
                  ),
                  const SizedBox(width: AppSpacing.normal),
                  Expanded(
                    child: Text(
                      section.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: isSelected ? foreground : colors.onSurface,
                        fontWeight: isSelected ? FontWeight.w600 : null,
                      ),
                    ),
                  ),
                  ?trailing,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DisciplineItem extends StatelessWidget {
  const _DisciplineItem({required this.discipline, required this.onTap});

  final Discipline discipline;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = discipline.accent.resolve(theme.colorScheme);

    return Tooltip(
      message: discipline.title,
      waitDuration: const Duration(seconds: 1),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.small),
        child: SizedBox(
          height: 36,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.normal),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: accent.foreground,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: AppSpacing.medium),
                Expanded(
                  child: Text(
                    discipline.title,
                    style: theme.textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UserTile extends StatelessWidget {
  const _UserTile({
    required this.user,
    required this.isSelected,
    required this.onOpenProfile,
    required this.onOpenSettings,
  });

  final UserProfile user;
  final bool isSelected;
  final VoidCallback onOpenProfile;
  final VoidCallback onOpenSettings;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Material(
      color: isSelected ? colors.secondaryContainer : Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.medium),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onOpenProfile,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.normal,
            AppSpacing.small,
            AppSpacing.tiny,
            AppSpacing.small,
          ),
          child: Row(
            children: [
              UserAvatar(initials: user.initials, size: 36),
              const SizedBox(width: AppSpacing.normal),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      user.email,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onOpenSettings,
                tooltip: AppStrings.navSettings,
                icon: const Icon(Icons.settings_outlined, size: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
