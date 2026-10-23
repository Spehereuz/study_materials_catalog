import 'package:flutter/material.dart';

import '../../app_scope.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_logo.dart';
import '../../core/widgets/app_snack_bar.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/auth_card_layout.dart';
import '../../core/widgets/labeled_divider.dart';
import '../../core/widgets/password_field.dart';
import '../../core/widgets/status_banner.dart';
import '../../data/services/auth_service.dart';
import '../shell/app_shell.dart';
import 'forgot_password_screen.dart';
import 'register_screen.dart';
import 'widgets/auth_switch_prompt.dart';

/// Екран входу S1 (FR-02).
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordFocus = FocusNode();

  String? _emailError;
  String? _passwordError;
  String? _formError;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final emailError = Validators.email(_emailController.text);
    final passwordError = Validators.loginPassword(_passwordController.text);
    setState(() {
      _emailError = emailError;
      _passwordError = passwordError;
      _formError = null;
    });
    if (emailError != null || passwordError != null) return;

    setState(() => _isLoading = true);
    try {
      await AppScope.of(context).auth.signIn(
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
        _formError = AppStrings.invalidCredentials;
        _isLoading = false;
      });
    }
  }

  void _clearErrors() {
    if (_emailError == null && _passwordError == null && _formError == null) {
      return;
    }
    setState(() {
      _emailError = null;
      _passwordError = null;
      _formError = null;
    });
  }

  void _openForgotPassword() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) =>
            ForgotPasswordScreen(initialEmail: _emailController.text.trim()),
      ),
    );
  }

  void _openRegister() {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (_) => const RegisterScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AuthCardLayout(
      child: AutofillGroup(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(child: AppLogo()),
            const SizedBox(height: AppSpacing.medium),
            Text(
              AppStrings.appTitle,
              style: theme.textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.tiny),
            Text(
              AppStrings.appTagline,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.large),
            AppTextField(
              label: AppStrings.emailLabel,
              hint: AppStrings.emailHint,
              controller: _emailController,
              prefixIcon: Icons.mail_outline,
              errorText: _emailError,
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.email],
              onChanged: (_) => _clearErrors(),
              onSubmitted: (_) => _passwordFocus.requestFocus(),
            ),
            const SizedBox(height: AppSpacing.medium),
            PasswordField(
              label: AppStrings.passwordLabel,
              controller: _passwordController,
              focusNode: _passwordFocus,
              errorText: _passwordError,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.password],
              onChanged: (_) => _clearErrors(),
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: AppSpacing.small),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _openForgotPassword,
                child: const Text(AppStrings.forgotPassword),
              ),
            ),
            if (_formError != null) ...[
              const SizedBox(height: AppSpacing.small),
              StatusBanner(message: _formError!),
            ],
            const SizedBox(height: AppSpacing.medium),
            AppButton(
              label: AppStrings.signIn,
              onPressed: _submit,
              isLoading: _isLoading,
              expanded: true,
            ),
            const SizedBox(height: AppSpacing.medium),
            const LabeledDivider(label: AppStrings.or),
            const SizedBox(height: AppSpacing.medium),
            AppButton(
              label: AppStrings.signInWithApple,
              variant: AppButtonVariant.neutral,
              expanded: true,
              onPressed: () =>
                  showAppSnackBar(context, AppStrings.featureInProgress),
            ),
            const SizedBox(height: AppSpacing.medium),
            AuthSwitchPrompt(
              question: AppStrings.noAccount,
              actionLabel: AppStrings.createAccount,
              onPressed: _openRegister,
            ),
          ],
        ),
      ),
    );
  }
}
