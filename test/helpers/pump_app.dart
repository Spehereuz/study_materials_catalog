import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:study_materials_catalog/app.dart';
import 'package:study_materials_catalog/data/models/user_profile.dart';
import 'package:study_materials_catalog/data/services/catalog_repository.dart';
import 'package:study_materials_catalog/data/services/mock_auth_service.dart';
import 'package:study_materials_catalog/data/services/photo_picker.dart';

/// Запускає застосунок із заглушками без затримок у вікні [size].
/// Якщо задано [user], сесія вже активна і відкривається головне вікно.
Future<MockAuthService> pumpApp(
  WidgetTester tester, {
  UserProfile? user,
  Size size = const Size(1280, 800),
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  final auth = MockAuthService(latency: Duration.zero, initialUser: user);
  await tester.pumpWidget(
    StudyMaterialsApp(
      auth: auth,
      catalog: MockCatalogRepository(latency: Duration.zero),
      photoPicker: const MockPhotoPicker(),
    ),
  );
  await tester.pumpAndSettle();
  return auth;
}

/// Текстове поле за підписом.
Finder fieldWithLabel(String label) => find.widgetWithText(TextField, label);
