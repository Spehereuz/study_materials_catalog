import 'package:flutter/foundation.dart';

import '../models/user_profile.dart';

/// Причини, з яких операція автентифікації може не вдатися.
enum AuthError { invalidCredentials, emailAlreadyInUse, wrongPassword }

class AuthException implements Exception {
  const AuthException(this.error);

  final AuthError error;

  @override
  String toString() => 'AuthException($error)';
}

/// Контракт автентифікації та керування профілем. Зараз реалізований
/// заглушкою [MockAuthService]; у наступних роботах — через Firebase Auth.
abstract class AuthService extends ChangeNotifier {
  /// Користувач поточної сесії або `null`, якщо вхід не виконано.
  UserProfile? get currentUser;

  Future<UserProfile> signIn({required String email, required String password});

  Future<UserProfile> register({
    required String name,
    required String email,
    required String password,
  });

  Future<void> sendPasswordReset(String email);

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  Future<UserProfile> updateProfile({
    required String name,
    required String institution,
    required String group,
  });

  Future<void> signOut();
}
