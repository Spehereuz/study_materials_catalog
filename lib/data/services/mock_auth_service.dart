import '../mock/mock_data.dart';
import '../models/user_profile.dart';
import 'auth_service.dart';

/// Заглушка автентифікації: облікові записи зберігаються в пам'яті,
/// мережеві запити імітуються затримкою [latency].
class MockAuthService extends AuthService {
  MockAuthService({
    this.latency = const Duration(milliseconds: 600),
    DateTime Function()? clock,
  }) : _clock = clock ?? DateTime.now {
    _accounts[MockData.demoEmail] = _Account(
      MockData.demoUser,
      MockData.demoPassword,
    );
  }

  final Duration latency;
  final DateTime Function() _clock;
  final _accounts = <String, _Account>{};
  UserProfile? _currentUser;

  @override
  UserProfile? get currentUser => _currentUser;

  @override
  Future<UserProfile> signIn({
    required String email,
    required String password,
  }) async {
    await _simulateNetwork();
    final account = _accounts[_normalize(email)];
    if (account == null || account.password != password) {
      throw const AuthException(AuthError.invalidCredentials);
    }
    _setCurrent(account.profile);
    return account.profile;
  }

  @override
  Future<UserProfile> register({
    required String name,
    required String email,
    required String password,
  }) async {
    await _simulateNetwork();
    final key = _normalize(email);
    if (_accounts.containsKey(key)) {
      throw const AuthException(AuthError.emailAlreadyInUse);
    }
    final profile = UserProfile(
      id: 'user-${_accounts.length + 1}',
      name: name.trim(),
      email: key,
      passwordChangedAt: _clock(),
    );
    _accounts[key] = _Account(profile, password);
    _setCurrent(profile);
    return profile;
  }

  @override
  Future<void> sendPasswordReset(String email) => _simulateNetwork();

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await _simulateNetwork();
    final account = _accounts[_requireUser().email]!;
    if (account.password != currentPassword) {
      throw const AuthException(AuthError.wrongPassword);
    }
    account.password = newPassword;
    _setCurrent(account.profile.copyWith(passwordChangedAt: _clock()));
  }

  @override
  Future<UserProfile> updateProfile({
    required String name,
    required String institution,
    required String group,
  }) async {
    await _simulateNetwork();
    final updated = _requireUser().copyWith(
      name: name.trim(),
      institution: institution.trim(),
      group: group.trim(),
    );
    _setCurrent(updated);
    return updated;
  }

  @override
  Future<void> signOut() async {
    await _simulateNetwork();
    _currentUser = null;
    notifyListeners();
  }

  void _setCurrent(UserProfile profile) {
    _accounts[profile.email]?.profile = profile;
    _currentUser = profile;
    notifyListeners();
  }

  UserProfile _requireUser() =>
      _currentUser ?? (throw StateError('No signed-in user'));

  Future<void> _simulateNetwork() =>
      latency == Duration.zero ? Future.value() : Future.delayed(latency);

  static String _normalize(String email) => email.trim().toLowerCase();
}

class _Account {
  _Account(this.profile, this.password);

  UserProfile profile;
  String password;
}
