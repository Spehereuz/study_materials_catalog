import 'package:flutter/material.dart';

import '../constants/app_spacing.dart';

/// Тема застосунку: Material 3, палітра з базового кольору indigo (NFR-12).
abstract final class AppTheme {
  static const seedColor = Colors.indigo;

  /// Основний колір кнопок і посилань з макетів ЛР2.
  static const _brandPrimary = Color(0xFF4355B9);

  static ThemeData light() => _build(
    ColorScheme.fromSeed(seedColor: seedColor).copyWith(primary: _brandPrimary),
  );

  static ThemeData dark() => _build(
    ColorScheme.fromSeed(seedColor: seedColor, brightness: Brightness.dark),
  );

  static ThemeData _build(ColorScheme scheme) {
    final base = ThemeData(colorScheme: scheme, useMaterial3: true);
    final text = base.textTheme;
    const buttonSize = Size(64, AppSizes.buttonHeight);
    const buttonText = TextStyle(fontSize: 14, fontWeight: FontWeight.w500);

    return base.copyWith(
      scaffoldBackgroundColor: scheme.surfaceContainerLow,
      textTheme: text.copyWith(
        headlineMedium: text.headlineMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: text.headlineSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        titleLarge: text.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        titleMedium: text.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        titleSmall: text.titleSmall?.copyWith(fontWeight: FontWeight.w600),
      ),
      cardTheme: CardThemeData(
        color: scheme.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.large),
          side: BorderSide(color: scheme.outlineVariant),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
        space: 1,
        thickness: 1,
      ),
      inputDecorationTheme: InputDecorationThemeData(
        border: const OutlineInputBorder(),
        isDense: true,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.medium,
          vertical: 14,
        ),
        hintStyle: TextStyle(color: scheme.onSurfaceVariant),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: buttonSize,
          visualDensity: VisualDensity.standard,
          textStyle: buttonText,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: buttonSize,
          visualDensity: VisualDensity.standard,
          textStyle: buttonText,
          side: BorderSide(color: scheme.outline),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(textStyle: buttonText),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        width: 400,
      ),
      tooltipTheme: const TooltipThemeData(
        waitDuration: Duration(milliseconds: 500),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: scheme.surfaceContainerLow,
        indicatorColor: scheme.secondaryContainer,
      ),
    );
  }
}
