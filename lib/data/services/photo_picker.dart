import 'package:flutter/foundation.dart';

/// Файл зображення, обраний користувачем.
@immutable
class PickedPhoto {
  const PickedPhoto({required this.name, required this.sizeBytes});

  final String name;
  final int sizeBytes;
}

/// Вибір фото профілю через системне вікно (FR-06).
abstract interface class PhotoPicker {
  /// Повертає обраний файл або `null`, якщо користувач скасував вибір.
  Future<PickedPhoto?> pickImage();
}

/// Заглушка системного вікна вибору файлу: повертає наперед заданий файл.
/// Справжній вибір буде реалізовано через пакет file_picker (NFR-03).
class MockPhotoPicker implements PhotoPicker {
  const MockPhotoPicker({
    this.photo = const PickedPhoto(
      name: 'фото_профілю.heic',
      sizeBytes: 2457600,
    ),
  });

  final PickedPhoto? photo;

  @override
  Future<PickedPhoto?> pickImage() async => photo;
}
