import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/app_logo.dart';
import '../../../core/widgets/user_avatar.dart';
import '../../../data/models/user_profile.dart';
import '../app_section.dart';
import 'sync_indicator.dart';

/// Навігаційний рейл компактної розкладки (600–839 pt, NFR-13).
class AppRail extends StatelessWidget {
  const AppRail({
    super.key,
    required this.user,
    required this.selected,
    required this.onSelect,
  });

  final UserProfile user;
  final AppSection selected;
  final ValueChanged<AppSection> onSelect;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final index = AppSection.primary.indexOf(selected);

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: colors.outlineVariant)),
      ),
      child: NavigationRail(
        selectedIndex: index == -1 ? null : index,
        onDestinationSelected: (i) => onSelect(AppSection.primary[i]),
        labelType: NavigationRailLabelType.all,
        leading: const Padding(
          padding: EdgeInsets.symmetric(vertical: AppSpacing.small),
          child: AppLogo(size: AppSizes.logoSmall + AppSpacing.tiny),
        ),
        destinations: [
          for (final section in AppSection.primary)
            NavigationRailDestination(
              icon: Icon(section.icon),
              selectedIcon: Icon(section.selectedIcon),
              label: Text(section.label),
            ),
        ],
        trailingAtBottom: true,
        trailing: Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.medium),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SyncIndicator(compact: true),
              const SizedBox(height: AppSpacing.small),
              IconButton(
                onPressed: () => onSelect(AppSection.settings),
                tooltip: AppStrings.navSettings,
                isSelected: selected == AppSection.settings,
                icon: const Icon(Icons.settings_outlined),
                selectedIcon: const Icon(Icons.settings),
              ),
              const SizedBox(height: AppSpacing.small),
              Tooltip(
                message: '${AppStrings.navProfile}: ${user.name}',
                child: InkResponse(
                  onTap: () => onSelect(AppSection.profile),
                  radius: 24,
                  child: UserAvatar(initials: user.initials, size: 40),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
