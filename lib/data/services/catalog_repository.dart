import '../mock/mock_data.dart';
import '../models/catalog_snapshot.dart';
import '../models/user_profile.dart';

/// Джерело даних каталогу (дисципліни, теми, матеріали).
abstract interface class CatalogRepository {
  Future<CatalogSnapshot> fetch(UserProfile user);

  Future<void> setFavorite(String materialId, {required bool value});
}

/// Заглушка з hardcoded-даними: демо-користувач отримує каталог з макетів,
/// новий зареєстрований користувач — порожній каталог.
class MockCatalogRepository implements CatalogRepository {
  MockCatalogRepository({
    this.latency = const Duration(milliseconds: 400),
    DateTime Function()? clock,
  }) : _clock = clock ?? DateTime.now;

  final Duration latency;
  final DateTime Function() _clock;

  @override
  Future<CatalogSnapshot> fetch(UserProfile user) async {
    await _simulateNetwork();
    if (user.id != MockData.demoUserId) return CatalogSnapshot.empty;
    return MockData.catalog(_clock());
  }

  @override
  Future<void> setFavorite(String materialId, {required bool value}) =>
      _simulateNetwork();

  Future<void> _simulateNetwork() =>
      latency == Duration.zero ? Future.value() : Future.delayed(latency);
}
