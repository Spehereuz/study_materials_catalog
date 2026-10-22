import '../constants/app_strings.dart';

/// Валідатори полів форм. Повертають текст помилки або `null`,
/// якщо значення коректне.
abstract final class Validators {
  static final _emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]{2,}$');
  static final _letterPattern = RegExp(r'[A-Za-zА-Яа-яЄєІіЇїҐґ]');
  static final _digitPattern = RegExp(r'\d');

  static const minPasswordLength = 8;
  static const maxPhotoBytes = 5 * 1024 * 1024;
  static const _photoExtensions = {'jpg', 'jpeg', 'png'};

  /// Електронна пошта: обов'язкова й у форматі name@example.com.
  static String? email(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return AppStrings.emailRequired;
    if (!_emailPattern.hasMatch(text)) return AppStrings.emailInvalid;
    return null;
  }

  /// Пароль на екрані входу: лише перевірка, що поле заповнене.
  static String? loginPassword(String? value) {
    if (value == null || value.isEmpty) return AppStrings.passwordRequired;
    return null;
  }

  /// Новий пароль: щонайменше 8 символів, літери та цифри (FR-01, FR-07).
  static String? newPassword(String? value) {
    final text = value ?? '';
    if (text.isEmpty) return AppStrings.passwordRequired;
    final isStrong =
        text.length >= minPasswordLength &&
        _letterPattern.hasMatch(text) &&
        _digitPattern.hasMatch(text);
    return isStrong ? null : AppStrings.passwordTooWeak;
  }

  /// Підтвердження пароля має збігатися з [original].
  static String? confirmPassword(String? value, String original) {
    final text = value ?? '';
    if (text.isEmpty) return AppStrings.confirmPasswordRequired;
    if (text != original) return AppStrings.passwordsDoNotMatch;
    return null;
  }

  /// Ім'я користувача не може бути порожнім (FR-05).
  static String? name(String? value) {
    if ((value?.trim() ?? '').isEmpty) return AppStrings.nameRequired;
    return null;
  }

  /// Фото профілю: JPG або PNG до 5 МБ (FR-06).
  static String? profilePhoto(String fileName, int sizeBytes) {
    final dot = fileName.lastIndexOf('.');
    final extension = dot == -1
        ? ''
        : fileName.substring(dot + 1).toLowerCase();
    if (!_photoExtensions.contains(extension)) {
      return AppStrings.photoUnsupported(fileName);
    }
    if (sizeBytes > maxPhotoBytes) return AppStrings.photoTooLarge(fileName);
    return null;
  }
}
