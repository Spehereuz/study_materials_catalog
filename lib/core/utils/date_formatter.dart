/// Форматування дат українською без сторонніх пакетів.
abstract final class DateFormatter {
  static const _months = [
    'січ.',
    'лют.',
    'бер.',
    'квіт.',
    'трав.',
    'черв.',
    'лип.',
    'серп.',
    'вер.',
    'жовт.',
    'лист.',
    'груд.',
  ];

  /// Коротка відносна дата для списків: «Сьогодні, 10:45», «Вчора, 16:20»,
  /// «29 вер.» (поточний рік) або «29 вер. 2025».
  static String relative(DateTime date, {DateTime? now}) {
    final current = now ?? DateTime.now();
    final days = _dateOnly(current).difference(_dateOnly(date)).inDays;
    if (days == 0) return 'Сьогодні, ${time(date)}';
    if (days == 1) return 'Вчора, ${time(date)}';
    if (date.year == current.year) {
      return '${date.day} ${_months[date.month - 1]}';
    }
    return full(date);
  }

  /// Повна дата: «14 вер. 2026».
  static String full(DateTime date) =>
      '${date.day} ${_months[date.month - 1]} ${date.year}';

  /// Час у форматі «10:45».
  static String time(DateTime date) =>
      '${_twoDigits(date.hour)}:${_twoDigits(date.minute)}';

  static DateTime _dateOnly(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  static String _twoDigits(int value) => value.toString().padLeft(2, '0');
}
