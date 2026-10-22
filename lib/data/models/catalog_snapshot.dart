import 'package:flutter/foundation.dart';

import 'discipline.dart';
import 'study_material.dart';

/// Знімок каталогу користувача: дисципліни, теми й матеріали,
/// потрібні для головного екрана та бічної панелі.
@immutable
class CatalogSnapshot {
  const CatalogSnapshot({
    required this.disciplines,
    required this.topics,
    required this.materials,
  });

  static const empty = CatalogSnapshot(
    disciplines: [],
    topics: [],
    materials: [],
  );

  /// Кількість нещодавніх матеріалів на головному екрані (FR-08).
  static const recentLimit = 10;

  final List<Discipline> disciplines;
  final List<Topic> topics;
  final List<StudyMaterial> materials;

  bool get isEmpty => disciplines.isEmpty;

  int get topicCount =>
      disciplines.fold(0, (sum, discipline) => sum + discipline.topicCount);

  int get materialCount =>
      disciplines.fold(0, (sum, discipline) => sum + discipline.materialCount);

  /// Нещодавно відкриті матеріали, від найновішого.
  List<StudyMaterial> get recent {
    final opened = materials.where((m) => m.lastOpenedAt != null).toList()
      ..sort((a, b) => b.lastOpenedAt!.compareTo(a.lastOpenedAt!));
    return opened.take(recentLimit).toList();
  }

  List<StudyMaterial> get favorites =>
      materials.where((m) => m.isFavorite).toList();

  Discipline? disciplineOf(StudyMaterial material) =>
      disciplines.where((d) => d.id == material.disciplineId).firstOrNull;

  Topic? topicOf(StudyMaterial material) =>
      topics.where((t) => t.id == material.topicId).firstOrNull;

  CatalogSnapshot withFavorite(String materialId, {required bool value}) {
    return CatalogSnapshot(
      disciplines: disciplines,
      topics: topics,
      materials: [
        for (final m in materials)
          m.id == materialId ? m.copyWith(isFavorite: value) : m,
      ],
    );
  }
}
