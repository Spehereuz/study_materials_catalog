import 'package:flutter_test/flutter_test.dart';

import 'package:study_materials_catalog/core/constants/app_strings.dart';
import 'package:study_materials_catalog/data/mock/mock_data.dart';
import 'package:study_materials_catalog/features/auth/login_screen.dart';

import '../helpers/pump_app.dart';

void main() {
  group('Sign in', () {
    testWidgets('app starts on the sign-in screen without a session', (
      tester,
    ) async {
      await pumpApp(tester);

      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.text(AppStrings.appTitle), findsOneWidget);
    });

    testWidgets('empty fields show validation errors', (tester) async {
      await pumpApp(tester);

      await tester.tap(find.text(AppStrings.signIn));
      await tester.pump();

      expect(find.text(AppStrings.emailRequired), findsOneWidget);
      expect(find.text(AppStrings.passwordRequired), findsOneWidget);
    });

    testWidgets('wrong password shows the error banner', (tester) async {
      await pumpApp(tester);

      await tester.enterText(
        fieldWithLabel(AppStrings.emailLabel),
        MockData.demoEmail,
      );
      await tester.enterText(
        fieldWithLabel(AppStrings.passwordLabel),
        'wrong-pass1',
      );
      await tester.tap(find.text(AppStrings.signIn));
      await tester.pumpAndSettle();

      expect(find.text(AppStrings.invalidCredentials), findsOneWidget);
      expect(find.byType(LoginScreen), findsOneWidget);
    });

    testWidgets('demo credentials open the home screen', (tester) async {
      final auth = await pumpApp(tester);

      await tester.enterText(
        fieldWithLabel(AppStrings.emailLabel),
        MockData.demoEmail,
      );
      await tester.enterText(
        fieldWithLabel(AppStrings.passwordLabel),
        MockData.demoPassword,
      );
      await tester.tap(find.text(AppStrings.signIn));
      await tester.pumpAndSettle();

      expect(auth.currentUser?.email, MockData.demoEmail);
      expect(find.byType(LoginScreen), findsNothing);
      expect(find.text('Вітаємо, Владиславе!'), findsOneWidget);
    });
  });

  group('Registration', () {
    testWidgets('mismatched passwords are reported', (tester) async {
      await pumpApp(tester);
      await tester.tap(find.text(AppStrings.createAccount));
      await tester.pumpAndSettle();

      await tester.enterText(fieldWithLabel(AppStrings.nameLabel), 'Олена');
      await tester.enterText(
        fieldWithLabel(AppStrings.emailLabel),
        'olena@example.com',
      );
      await tester.enterText(
        fieldWithLabel(AppStrings.passwordLabel),
        'secret123',
      );
      await tester.enterText(
        fieldWithLabel(AppStrings.confirmPasswordLabel),
        'secret124',
      );
      await tester.tap(find.text(AppStrings.register));
      await tester.pump();

      expect(find.text(AppStrings.passwordsDoNotMatch), findsOneWidget);
    });

    testWidgets('new account opens the empty home screen', (tester) async {
      await pumpApp(tester);
      await tester.tap(find.text(AppStrings.createAccount));
      await tester.pumpAndSettle();

      await tester.enterText(
        fieldWithLabel(AppStrings.nameLabel),
        'Олена Коваль',
      );
      await tester.enterText(
        fieldWithLabel(AppStrings.emailLabel),
        'olena@example.com',
      );
      await tester.enterText(
        fieldWithLabel(AppStrings.passwordLabel),
        'secret123',
      );
      await tester.enterText(
        fieldWithLabel(AppStrings.confirmPasswordLabel),
        'secret123',
      );
      await tester.tap(find.text(AppStrings.register));
      await tester.pumpAndSettle();

      expect(find.text(AppStrings.emptyCatalogTitle), findsOneWidget);
      expect(find.text('Олена Коваль'), findsOneWidget);
    });

    testWidgets('already registered e-mail is rejected', (tester) async {
      await pumpApp(tester);
      await tester.tap(find.text(AppStrings.createAccount));
      await tester.pumpAndSettle();

      await tester.enterText(fieldWithLabel(AppStrings.nameLabel), 'Влад');
      await tester.enterText(
        fieldWithLabel(AppStrings.emailLabel),
        MockData.demoEmail,
      );
      await tester.enterText(
        fieldWithLabel(AppStrings.passwordLabel),
        'secret123',
      );
      await tester.enterText(
        fieldWithLabel(AppStrings.confirmPasswordLabel),
        'secret123',
      );
      await tester.tap(find.text(AppStrings.register));
      await tester.pumpAndSettle();

      expect(find.text(AppStrings.emailAlreadyInUse), findsOneWidget);
    });
  });

  testWidgets('password recovery shows the confirmation banner', (
    tester,
  ) async {
    await pumpApp(tester);
    await tester.enterText(
      fieldWithLabel(AppStrings.emailLabel),
      MockData.demoEmail,
    );
    await tester.tap(find.text(AppStrings.forgotPassword));
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.sendResetLink));
    await tester.pumpAndSettle();

    expect(
      find.text(AppStrings.resetEmailSent(MockData.demoEmail)),
      findsOneWidget,
    );
    expect(find.text(AppStrings.resendResetLink), findsOneWidget);

    await tester.tap(find.text(AppStrings.returnToSignIn));
    await tester.pumpAndSettle();
    expect(find.byType(LoginScreen), findsOneWidget);
  });
}
