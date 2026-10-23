import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:study_materials_catalog/app.dart';
import 'package:study_materials_catalog/core/constants/app_strings.dart';
import 'package:study_materials_catalog/data/mock/mock_data.dart';
import 'package:study_materials_catalog/data/services/catalog_repository.dart';
import 'package:study_materials_catalog/data/services/mock_auth_service.dart';
import 'package:study_materials_catalog/data/services/photo_picker.dart';

void main() {
  testWidgets('Shell shows sidebar with disciplines of the signed-in user', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      StudyMaterialsApp(
        auth: MockAuthService(
          latency: Duration.zero,
          initialUser: MockData.demoUser,
        ),
        catalog: MockCatalogRepository(latency: Duration.zero),
        photoPicker: const MockPhotoPicker(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.appShortTitle), findsOneWidget);
    expect(find.text(AppStrings.myDisciplines), findsOneWidget);
    expect(find.text('Бази даних'), findsOneWidget);
    expect(find.text(MockData.demoUser.name), findsOneWidget);

    await tester.tap(find.text(AppStrings.navSearch));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.comingSoonSearch), findsOneWidget);
  });
}
