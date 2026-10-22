import 'package:flutter/material.dart';

/// Пара кольорів акценту: для іконки чи маркера і для фону під ними.
typedef AccentPair = ({Color foreground, Color container});

/// Акцентні кольори дисциплін і типів матеріалів (див. макети ЛР2).
enum AccentColor {
  indigo(Color(0xFF394DBE), Color(0xFFDDE1FE), Color(0xFFBBC3FF)),
  teal(Color(0xFF006C72), Color(0xFFC9EDED), Color(0xFF83D3DA)),
  red(Color(0xFFB82C2B), Color(0xFFFCDCD7), Color(0xFFFFB3AC)),
  olive(Color(0xFF3A5700), Color(0xFFDAEBB4), Color(0xFFAED372)),
  purple(Color(0xFF7054A9), Color(0xFFEADDFF), Color(0xFFD2BBFF)),
  orange(Color(0xFF914F00), Color(0xFFFFDDB8), Color(0xFFFFB77A));

  const AccentColor(this._light, this._lightContainer, this._dark);

  final Color _light;
  final Color _lightContainer;
  final Color _dark;

  /// Кольори акценту для поточної теми.
  AccentPair resolve(ColorScheme scheme) {
    if (scheme.brightness == Brightness.light) {
      return (foreground: _light, container: _lightContainer);
    }
    return (
      foreground: _dark,
      container: Color.alphaBlend(
        _dark.withValues(alpha: 0.18),
        scheme.surface,
      ),
    );
  }
}

abstract final class AppColors {
  /// Колір зірки «Обране».
  static const favorite = Color(0xFFEBA100);
}
