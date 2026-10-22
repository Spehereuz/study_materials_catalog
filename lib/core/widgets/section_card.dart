import 'package:flutter/material.dart';

import '../constants/app_spacing.dart';

/// Картка-секція із заголовком і необов'язковою дією праворуч:
/// «Нещодавні матеріали», «Обране», «Дані профілю», «Безпека».
class SectionCard extends StatelessWidget {
  const SectionCard({
    super.key,
    required this.child,
    this.title,
    this.trailing,
    this.padding = const EdgeInsets.all(AppSpacing.large),
  });

  final Widget child;
  final String? title;
  final Widget? trailing;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (title != null) ...[
              SizedBox(
                height: AppSizes.buttonHeight,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title!,
                        style: Theme.of(context).textTheme.titleMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    ?trailing,
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.small),
            ],
            child,
          ],
        ),
      ),
    );
  }
}
