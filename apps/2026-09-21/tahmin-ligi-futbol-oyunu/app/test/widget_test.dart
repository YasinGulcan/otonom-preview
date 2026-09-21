// Ana ekranın (BRIEF.md gereği yerel state ile) doğru render olduğunu
// ve temel tab gezinmesini doğrulayan widget testleri.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tahmin_ligi_futbol_oyunu/main.dart';

void main() {
  testWidgets('Ana ekran fikstür sekmesiyle açılır ve maçları listeler',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TahminLigiApp());
    await tester.pumpAndSettle();

    expect(find.text('Tahmin Ligi'), findsOneWidget);
    // Hafta 5 güncel hafta olmalı ve en üstte (ilk görünen) olarak listelenmeli.
    expect(find.text('Hafta 5'), findsOneWidget);
    // Güncel haftanın ilk (kilitli) maçı görünür olmalı.
    expect(find.textContaining('Fenerbahçe - Beşiktaş'), findsOneWidget);
    expect(find.text('Kilitli'), findsOneWidget);
  });

  testWidgets('Alt gezinme lig tablosu ve mini ligler sekmelerine geçer',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TahminLigiApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Lig Tablosu'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('leaderboard-list')), findsOneWidget);
    // Kullanıcı satırı "Sen" olarak listede yer almalı.
    expect(find.text('Sen'), findsOneWidget);

    await tester.tap(find.text('Mini Ligler'));
    await tester.pumpAndSettle();
    expect(find.text('Mahalle Ligi'), findsOneWidget);
  });

  testWidgets('Dil değiştirme butonu arayüzü İngilizce\'ye çevirir',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TahminLigiApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.translate));
    await tester.pumpAndSettle();

    expect(find.text('Prediction League'), findsOneWidget);
    expect(find.text('Fixtures'), findsOneWidget);
  });
}
