import 'package:flutter/material.dart';

import '../../app_scope.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/auth_card_layout.dart';
import '../../core/widgets/password_field.dart';
import '../../data/services/auth_service.dart';
import '../shell/app_shell.dart';
import 'widgets/auth_switch_prompt.dart';

/// Екран реєстрації S2 (FR-01).
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmError;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _nameError = Validators.name(_nameController.text);
      _emailError = Validators.email(_emailController.text);
      _passwordError = Validators.newPassword(_passwordController.text);
      _confirmError = Validators.confirmPassword(
        _confirmController.text,
        _passwordController.text,
      );
    });
    final hasErrors = [
      _nameError,
      _emailError,
      _passwordError,
      _confirmError,
    ].any((error) => error != null);
    if (hasErrors) return;

    setState(() => _isLoading = true);
    try {
      await AppScope.of(context).auth.register(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(builder: (_) => const AppShell()),
        (_) => false,
      );
    } on AuthException {
      if (!mounted) return;
      setState(() {
        _emailError = AppStrings.emailAlreadyInUse;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AuthCardLayout(
      child: AutofillGroup(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back, size: 18),
                label: const Text(AppStrings.backToSignIn),
              ),
            ),
            const SizedBox(height: AppSpacing.small),
            Text(
              AppStrings.registerTitle,
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.tiny),
            Text(
              AppStrings.registerSubtitle,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.large),
            AppTextField(
              label: AppStrings.nameLabel,
              controller: _nameController,
              prefixIcon: Icons.person_outline,
              errorText: _nameError,
              autofocus: true,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.name],
              onChanged: (_) => setState(() => _nameError = null),
            ),
            const SizedBox(height: AppSpacing.medium),
            AppTextField(
              label: AppStrings.emailLabel,
              hint: AppStrings.emailHint,
              controller: _emailController,
              prefixIcon: Icons.mail_outline,
              errorText: _emailError,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.email],
              onChanged: (_) => setState(() => _emailError = null),
            ),
            const SizedBox(height: AppSpacing.medium),
            PasswordField(
              label: AppStrings.passwordLabel,
              controller: _passwordController,
              helperText: AppStrings.passwordRules,
              errorText: _passwordError,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.newPassword],
              onChanged: (_) => setState(() => _passwordError = null),
            ),
            const SizedBox(height: AppSpacing.medium),
            PasswordField(
              label: AppStrings.confirmPasswordLabel,
              controller: _confirmController,
              errorText: _confirmError,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.newPassword],
              onChanged: (_) => setState(() => _confirmError = null),
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: AppSpacing.large),
            AppButton(
              label: AppStrings.register,
              onPressed: _submit,
              isLoading: _isLoading,
              expanded: true,
            ),
            const SizedBox(height: AppSpacing.medium),
            AuthSwitchPrompt(
              question: AppStrings.haveAccount,
              actionLabel: AppStrings.signIn,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
