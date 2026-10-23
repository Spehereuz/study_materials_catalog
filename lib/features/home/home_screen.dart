import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_strings.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_snack_bar.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/page_header.dart';
import '../../data/models/catalog_snapshot.dart';
import '../../data/models/study_material.dart';
import '../../data/models/user_profile.dart';
import '../shell/app_section.dart';
import '../shell/catalog_controller.dart';
import 'widgets/disciplines_grid.dart';
import 'widgets/favorites_card.dart';
import 'widgets/recent_materials_card.dart';
import 'widgets/search_launcher.dart';

/// Головний екран (FR-08): привітання, пошук, швидкі дії,
/// нещодавні та обрані матеріали, картки дисциплін.
class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.user,
    required this.catalog,
    required this.onOpenSection,
  });

  /// Від цієї ширини вмісту в заголовку показуються підписи кнопок.
  static const _wideHeaderWidth = 860.0;

  final UserProfile user;
  final CatalogController catalog;
  final ValueChanged<AppSection> onOpenSection;

  @override
  Widget build(BuildContext context) {
    final snapshot = catalog.snapshot;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= _wideHeaderWidth;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PageHeader(
              title: AppStrings.navHome,
              actions: _buildActions(context, isWide: isWide),
            ),
            Expanded(
              child: catalog.isLoading && snapshot.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : snapshot.isEmpty
                  ? _buildEmptyState(context)
                  : _buildContent(context, snapshot),
            ),
          ],
        );
      },
    );
  }

  List<Widget> _buildActions(BuildContext context, {required bool isWide}) {
    void notImplemented() =>
        showAppSnackBar(context, AppStrings.featureInProgress);

    if (!isWide) {
      return [
        IconButton(
          onPressed: () => onOpenSection(AppSection.search),
          tooltip: AppStrings.searchMaterialsHint,
          icon: const Icon(Icons.search),
        ),
        IconButton.outlined(
          onPressed: notImplemented,
          tooltip: AppStrings.newDiscipline,
          icon: const Icon(Icons.create_new_folder_outlined),
        ),
        IconButton.filled(
          onPressed: notImplemented,
          tooltip: AppStrings.newMaterial,
          icon: const Icon(Icons.note_add_outlined),
        ),
      ];
    }
    return [
      SearchLauncher(onTap: () => onOpenSection(AppSection.search)),
      const SizedBox(width: AppSpacing.tiny),
      AppButton(
        label: AppStrings.newDiscipline,
        icon: Icons.add,
        variant: AppButtonVariant.secondary,
        onPressed: notImplemented,
      ),
      AppButton(
        label: AppStrings.newMaterial,
        icon: Icons.add,
        onPressed: notImplemented,
      ),
    ];
  }

  Widget _buildEmptyState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.large),
      child: EmptyState(
        icon: Icons.library_books_outlined,
        title: AppStrings.emptyCatalogTitle,
        message: AppStrings.emptyCatalogMessage,
        action: AppButton(
          label: AppStrings.createFirstDiscipline,
          icon: Icons.add,
          onPressed: () =>
              showAppSnackBar(context, AppStrings.featureInProgress),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, CatalogSnapshot snapshot) {
    final theme = Theme.of(context);
    void openMaterial(StudyMaterial _) =>
        showAppSnackBar(context, AppStrings.featureInProgress);

    final recent = RecentMaterialsCard(
      snapshot: snapshot,
      onShowAll: () => onOpenSection(AppSection.search),
      onOpen: openMaterial,
      onFavoriteChanged: (material, value) =>
          catalog.setFavorite(material.id, value: value),
    );
    final favorites = FavoritesCard(snapshot: snapshot, onOpen: openMaterial);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.large),
      child: Align(
        alignment: Alignment.topLeft,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSizes.contentMaxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppStrings.greeting(user.firstName),
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.tiny),
              Text(
                AppStrings.catalogSummary(
                  snapshot.disciplines.length,
                  snapshot.topicCount,
                  snapshot.materialCount,
                ),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.large),
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < AppBreakpoints.twoColumnContent) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        recent,
                        const SizedBox(height: AppSpacing.large),
                        favorites,
                      ],
                    );
                  }
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 3, child: recent),
                      const SizedBox(width: AppSpacing.large),
                      Expanded(flex: 2, child: favorites),
                    ],
                  );
                },
              ),
              const SizedBox(height: AppSpacing.xLarge),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      AppStrings.myDisciplines,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  TextButton(
                    onPressed: () => onOpenSection(AppSection.disciplines),
                    child: const Text(AppStrings.allDisciplines),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.small),
              DisciplinesGrid(
                disciplines: snapshot.disciplines,
                onOpen: (_) => onOpenSection(AppSection.disciplines),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
