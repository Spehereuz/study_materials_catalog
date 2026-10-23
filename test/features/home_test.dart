import 'package:flutter_test/flutter_test.dart';

import 'package:study_materials_catalog/core/constants/app_strings.dart';
import 'package:study_materials_catalog/data/mock/mock_data.dart';

import '../helpers/pump_app.dart';

void main() {
  testWidgets('shows greeting, summary, recent, favorites and disciplines', (
    tester,
  ) async {
    await pumpApp(tester, user: MockData.demoUser);

    expect(find.text('Вітаємо, Владиславе!'), findsOneWidget);
    expect(find.text('6 дисциплін, 24 теми, 83 матеріали'), findsOneWidget);
    expect(find.text(AppStrings.recentMaterials), findsOneWidget);
    expect(find.text(AppStrings.favorites), findsOneWidget);
    expect(
      find.text('Кросплатформне програмування › Основи Flutter'),
      findsNWidgets(2),
    );
    expect(find.text('6 тем, 21 матеріал'), findsOneWidget);
    expect(find.text('2 теми, 8 матеріалів'), findsOneWidget);
  });

  testWidgets('star adds a recent material to favorites', (tester) async {
    await pumpApp(tester, user: MockData.demoUser);
    expect(find.text('Методичка ЛР2.pdf'), findsOneWidget);

    await tester.tap(find.byTooltip(AppStrings.addToFavorites).first);
    await tester.pumpAndSettle();

    expect(find.text('Методичка ЛР2.pdf'), findsNWidgets(2));
  });

  testWidgets('quick actions show a hint instead of opening a form', (
    tester,
  ) async {
    await pumpApp(tester, user: MockData.demoUser);

    await tester.tap(find.text(AppStrings.newMaterial));
    await tester.pump();

    expect(find.text(AppStrings.featureInProgress), findsOneWidget);
  });
}
