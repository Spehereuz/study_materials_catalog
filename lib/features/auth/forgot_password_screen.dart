import 'package:flutter/material.dart';

import '../../app_scope.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/auth_card_layout.dart';
import '../../core/widgets/icon_badge.dart';
import '../../core/widgets/status_banner.dart';

/// Екран відновлення пароля S3 (FR-03).
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key, this.initialEmail = ''});

  /// Пошта, вже введена на екрані входу.
  final String initialEmail;

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late final _emailController = TextEditingController(
    text: widget.initialEmail,
  );

  String? _emailError;
  String? _sentTo;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final error = Validators.email(_emailController.text);
    setState(() => _emailError = error);
    if (error != null) return;

    final email = _emailController.text.trim();
    setState(() => _isLoading = true);
    await AppScope.of(context).auth.sendPasswordReset(email);
    if (!mounted) return;
    setState(() {
      _sentTo = email;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AuthCardLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(child: IconBadge(icon: Icons.lock_reset, size: 64)),
          const SizedBox(height: AppSpacing.medium),
          Text(
            AppStrings.resetTitle,
            style: theme.textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.tiny),
          Text(
            AppStrings.resetSubtitle,
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
            textInputAction: TextInputAction.send,
            autofillHints: const [AutofillHints.email],
            onChanged: (_) => setState(() => _emailError = null),
            onSubmitted: (_) => _submit(),
          ),
          if (_sentTo != null) ...[
            const SizedBox(height: AppSpacing.medium),
            StatusBanner(
              type: StatusBannerType.success,
              message: AppStrings.resetEmailSent(_sentTo!),
            ),
          ],
          const SizedBox(height: AppSpacing.medium),
          AppButton(
            label: _sentTo == null
                ? AppStrings.sendResetLink
                : AppStrings.resendResetLink,
            icon: Icons.send_outlined,
            onPressed: _submit,
            isLoading: _isLoading,
            expanded: true,
          ),
          const SizedBox(height: AppSpacing.medium),
          Center(
            child: TextButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back, size: 18),
              label: const Text(AppStrings.returnToSignIn),
            ),
          ),
        ],
      ),
    );
  }
}
