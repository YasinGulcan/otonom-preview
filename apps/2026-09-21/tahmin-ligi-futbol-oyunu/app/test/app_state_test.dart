// AppState (tahmin kilitleme, puanlama toplamı, mini lig oluşturma/katılma)
// için birim testleri. Deterministik sonuç için sabit bir `now` verilir.

import 'package:flutter_test/flutter_test.dart';
import 'package:tahmin_ligi_futbol_oyunu/state/app_state.dart';

void main() {
  DateTime fixedNow() => DateTime(2026, 9, 21, 12, 0, 0);

  group('Tahmin kilitleme', () {
    test('maç başladıysa tahmin girişi kilitli olmalı', () {
      final state = AppState(now: fixedNow());
      final match = state.fixtures.firstWhere((m) => m.id == 'w5-1');

      expect(state.isLocked(match), isTrue);
      expect(state.canEnterPrediction(match), isFalse);
    });

    test('kilitli maça tahmin gönderilemez', () {
      final state = AppState(now: fixedNow());
      final result = state.submitPrediction('w5-1', 1, 1);

      expect(result, isFalse);
      expect(state.predictionFor('w5-1'), isNull);
    });

    test('henüz başlamamış maça tahmin girilip kaydedilebilir', () {
      final state = AppState(now: fixedNow());
      final match = state.fixtures.firstWhere((m) => m.id == 'w5-2');

      expect(state.canEnterPrediction(match), isTrue);
      final result = state.submitPrediction('w5-2', 2, 0);

      expect(result, isTrue);
      expect(state.predictionFor('w5-2')?.homeScore, 2);
      expect(state.predictionFor('w5-2')?.awayScore, 0);
      // Tahmin girildikten sonra, reklam hakkı açılmadan tekrar giriş yapılamaz.
      expect(state.canEnterPrediction(match), isFalse);
    });

    test('ödüllü reklam izlendikten sonra tahmin tekrar değiştirilebilir',
        () async {
      final state = AppState(now: fixedNow());
      final match = state.fixtures.firstWhere((m) => m.id == 'w5-2');
      state.submitPrediction('w5-2', 1, 1);
      expect(state.canEnterPrediction(match), isFalse);

      await state.watchRewardedAdToUnlockEdit('w5-2');

      expect(state.canEnterPrediction(match), isTrue);
      final result = state.submitPrediction('w5-2', 3, 0);
      expect(result, isTrue);
      expect(state.predictionFor('w5-2')?.homeScore, 3);
    });
  });

  group('Puanlama toplamları', () {
    test('4. hafta seed tahminlerinden doğru toplam puan hesaplanır', () {
      final state = AppState(now: fixedNow());
      // w4-1: tam isabet (3) + w4-2: yanlış (0) + w4-3: tam isabet (3) = 6
      expect(state.weeklyPointsFor(4), 6);
    });

    test('sezon puanı, henüz oynanmamış hafta 5 hariç sadece bitmiş maçları içerir',
        () {
      final state = AppState(now: fixedNow());
      expect(state.seasonPoints, state.weeklyPointsFor(4));
    });

    test('liderlik tablosunda kullanıcı "Sen" olarak yer alır', () {
      final state = AppState(now: fixedNow());
      final entries = state.leaderboard(weekly: false);
      final you = entries.firstWhere((e) => e.isCurrentUser);
      expect(you.points, state.seasonPoints);
    });
  });

  group('Mini ligler', () {
    test('yeni mini lig oluşturma listeye eklenir ve davet kodu üretilir', () {
      final state = AppState(now: fixedNow());
      final initialCount = state.miniLeagues.length;

      final league = state.createMiniLeague('Ofis Ligi');

      expect(state.miniLeagues.length, initialCount + 1);
      expect(league.name, 'Ofis Ligi');
      expect(league.inviteCode.length, 6);
    });

    test('davet koduyla katılma yeni bir mini lig oluşturur', () {
      final state = AppState(now: fixedNow());
      final initialCount = state.miniLeagues.length;

      final league = state.joinMiniLeagueByCode('xyz999');

      expect(state.miniLeagues.length, initialCount + 1);
      expect(league.inviteCode, 'XYZ999');
      expect(league.members, contains('Sen'));
    });

    test('mevcut davet koduyla tekrar katılma yeni kayıt eklemez', () {
      final state = AppState(now: fixedNow());
      final initialCount = state.miniLeagues.length;

      state.joinMiniLeagueByCode('TL482K'); // seed lig koduyla aynı

      expect(state.miniLeagues.length, initialCount);
    });
  });
}
