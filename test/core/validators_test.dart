import 'package:flutter_test/flutter_test.dart';

import 'package:study_materials_catalog/core/constants/app_strings.dart';
import 'package:study_materials_catalog/core/utils/validators.dart';

void main() {
  group('Validators.email', () {
    test('requires a value', () {
      expect(Validators.email(''), AppStrings.emailRequired);
      expect(Validators.email('   '), AppStrings.emailRequired);
    });

    test('checks the format', () {
      expect(Validators.email('vlad'), AppStrings.emailInvalid);
      expect(Validators.email('vlad@example'), AppStrings.emailInvalid);
      expect(Validators.email('vlad@example.com'), isNull);
      expect(Validators.email(' vlad@example.com '), isNull);
    });
  });

  group('Validators.newPassword', () {
    test('requires 8+ characters with letters and digits', () {
      expect(Validators.newPassword(''), AppStrings.passwordRequired);
      expect(Validators.newPassword('abc123'), AppStrings.passwordTooWeak);
      expect(Validators.newPassword('abcdefgh'), AppStrings.passwordTooWeak);
      expect(Validators.newPassword('12345678'), AppStrings.passwordTooWeak);
      expect(Validators.newPassword('student2026'), isNull);
      expect(Validators.newPassword('пароль123'), isNull);
    });
  });

  test('Validators.confirmPassword compares with the original', () {
    expect(
      Validators.confirmPassword('', 'secret123'),
      AppStrings.confirmPasswordRequired,
    );
    expect(
      Validators.confirmPassword('secret124', 'secret123'),
      AppStrings.passwordsDoNotMatch,
    );
    expect(Validators.confirmPassword('secret123', 'secret123'), isNull);
  });

  test('Validators.name rejects blank names', () {
    expect(Validators.name(' '), AppStrings.nameRequired);
    expect(Validators.name('Владислав'), isNull);
  });

  test('Validators.profilePhoto accepts JPG/PNG up to 5 MB', () {
    expect(
      Validators.profilePhoto('photo.heic', 1024),
      AppStrings.photoUnsupported('photo.heic'),
    );
    expect(
      Validators.profilePhoto('photo.PNG', 6 * 1024 * 1024),
      AppStrings.photoTooLarge('photo.PNG'),
    );
    expect(Validators.profilePhoto('photo.jpeg', 1024), isNull);
  });
}
