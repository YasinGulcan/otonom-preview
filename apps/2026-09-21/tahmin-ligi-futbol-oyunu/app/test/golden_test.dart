import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tahmin_ligi_futbol_oyunu/main.dart';

void main() {
  testWidgets('Ana ekran altın test (golden)', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2160);
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const TahminLigiApp());
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(TahminLigiApp),
      matchesGoldenFile('home_screen.png'),
    );
  });
}
