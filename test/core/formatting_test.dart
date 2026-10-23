import 'package:flutter_test/flutter_test.dart';

import 'package:study_materials_catalog/core/utils/date_formatter.dart';
import 'package:study_materials_catalog/core/utils/uk_grammar.dart';

void main() {
  group('UkGrammar.count', () {
    String materials(int n) =>
        UkGrammar.count(n, 'матеріал', 'матеріали', 'матеріалів');

    test('uses the correct plural form', () {
      expect(materials(1), '1 матеріал');
      expect(materials(21), '21 матеріал');
      expect(materials(3), '3 матеріали');
      expect(materials(83), '83 матеріали');
      expect(materials(0), '0 матеріалів');
      expect(materials(11), '11 матеріалів');
      expect(materials(14), '14 матеріалів');
      expect(materials(25), '25 матеріалів');
    });
  });

  test('UkGrammar.vocative builds the address form', () {
    expect(UkGrammar.vocative('Владислав'), 'Владиславе');
    expect(UkGrammar.vocative('Андрій'), 'Андрію');
    expect(UkGrammar.vocative('Олена'), 'Олено');
    expect(UkGrammar.vocative('Марія'), 'Маріє');
    expect(UkGrammar.vocative('Петро'), 'Петре');
    expect(UkGrammar.vocative('Олег'), 'Олеже');
  });

  group('DateFormatter.relative', () {
    final now = DateTime(2026, 10, 23, 18);

    test('shows today and yesterday with time', () {
      expect(
        DateFormatter.relative(DateTime(2026, 10, 23, 10, 45), now: now),
        'Сьогодні, 10:45',
      );
      expect(
        DateFormatter.relative(DateTime(2026, 10, 22, 16, 20), now: now),
        'Вчора, 16:20',
      );
    });

    test('omits the year for the current year', () {
      expect(
        DateFormatter.relative(DateTime(2026, 9, 29), now: now),
        '29 вер.',
      );
      expect(
        DateFormatter.relative(DateTime(2025, 9, 14), now: now),
        '14 вер. 2025',
      );
    });
  });
}
