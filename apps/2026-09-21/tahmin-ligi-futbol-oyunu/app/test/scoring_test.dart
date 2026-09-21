// Puanlama motorunun birim testleri (BRIEF.md: "doğru sonuç / doğru skor
// için farklı puan").

import 'package:flutter_test/flutter_test.dart';
import 'package:tahmin_ligi_futbol_oyunu/logic/scoring.dart';
import 'package:tahmin_ligi_futbol_oyunu/models/prediction.dart';

void main() {
  group('calculatePoints', () {
    test('tam skor isabetinde 3 puan verir', () {
      final points = calculatePoints(
        prediction: const Prediction(homeScore: 2, awayScore: 1),
        finalHomeScore: 2,
        finalAwayScore: 1,
      );
      expect(points, exactScorePoints);
      expect(points, 3);
    });

    test('sadece maç sonucu (galibiyet/berabere) tutarsa 1 puan verir', () {
      final points = calculatePoints(
        prediction: const Prediction(homeScore: 3, awayScore: 1),
        finalHomeScore: 1,
        finalAwayScore: 0,
      );
      expect(points, correctOutcomePoints);
      expect(points, 1);
    });

    test('beraberlik doğru tahmin edilirse 1 puan verir (skor farklı)', () {
      final points = calculatePoints(
        prediction: const Prediction(homeScore: 0, awayScore: 0),
        finalHomeScore: 2,
        finalAwayScore: 2,
      );
      expect(points, correctOutcomePoints);
    });

    test('sonuç da skor da tutmazsa 0 puan verir', () {
      final points = calculatePoints(
        prediction: const Prediction(homeScore: 2, awayScore: 0),
        finalHomeScore: 0,
        finalAwayScore: 1,
      );
      expect(points, noMatchPoints);
      expect(points, 0);
    });

    test('outcomeOf doğru sonucu belirler', () {
      expect(outcomeOf(2, 1), MatchOutcome.home);
      expect(outcomeOf(1, 2), MatchOutcome.away);
      expect(outcomeOf(1, 1), MatchOutcome.draw);
    });
  });
}
