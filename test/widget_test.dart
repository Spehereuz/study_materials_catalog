import 'package:flutter_test/flutter_test.dart';

import 'package:study_materials_catalog/main.dart';

void main() {
  testWidgets('Home screen shows app title and description', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Каталог навчальних матеріалів'), findsOneWidget);
    expect(
      find.text('Конспекти, посилання та файли за дисциплінами й темами'),
      findsOneWidget,
    );
  });
}
