import 'package:flutter/material.dart';

/// Стилізоване текстове поле: підпис над рамкою, іконка зліва,
/// підказка або помилка під полем та іконка помилки справа (макети ЛР2).
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.label,
    this.controller,
    this.focusNode,
    this.hint,
    this.prefixIcon,
    this.trailing,
    this.helperText,
    this.errorText,
    this.obscureText = false,
    this.readOnly = false,
    this.autofocus = false,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.onChanged,
    this.onSubmitted,
  });

  final String label;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hint;
  final IconData? prefixIcon;

  /// Додаткова кнопка в кінці поля, наприклад перемикач видимості пароля.
  final Widget? trailing;
  final String? helperText;
  final String? errorText;
  final bool obscureText;
  final bool readOnly;
  final bool autofocus;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final hasError = errorText != null;

    return TextField(
      controller: controller,
      focusNode: focusNode,
      autofocus: autofocus,
      readOnly: readOnly,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      autofillHints: autofillHints,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        helperText: helperText,
        errorText: errorText,
        prefixIcon: prefixIcon == null ? null : Icon(prefixIcon, size: 20),
        suffixIcon: trailing == null && !hasError
            ? null
            : Padding(
                padding: const EdgeInsetsDirectional.only(end: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ?trailing,
                    if (hasError)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(
                          Icons.error_outline,
                          size: 20,
                          color: colors.error,
                        ),
                      ),
                  ],
                ),
              ),
      ),
    );
  }
}
