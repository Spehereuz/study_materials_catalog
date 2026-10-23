import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app_scope.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_strings.dart';
import '../../data/models/user_profile.dart';
import '../home/home_screen.dart';
import '../placeholder/coming_soon_screen.dart';
import '../profile/profile_screen.dart';
import 'app_section.dart';
import 'catalog_controller.dart';
import 'widgets/app_rail.dart';
import 'widgets/app_sidebar.dart';

/// Головне вікно після входу: навігація зліва і вміст обраного розділу.
/// Розділи перемикаються станом, а не маршрутами, тому навігація
/// не додає записів у стек [Navigator].
class AppShell extends StatefulWidget {
  const AppShell({super.key, this.initialSection = AppSection.home});

  final AppSection initialSection;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late AppSection _section = widget.initialSection;
  CatalogController? _catalog;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_catalog != null) return;
    final scope = AppScope.of(context);
    final catalog = CatalogController(scope.catalog);
    final user = scope.auth.currentUser;
    if (user != null) catalog.load(user);
    _catalog = catalog;
  }

  @override
  void dispose() {
    _catalog?.dispose();
    super.dispose();
  }

  void _select(AppSection section) {
    if (section != _section) setState(() => _section = section);
  }

  @override
  Widget build(BuildContext context) {
    final auth = AppScope.of(context).auth;
    final catalog = _catalog!;

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyF, meta: true): () =>
            _select(AppSection.search),
        const SingleActivator(LogicalKeyboardKey.comma, meta: true): () =>
            _select(AppSection.settings),
      },
      child: Focus(
        autofocus: true,
        child: Scaffold(
          body: ListenableBuilder(
            listenable: Listenable.merge([auth, catalog]),
            builder: (context, _) {
              final user = auth.currentUser;
              if (user == null) return const SizedBox.shrink();

              return LayoutBuilder(
                builder: (context, constraints) {
                  final isWide =
                      constraints.maxWidth >= AppBreakpoints.expanded;
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (isWide)
                        AppSidebar(
                          user: user,
                          disciplines: catalog.snapshot.disciplines,
                          selected: _section,
                          onSelect: _select,
                        )
                      else
                        AppRail(
                          user: user,
                          selected: _section,
                          onSelect: _select,
                        ),
                      Expanded(
                        child: ColoredBox(
                          color: Theme.of(context).colorScheme.surface,
                          child: KeyedSubtree(
                            key: ValueKey(_section),
                            child: _buildSection(user, catalog),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSection(UserProfile user, CatalogController catalog) {
    return switch (_section) {
      AppSection.home => HomeScreen(
        user: user,
        catalog: catalog,
        onOpenSection: _select,
      ),
      AppSection.disciplines => const ComingSoonScreen(
        title: AppStrings.navDisciplines,
        icon: Icons.school_outlined,
        message: AppStrings.comingSoonDisciplines,
      ),
      AppSection.search => const ComingSoonScreen(
        title: AppStrings.navSearch,
        icon: Icons.search,
        message: AppStrings.comingSoonSearch,
      ),
      AppSection.profile => ProfileScreen(
        user: user,
        snapshot: catalog.snapshot,
      ),
      AppSection.settings => const ComingSoonScreen(
        title: AppStrings.navSettings,
        icon: Icons.settings_outlined,
        message: AppStrings.comingSoonSettings,
      ),
    };
  }
}
