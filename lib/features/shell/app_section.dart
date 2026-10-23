import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';

/// Розділи головного вікна, між якими перемикає бічна панель.
enum AppSection {
  home(AppStrings.navHome, Icons.home_outlined, Icons.home),
  disciplines(AppStrings.navDisciplines, Icons.school_outlined, Icons.school),
  search(AppStrings.navSearch, Icons.search, Icons.search),
  profile(AppStrings.navProfile, Icons.person_outline, Icons.person),
  settings(AppStrings.navSettings, Icons.settings_outlined, Icons.settings);

  const AppSection(this.label, this.icon, this.selectedIcon);

  final String label;
  final IconData icon;
  final IconData selectedIcon;

  /// Пункти основної навігації (профіль і налаштування — внизу панелі).
  static const primary = [home, disciplines, search];
}
