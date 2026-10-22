import '../../core/theme/app_colors.dart';
import '../models/catalog_snapshot.dart';
import '../models/discipline.dart';
import '../models/study_material.dart';
import '../models/user_profile.dart';

/// Hardcoded-дані для екранів без бізнес-логіки. Відповідають макетам ЛР2.
abstract final class MockData {
  static const demoUserId = 'demo-user';
  static const demoEmail = 'vlad@example.com';
  static const demoPassword = 'student2026';

  static final demoUser = UserProfile(
    id: demoUserId,
    name: 'Владислав Гардецький',
    email: demoEmail,
    institution: 'Національний університет «Львівська політехніка»',
    group: 'ПЗ-32',
    passwordChangedAt: DateTime(2026, 9, 14),
  );

  static const disciplines = [
    Discipline(
      id: 'd-cross-platform',
      title: 'Кросплатформне програмування',
      teacher: 'Іваненко О. П.',
      semester: 5,
      accent: AccentColor.indigo,
      icon: DisciplineIcon.code,
      topicCount: 6,
      materialCount: 21,
    ),
    Discipline(
      id: 'd-databases',
      title: 'Бази даних',
      teacher: 'Коваленко С. М.',
      semester: 5,
      accent: AccentColor.teal,
      icon: DisciplineIcon.database,
      topicCount: 4,
      materialCount: 15,
    ),
    Discipline(
      id: 'd-requirements',
      title: 'Аналіз вимог до ПЗ',
      teacher: 'Шевченко Н. В.',
      semester: 5,
      accent: AccentColor.red,
      icon: DisciplineIcon.requirements,
      topicCount: 5,
      materialCount: 16,
    ),
    Discipline(
      id: 'd-os',
      title: 'Операційні системи',
      teacher: 'Бондар І. В.',
      semester: 5,
      accent: AccentColor.olive,
      icon: DisciplineIcon.terminal,
      topicCount: 3,
      materialCount: 11,
    ),
    Discipline(
      id: 'd-modeling',
      title: 'Моделювання та аналіз ПЗ',
      teacher: 'Мельник Т. Г.',
      semester: 5,
      accent: AccentColor.purple,
      icon: DisciplineIcon.diagram,
      topicCount: 4,
      materialCount: 12,
    ),
    Discipline(
      id: 'd-english',
      title: 'Англійська мова (за професійним спрямуванням)',
      teacher: 'Ковальчук Л. М.',
      semester: 5,
      accent: AccentColor.orange,
      icon: DisciplineIcon.language,
      topicCount: 2,
      materialCount: 8,
    ),
  ];

  static const topics = [
    Topic(
      id: 't-flutter-basics',
      disciplineId: 'd-cross-platform',
      title: 'Основи Flutter',
      order: 1,
    ),
    Topic(
      id: 't-labs',
      disciplineId: 'd-cross-platform',
      title: 'Лабораторні роботи',
      order: 2,
    ),
    Topic(
      id: 't-db-design',
      disciplineId: 'd-databases',
      title: 'Проєктування БД',
      order: 1,
    ),
    Topic(id: 't-sql', disciplineId: 'd-databases', title: 'SQL', order: 2),
  ];

  /// Матеріали з датами відносно [now], щоб блок «Нещодавні» виглядав
  /// так само, як на макеті, незалежно від дня запуску.
  static List<StudyMaterial> materials(DateTime now) {
    final yesterday = DateTime(now.year, now.month, now.day - 1, 16, 20);
    return [
      StudyMaterial(
        id: 'm-widgets-lecture',
        disciplineId: 'd-cross-platform',
        topicId: 't-flutter-basics',
        type: StudyMaterialType.note,
        title: 'Лекція 3. Віджети у Flutter',
        updatedAt: now.subtract(const Duration(minutes: 30)),
        lastOpenedAt: now.subtract(const Duration(minutes: 30)),
        isFavorite: true,
      ),
      StudyMaterial(
        id: 'm-lab2-guide',
        disciplineId: 'd-cross-platform',
        topicId: 't-labs',
        type: StudyMaterialType.file,
        title: 'Методичка ЛР2.pdf',
        updatedAt: yesterday,
        lastOpenedAt: yesterday,
      ),
      StudyMaterial(
        id: 'm-normalization',
        disciplineId: 'd-databases',
        topicId: 't-db-design',
        type: StudyMaterialType.note,
        title: 'Нормалізація: 1НФ–3НФ',
        updatedAt: DateTime(2026, 9, 29, 18, 5),
        lastOpenedAt: DateTime(2026, 9, 29, 18, 5),
        isFavorite: true,
      ),
      StudyMaterial(
        id: 'm-flutter-layout',
        disciplineId: 'd-cross-platform',
        topicId: 't-flutter-basics',
        type: StudyMaterialType.link,
        title: 'Документація Flutter: Layout',
        updatedAt: DateTime(2026, 9, 26, 12, 40),
        lastOpenedAt: DateTime(2026, 9, 26, 12, 40),
      ),
      StudyMaterial(
        id: 'm-sql-cheatsheet',
        disciplineId: 'd-databases',
        topicId: 't-sql',
        type: StudyMaterialType.link,
        title: 'Шпаргалка з SQL-запитів',
        updatedAt: DateTime(2026, 9, 20, 9, 15),
        isFavorite: true,
      ),
    ];
  }

  static CatalogSnapshot catalog(DateTime now) => CatalogSnapshot(
    disciplines: disciplines,
    topics: topics,
    materials: materials(now),
  );
}
