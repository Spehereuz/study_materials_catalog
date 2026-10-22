import 'package:flutter/material.dart';

import '../constants/app_spacing.dart';

/// Розмітка екранів входу, реєстрації та відновлення пароля:
/// картка по центру вікна з прокручуванням на малих висотах.
class AuthCardLayout extends StatelessWidget {
  const AuthCardLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.large),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppSizes.authCardMaxWidth,
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.large),
                  border: Border.all(color: colors.outlineVariant),
                  boxShadow: [
                    BoxShadow(
                      color: colors.shadow.withValues(alpha: 0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.xLarge),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
