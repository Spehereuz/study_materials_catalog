import 'package:flutter/material.dart';

import '../constants/app_strings.dart';
import 'app_text_field.dart';

/// Поле пароля з кнопкою «показати/приховати».
/// Стан видимості зберігається в [State], тому віджет — stateful.
class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.label,
    this.controller,
    this.focusNode,
    this.prefixIcon = Icons.lock_outline,
    this.helperText,
    this.errorText,
    this.textInputAction,
    this.autofillHints,
    this.onChanged,
    this.onSubmitted,
  });

  final String label;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final IconData prefixIcon;
  final String? helperText;
  final String? errorText;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscured = true;

  void _toggleVisibility() => setState(() => _obscured = !_obscured);

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: widget.label,
      controller: widget.controller,
      focusNode: widget.focusNode,
      prefixIcon: widget.prefixIcon,
      helperText: widget.helperText,
      errorText: widget.errorText,
      obscureText: _obscured,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: widget.textInputAction,
      autofillHints: widget.autofillHints,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      trailing: IconButton(
        onPressed: _toggleVisibility,
        tooltip: _obscured ? AppStrings.showPassword : AppStrings.hidePassword,
        icon: Icon(
          _obscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          size: 20,
        ),
      ),
    );
  }
}
