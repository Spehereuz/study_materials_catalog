import 'package:flutter_test/flutter_test.dart';

import 'package:study_materials_catalog/data/mock/mock_data.dart';
import 'package:study_materials_catalog/data/models/catalog_snapshot.dart';
import 'package:study_materials_catalog/data/services/auth_service.dart';
import 'package:study_materials_catalog/data/services/catalog_repository.dart';
import 'package:study_materials_catalog/data/services/mock_auth_service.dart';

void main() {
  late MockAuthService auth;

  setUp(() => auth = MockAuthService(latency: Duration.zero));

  test('signs in with demo credentials, e-mail is case-insensitive', () async {
    final user = await auth.signIn(
      email: ' VLAD@example.com ',
      password: MockData.demoPassword,
    );

    expect(user.id, MockData.demoUserId);
    expect(auth.currentUser, user);
    expect(user.initials, 'ВГ');
    expect(user.firstName, 'Владислав');
  });

  test('rejects a wrong password', () {
    expect(
      auth.signIn(email: MockData.demoEmail, password: 'wrong-pass1'),
      throwsA(
        isA<AuthException>().having(
          (e) => e.error,
          'error',
          AuthError.invalidCredentials,
        ),
      ),
    );
  });

  test('registers a new account once', () async {
    final user = await auth.register(
      name: ' Олена Коваль ',
      email: 'olena@example.com',
      password: 'secret123',
    );
    expect(user.name, 'Олена Коваль');
    expect(auth.currentUser, user);

    expect(
      auth.register(
        name: 'Олена',
        email: 'OLENA@example.com',
        password: 'secret123',
      ),
      throwsA(isA<AuthException>()),
    );
  });

  test('changes the password after checking the current one', () async {
    await auth.signIn(
      email: MockData.demoEmail,
      password: MockData.demoPassword,
    );

    await expectLater(
      auth.changePassword(currentPassword: 'nope', newPassword: 'newpass123'),
      throwsA(isA<AuthException>()),
    );
    await auth.changePassword(
      currentPassword: MockData.demoPassword,
      newPassword: 'newpass123',
    );
    await auth.signOut();
    expect(auth.currentUser, isNull);

    final user = await auth.signIn(
      email: MockData.demoEmail,
      password: 'newpass123',
    );
    expect(user.email, MockData.demoEmail);
  });

  test(
    'demo user gets the mockup catalog, new users get an empty one',
    () async {
      final repository = MockCatalogRepository(latency: Duration.zero);

      final demo = await repository.fetch(MockData.demoUser);
      expect(demo.disciplines, hasLength(6));
      expect(demo.topicCount, 24);
      expect(demo.materialCount, 83);
      expect(demo.recent.first.title, 'Лекція 3. Віджети у Flutter');
      expect(demo.favorites, hasLength(3));

      final newUser = await auth.register(
        name: 'Олена',
        email: 'olena@example.com',
        password: 'secret123',
      );
      expect(await repository.fetch(newUser), CatalogSnapshot.empty);
    },
  );
}
