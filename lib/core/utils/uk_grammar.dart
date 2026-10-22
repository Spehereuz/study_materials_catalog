/// Узгодження українських слів з числівниками та кличний відмінок імен.
abstract final class UkGrammar {
  /// Повертає форму слова для числа [count]:
  /// [one] — 1, 21, 31…; [few] — 2–4, 22–24…; [many] — 0, 5–20, 25–30…
  static String plural(int count, String one, String few, String many) {
    final n = count.abs();
    final mod10 = n % 10;
    final mod100 = n % 100;
    if (mod10 == 1 && mod100 != 11) return one;
    if (mod10 >= 2 && mod10 <= 4 && (mod100 < 12 || mod100 > 14)) return few;
    return many;
  }

  /// Число разом з узгодженим словом: «1 матеріал», «3 матеріали», «5 матеріалів».
  static String count(int count, String one, String few, String many) =>
      '$count ${plural(count, one, few, many)}';

  /// Кличний відмінок імені для звертання: «Владислав» → «Владиславе».
  static String vocative(String name) {
    final word = name.trim();
    if (word.length < 2) return word;

    final lower = word.toLowerCase();
    final stem = word.substring(0, word.length - 1);
    final last = lower[lower.length - 1];

    if (lower.endsWith('ія')) return '${word.substring(0, word.length - 2)}іє';
    if (lower.endsWith('я')) return '$stemе';
    if (last == 'а') return '$stemо';
    if (last == 'о') return '$stemе';
    if (last == 'й' || last == 'ь') return '$stemю';
    if (last == 'г') return '$stemже';
    if (last == 'к') return '$stemче';
    if (_vowels.contains(last)) return word;
    return '$wordе';
  }

  static const _vowels = 'аеєиіїоуюя';
}
