import 'package:flutter/material.dart';

enum AppButtonVariant {
  /// Заповнена кнопка основної дії: «Увійти», «Зберегти зміни».
  primary,

  /// Контурна кнопка з основним кольором тексту: «Змінити», «Нова дисципліна».
  secondary,

  /// Контурна кнопка з нейтральним текстом: «Увійти через Apple».
  neutral,

  /// Контурна кнопка небезпечної дії: «Вийти з облікового запису».
  danger,

  /// Текстова кнопка: «Скасувати».
  text,
}

/// Стилізована кнопка з підтримкою іконки, стану завантаження
/// та розтягування на всю ширину.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.expanded = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final AppButtonVariant variant;

  /// Показує індикатор замість тексту і блокує повторні натискання.
  final bool isLoading;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final foreground = switch (variant) {
      AppButtonVariant.primary => colors.onPrimary,
      AppButtonVariant.neutral => colors.onSurface,
      AppButtonVariant.danger => colors.error,
      AppButtonVariant.secondary || AppButtonVariant.text => colors.primary,
    };
    final callback = isLoading ? _ignoreWhileLoading : onPressed;
    final Widget child = isLoading
        ? SizedBox.square(
            dimension: 18,
            child: CircularProgressIndicator(strokeWidth: 2, color: foreground),
          )
        : Text(label, overflow: TextOverflow.ellipsis);
    final iconWidget = icon == null || isLoading ? null : Icon(icon, size: 18);

    final Widget button = switch (variant) {
      AppButtonVariant.primary => FilledButton.icon(
        onPressed: callback,
        icon: iconWidget,
        label: child,
      ),
      AppButtonVariant.text => TextButton.icon(
        onPressed: callback,
        icon: iconWidget,
        label: child,
      ),
      _ => OutlinedButton.icon(
        onPressed: callback,
        icon: iconWidget,
        label: child,
        style: OutlinedButton.styleFrom(foregroundColor: foreground),
      ),
    };

    final semantic = Semantics(
      button: true,
      label: isLoading ? label : null,
      child: button,
    );
    return expanded
        ? SizedBox(width: double.infinity, child: semantic)
        : semantic;
  }

  static void _ignoreWhileLoading() {}
}
