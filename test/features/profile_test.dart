import 'package:flutter_test/flutter_test.dart';

import 'package:study_materials_catalog/core/constants/app_strings.dart';
import 'package:study_materials_catalog/data/mock/mock_data.dart';
import 'package:study_materials_catalog/features/auth/login_screen.dart';
import 'package:study_materials_catalog/features/profile/profile_screen.dart';

import '../helpers/pump_app.dart';

Future<void> _openProfile(WidgetTester tester) async {
  await tester.tap(find.text(MockData.demoUser.name));
  await tester.pumpAndSettle();
  expect(find.byType(ProfileScreen), findsOneWidget);
}

void main() {
  testWidgets('shows profile data and statistics', (tester) async {
    await pumpApp(tester, user: MockData.demoUser);
    await _openProfile(tester);

    expect(find.text(AppStrings.profileData), findsOneWidget);
    expect(find.text('ПЗ-32'), findsOneWidget);
    expect(find.text('6 дисциплін'), findsOneWidget);
    expect(find.text('83 матеріали'), findsOneWidget);
    expect(find.text('Змінено 14 вер. 2026'), findsOneWidget);
  });

  testWidgets('saving an empty name is rejected', (tester) async {
    await pumpApp(tester, user: MockData.demoUser);
    await _openProfile(tester);

    await tester.enterText(fieldWithLabel(AppStrings.nameLabel), '  ');
    await tester.tap(find.text(AppStrings.saveChanges));
    await tester.pump();

    expect(find.text(AppStrings.nameRequired), findsOneWidget);
  });

  testWidgets('saved name appears in the sidebar', (tester) async {
    final auth = await pumpApp(tester, user: MockData.demoUser);
    await _openProfile(tester);

    await tester.enterText(
      fieldWithLabel(AppStrings.nameLabel),
      'Владислав Г.',
    );
    await tester.tap(find.text(AppStrings.saveChanges));
    await tester.pumpAndSettle();

    expect(auth.currentUser?.name, 'Владислав Г.');
    expect(find.text(AppStrings.changesSaved), findsOneWidget);
  });

  testWidgets('unsupported photo shows the error banner', (tester) async {
    await pumpApp(tester, user: MockData.demoUser);
    await _openProfile(tester);

    await tester.tap(find.byTooltip(AppStrings.changePhoto));
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppStrings.chooseImage));
    await tester.pumpAndSettle();

    expect(
      find.text(AppStrings.photoUnsupported('фото_профілю.heic')),
      findsOneWidget,
    );
  });

  testWidgets('password change checks the current password', (tester) async {
    await pumpApp(tester, user: MockData.demoUser);
    await _openProfile(tester);

    await tester.tap(find.text(AppStrings.change));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.changePasswordTitle), findsOneWidget);

    await tester.enterText(
      fieldWithLabel(AppStrings.currentPasswordLabel),
      'wrong-pass1',
    );
    await tester.enterText(
      fieldWithLabel(AppStrings.newPasswordLabel),
      'newpass123',
    );
    await tester.enterText(
      fieldWithLabel(AppStrings.confirmNewPasswordLabel),
      'newpass123',
    );
    await tester.tap(find.text(AppStrings.changePasswordAction));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.wrongCurrentPassword), findsOneWidget);

    await tester.enterText(
      fieldWithLabel(AppStrings.currentPasswordLabel),
      MockData.demoPassword,
    );
    await tester.tap(find.text(AppStrings.changePasswordAction));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.changePasswordTitle), findsNothing);
    expect(find.text(AppStrings.passwordChanged), findsOneWidget);
  });

  testWidgets('sign-out asks for confirmation and opens sign-in', (
    tester,
  ) async {
    final auth = await pumpApp(tester, user: MockData.demoUser);
    await _openProfile(tester);

    await tester.tap(find.text(AppStrings.signOut));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.signOutTitle), findsOneWidget);

    await tester.tap(find.text(AppStrings.signOutConfirm));
    await tester.pumpAndSettle();

    expect(auth.currentUser, isNull);
    expect(find.byType(LoginScreen), findsOneWidget);
  });
}
