import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:study_materials_catalog/core/constants/app_strings.dart';
import 'package:study_materials_catalog/data/mock/mock_data.dart';
import 'package:study_materials_catalog/features/shell/widgets/app_sidebar.dart';

import '../helpers/pump_app.dart';

void main() {
  testWidgets('wide window shows the sidebar with disciplines', (tester) async {
    await pumpApp(tester, user: MockData.demoUser);

    expect(find.byType(AppSidebar), findsOneWidget);
    expect(find.byType(NavigationRail), findsNothing);
    expect(find.text(AppStrings.appShortTitle), findsOneWidget);
    expect(find.text(AppStrings.myDisciplines), findsNWidgets(2));
    expect(find.text(MockData.demoUser.name), findsOneWidget);
    expect(find.text(MockData.demoUser.email), findsOneWidget);
  });

  testWidgets('compact window shows the navigation rail', (tester) async {
    await pumpApp(tester, user: MockData.demoUser, size: const Size(700, 600));

    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.byType(AppSidebar), findsNothing);
  });

  testWidgets('sidebar switches sections without pushing routes', (
    tester,
  ) async {
    await pumpApp(tester, user: MockData.demoUser);

    await tester.tap(find.text(AppStrings.navSearch));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.comingSoonSearch), findsOneWidget);

    await tester.tap(find.text(AppStrings.navHome));
    await tester.pumpAndSettle();
    expect(find.text('Вітаємо, Владиславе!'), findsOneWidget);
    expect(
      Navigator.of(tester.element(find.byType(AppSidebar))).canPop(),
      isFalse,
    );
  });
}
