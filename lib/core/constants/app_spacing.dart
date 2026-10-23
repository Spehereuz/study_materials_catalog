/// Відступи інтерфейсу. Основний крок — 8 pt, половинний — 4 pt (NFR-12).
abstract final class AppSpacing {
  static const double tiny = 4;
  static const double small = 8;
  static const double normal = 12;
  static const double medium = 16;
  static const double large = 24;
  static const double xLarge = 32;
  static const double xxLarge = 48;
}

/// Радіуси заокруглення.
abstract final class AppRadius {
  static const double small = 8;
  static const double medium = 12;
  static const double large = 16;
  static const double xLarge = 24;
}

/// Фіксовані розміри елементів, які повторюються в різних екранах.
abstract final class AppSizes {
  static const double buttonHeight = 40;
  static const double headerHeight = 64;
  static const double sidebarWidth = 248;
  static const double authCardMaxWidth = 432;
  static const double contentMaxWidth = 1200;
  static const double iconBox = 36;
  static const double avatarSmall = 32;
  static const double avatarLarge = 96;
  static const double logo = 64;
  static const double logoSmall = 28;
}

/// Межі адаптивних розкладок (NFR-13).
abstract final class AppBreakpoints {
  /// Від цієї ширини — постійна бічна панель з підписами.
  static const double expanded = 840;

  /// Ширина вмісту, від якої блоки «Нещодавні» та «Обране» стоять поруч.
  static const double twoColumnContent = 720;
}
