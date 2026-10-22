import 'package:flutter/foundation.dart';

import '../../core/theme/app_colors.dart';

/// Іконки, які користувач може обрати для дисципліни (FR-10).
enum DisciplineIcon {
  code,
  database,
  requirements,
  terminal,
  diagram,
  language,
}

/// Дисципліна — верхній рівень групування матеріалів.
@immutable
class Discipline {
  const Discipline({
    required this.id,
    required this.title,
    required this.teacher,
    required this.semester,
    required this.accent,
    required this.icon,
    required this.topicCount,
    required this.materialCount,
  });

  final String id;
  final String title;
  final String teacher;
  final int semester;
  final AccentColor accent;
  final DisciplineIcon icon;
  final int topicCount;
  final int materialCount;
}

/// Тема в межах дисципліни.
@immutable
class Topic {
  const Topic({
    required this.id,
    required this.disciplineId,
    required this.title,
    required this.order,
  });

  final String id;
  final String disciplineId;
  final String title;
  final int order;
}
