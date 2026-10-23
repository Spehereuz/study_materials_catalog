import 'package:flutter/material.dart';

import 'app_scope.dart';
import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'data/services/auth_service.dart';
import 'data/services/catalog_repository.dart';
import 'data/services/photo_picker.dart';
import 'features/shell/app_shell.dart';

/// Кореневий віджет: сервіси, тема і перший екран.
class StudyMaterialsApp extends StatelessWidget {
  const StudyMaterialsApp({
    super.key,
    required this.auth,
    required this.catalog,
    required this.photoPicker,
  });

  final AuthService auth;
  final CatalogRepository catalog;
  final PhotoPicker photoPicker;

  @override
  Widget build(BuildContext context) {
    return AppScope(
      auth: auth,
      catalog: catalog,
      photoPicker: photoPicker,
      child: MaterialApp(
        title: AppStrings.appTitle,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        home: const AppShell(),
      ),
    );
  }
}
