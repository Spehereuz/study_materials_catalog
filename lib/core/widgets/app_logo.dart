import 'package:flutter/material.dart';

import '../constants/app_assets.dart';
import '../constants/app_spacing.dart';
import '../constants/app_strings.dart';

/// Логотип застосунку — тематичне зображення, підключене в ЛР1.
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = AppSizes.logo});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: AppStrings.appShortTitle,
      image: true,
      excludeSemantics: true,
      child: Image.asset(AppAssets.logo, width: size, height: size),
    );
  }
}
