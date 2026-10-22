import 'package:flutter/foundation.dart';

/// Тип матеріалу: конспект, посилання або файл.
enum StudyMaterialType { note, link, file }

/// Матеріал — основна одиниця навчального вмісту.
@immutable
class StudyMaterial {
  const StudyMaterial({
    required this.id,
    required this.disciplineId,
    required this.topicId,
    required this.type,
    required this.title,
    required this.updatedAt,
    this.lastOpenedAt,
    this.isFavorite = false,
  });

  final String id;
  final String disciplineId;
  final String topicId;
  final StudyMaterialType type;
  final String title;
  final DateTime updatedAt;
  final DateTime? lastOpenedAt;
  final bool isFavorite;

  StudyMaterial copyWith({bool? isFavorite}) {
    return StudyMaterial(
      id: id,
      disciplineId: disciplineId,
      topicId: topicId,
      type: type,
      title: title,
      updatedAt: updatedAt,
      lastOpenedAt: lastOpenedAt,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
