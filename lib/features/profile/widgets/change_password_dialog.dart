import 'package:flutter/material.dart';

import '../../../app_scope.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/password_field.dart';
import '../../../data/services/auth_service.dart';

/// Відкриває діалог зміни пароля S11. Повертає `true`, якщо пароль змінено.
Future<bool> showChangePasswordDialog(BuildContext context) async {
  final changed = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (_) => const ChangePasswordDialog(),
  );
  return changed ?? false;
}

/// Форма зміни пароля з підтвердженням поточного (FR-07).
class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({super.key});

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  String? _currentError;
  String? _newError;
  String? _confirmError;
  bool _isLoading = false;

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  String? _validateNewPassword() {
    final error = Validators.newPassword(_newController.text);
    if (error != null) return error;
    if (_newController.text == _currentController.text) {
      return AppStrings.samePassword;
    }
    return null;
  }

  Future<void> _submit() async {
    setState(() {
      _currentError = _currentController.text.isEmpty
          ? AppStrings.currentPasswordRequired
          : null;
      _newError = _validateNewPassword();
      _confirmError = Validators.confirmPassword(
        _confirmController.text,
        _newController.text,
      );
    });
    if (_currentError != null || _newError != null || _confirmError != null) {
      return;
    }

    setState(() => _isLoading = true);
    try {
      await AppScope.of(context).auth.changePassword(
        currentPassword: _currentController.text,
        newPassword: _newController.text,
      );
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } on AuthException {
      if (!mounted) return;
      setState(() {
        _currentError = AppStrings.wrongCurrentPassword;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      scrollable: true,
      title: const Text(AppStrings.changePasswordTitle),
      content: SizedBox(
        width: 440,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppStrings.changePasswordSubtitle,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.large),
            PasswordField(
              label: AppStrings.currentPasswordLabel,
              controller: _currentController,
              errorText: _currentError,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.password],
              onChanged: (_) => setState(() => _currentError = null),
            ),
            const SizedBox(height: AppSpacing.medium),
            PasswordField(
              label: AppStrings.newPasswordLabel,
              controller: _newController,
              prefixIcon: Icons.key_outlined,
              helperText: AppStrings.passwordRules,
              errorText: _newError,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.newPassword],
              onChanged: (_) => setState(() => _newError = null),
            ),
            const SizedBox(height: AppSpacing.medium),
            PasswordField(
              label: AppStrings.confirmNewPasswordLabel,
              controller: _confirmController,
              prefixIcon: Icons.key_outlined,
              errorText: _confirmError,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.newPassword],
              onChanged: (_) => setState(() => _confirmError = null),
              onSubmitted: (_) => _submit(),
            ),
          ],
        ),
      ),
      actions: [
        AppButton(
          label: AppStrings.cancel,
          variant: AppButtonVariant.text,
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(false),
        ),
        AppButton(
          label: AppStrings.changePasswordAction,
          onPressed: _submit,
          isLoading: _isLoading,
        ),
      ],
    );
  }
}
