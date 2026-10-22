import 'package:flutter/widgets.dart';

import 'data/services/auth_service.dart';
import 'data/services/catalog_repository.dart';
import 'data/services/photo_picker.dart';

/// Надає сервіси застосунку всьому дереву віджетів.
/// Реалізації підставляються в `main.dart` (зараз — заглушки).
class AppScope extends InheritedWidget {
  const AppScope({
    super.key,
    required this.auth,
    required this.catalog,
    required this.photoPicker,
    required super.child,
  });

  final AuthService auth;
  final CatalogRepository catalog;
  final PhotoPicker photoPicker;

  static AppScope of(BuildContext context) {
    final scope = context.getInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope не знайдено в дереві віджетів');
    return scope!;
  }

  @override
  bool updateShouldNotify(AppScope oldWidget) =>
      auth != oldWidget.auth ||
      catalog != oldWidget.catalog ||
      photoPicker != oldWidget.photoPicker;
}
