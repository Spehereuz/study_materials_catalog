import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_strings.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/page_header.dart';

/// Заглушка розділу, який буде реалізовано в наступних роботах.
class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({
    super.key,
    required this.title,
    required this.icon,
    required this.message,
  });

  final String title;
  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PageHeader(title: title),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.large),
            child: EmptyState(
              icon: icon,
              title: AppStrings.comingSoonTitle,
              message: message,
            ),
          ),
        ),
      ],
    );
  }
}
