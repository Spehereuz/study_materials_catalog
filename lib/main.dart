import 'package:flutter/material.dart';

import 'app.dart';
import 'data/services/catalog_repository.dart';
import 'data/services/mock_auth_service.dart';
import 'data/services/photo_picker.dart';

void main() {
  runApp(
    StudyMaterialsApp(
      auth: MockAuthService(),
      catalog: MockCatalogRepository(),
      photoPicker: const MockPhotoPicker(),
    ),
  );
}
