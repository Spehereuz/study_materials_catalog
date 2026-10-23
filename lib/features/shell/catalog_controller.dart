import 'package:flutter/foundation.dart';

import '../../data/models/catalog_snapshot.dart';
import '../../data/models/user_profile.dart';
import '../../data/services/catalog_repository.dart';

/// Стан каталогу для головного вікна: завантаження і позначки «Обране».
class CatalogController extends ChangeNotifier {
  CatalogController(this._repository);

  final CatalogRepository _repository;
  CatalogSnapshot _snapshot = CatalogSnapshot.empty;
  bool _isLoading = false;
  bool _isDisposed = false;

  CatalogSnapshot get snapshot => _snapshot;
  bool get isLoading => _isLoading;

  Future<void> load(UserProfile user) async {
    _isLoading = true;
    _notify();
    try {
      _snapshot = await _repository.fetch(user);
    } finally {
      _isLoading = false;
      _notify();
    }
  }

  /// Позначка оновлюється в інтерфейсі одразу, без очікування сервера.
  Future<void> setFavorite(String materialId, {required bool value}) async {
    _snapshot = _snapshot.withFavorite(materialId, value: value);
    _notify();
    await _repository.setFavorite(materialId, value: value);
  }

  void _notify() {
    if (!_isDisposed) notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
