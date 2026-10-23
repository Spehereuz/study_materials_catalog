import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/discipline_card.dart';
import '../../../data/models/discipline.dart';

/// Сітка карток дисциплін: кількість колонок залежить від ширини вікна.
class DisciplinesGrid extends StatelessWidget {
  const DisciplinesGrid({
    super.key,
    required this.disciplines,
    required this.onOpen,
  });

  static const _minCardWidth = 200.0;
  static const _maxColumns = 4;

  final List<Discipline> disciplines;
  final ValueChanged<Discipline> onOpen;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = AppSpacing.medium;
        final fitting = ((constraints.maxWidth + gap) / (_minCardWidth + gap))
            .floor();
        final columns = math.max(1, math.min(_maxColumns, fitting));
        final cardWidth =
            ((constraints.maxWidth - gap * (columns - 1)) / columns)
                .floorToDouble();

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final discipline in disciplines)
              SizedBox(
                width: cardWidth,
                child: DisciplineCard(
                  discipline: discipline,
                  onTap: () => onOpen(discipline),
                ),
              ),
          ],
        );
      },
    );
  }
}
