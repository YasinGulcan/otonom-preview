import 'dart:math';
import 'package:flutter/material.dart';

import '../data/fixtures_data.dart';
import '../l10n/strings.dart';
import '../logic/scoring.dart';
import '../models/leaderboard_entry.dart';
import '../models/match_fixture.dart';
import '../models/mini_league.dart';
import '../models/prediction.dart';

/// Uygulamanın tek paylaşılan durum kaynağı (provider ile sağlanır).
///
/// MVP'de gerçek bir backend olmadığı için tüm veri (tahminler, mini
/// ligler, dil tercihi) yalnızca bellek içi (in-memory) state olarak
/// tutulur; bu, BRIEF'te tarif edilen "yerel state ile render" gereğini
/// karşılar ve QA'nın golden-test alacağı ana ekranı ağ bağımlılığı
/// olmadan güvenilir şekilde üretir.
class AppState extends ChangeNotifier {
  AppState({DateTime? now, Random? random})
      : _now = now ?? DateTime.now(),
        _random = random ?? Random() {
    _fixtures = buildFixtures(_now);
    _predictions = {
      for (final entry in seedUserPredictions.entries)
        entry.key: Prediction(
          homeScore: entry.value.home,
          awayScore: entry.value.away,
        ),
    };
    _miniLeagues = [
      const MiniLeague(
        id: 'ml-seed-1',
        name: 'Mahalle Ligi',
        inviteCode: 'TL482K',
        members: ['Sen', 'Ahmet', 'Zeynep'],
      ),
    ];
  }

  final DateTime _now;
  final Random _random;

  late final List<MatchFixture> _fixtures;
  late Map<String, Prediction> _predictions;
  late List<MiniLeague> _miniLeagues;
  final Set<String> _editUnlocked = {};

  Locale _locale = const Locale('tr');

  List<MatchFixture> get fixtures => List.unmodifiable(_fixtures);
  Map<String, Prediction> get predictions => Map.unmodifiable(_predictions);
  List<MiniLeague> get miniLeagues => List.unmodifiable(_miniLeagues);
  Locale get locale => _locale;
  DateTime get now => _now;

  String t(String key) {
    final map = _locale.languageCode == 'en' ? AppStrings.en : AppStrings.tr;
    return map[key] ?? key;
  }

  void toggleLocale() {
    _locale = _locale.languageCode == 'tr'
        ? const Locale('en')
        : const Locale('tr');
    notifyListeners();
  }

  bool isLocked(MatchFixture match) => match.isLocked(_now);

  Prediction? predictionFor(String matchId) => _predictions[matchId];

  /// Bir maç için tahmin girilip girilemeyeceğini belirler: maç henüz
  /// başlamamış OLMALI ve (henüz tahmin girilmemiş VEYA ödüllü reklamla
  /// değiştirme hakkı açılmış) olmalı.
  bool canEnterPrediction(MatchFixture match) {
    if (isLocked(match)) return false;
    if (!_predictions.containsKey(match.id)) return true;
    return _editUnlocked.contains(match.id);
  }

  bool submitPrediction(String matchId, int homeScore, int awayScore) {
    final match = _fixtures.firstWhere((m) => m.id == matchId);
    if (!canEnterPrediction(match)) return false;
    _predictions[matchId] =
        Prediction(homeScore: homeScore, awayScore: awayScore);
    _editUnlocked.remove(matchId);
    notifyListeners();
    return true;
  }

  /// Ödüllü reklam simülasyonu: gerçek bir reklam ağı SDK'sı bu ortamda
  /// entegre edilmediği için (bkz. DEV_NOTES sapmalar), kısa bir
  /// gecikmeyle "izlendi" varsayılır ve o maç için tekrar tahmin
  /// girme hakkı açılır.
  Future<void> watchRewardedAdToUnlockEdit(String matchId) async {
    await Future.delayed(const Duration(milliseconds: 900));
    _editUnlocked.add(matchId);
    notifyListeners();
  }

  int _pointsForMatch(MatchFixture match) {
    if (!match.isFinished) return 0;
    final prediction = _predictions[match.id];
    if (prediction == null) return 0;
    return calculatePoints(
      prediction: prediction,
      finalHomeScore: match.finalHomeScore!,
      finalAwayScore: match.finalAwayScore!,
    );
  }

  int weeklyPointsFor(int week) {
    return _fixtures
        .where((m) => m.week == week)
        .map(_pointsForMatch)
        .fold(0, (a, b) => a + b);
  }

  int get seasonPoints =>
      _fixtures.map(_pointsForMatch).fold(0, (a, b) => a + b);

  /// En güncel (henüz kilitlenmemiş maçları içeren en yüksek) hafta.
  int get currentWeek =>
      _fixtures.map((m) => m.week).reduce((a, b) => a > b ? a : b);

  List<LeaderboardEntry> leaderboard({required bool weekly}) {
    final youPoints = weekly ? weeklyPointsFor(currentWeek) : seasonPoints;
    final entries = <LeaderboardEntry>[
      LeaderboardEntry(name: t('you'), points: youPoints, isCurrentUser: true),
      for (final e in mockOtherPlayers.entries)
        LeaderboardEntry(
          name: e.key,
          points: weekly ? e.value.weekly : e.value.season,
        ),
    ];
    entries.sort((a, b) => b.points.compareTo(a.points));
    return entries;
  }

  String _generateInviteCode() {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    return List.generate(6, (_) => chars[_random.nextInt(chars.length)])
        .join();
  }

  MiniLeague createMiniLeague(String name) {
    final league = MiniLeague(
      id: 'ml-${_random.nextInt(999999)}',
      name: name,
      inviteCode: _generateInviteCode(),
      members: [t('you')],
    );
    _miniLeagues = [..._miniLeagues, league];
    notifyListeners();
    return league;
  }

  /// MVP'de gerçek backend olmadığından, girilen herhangi bir geçerli
  /// (boş olmayan) kod için mock bir mini lige katılım simüle edilir.
  MiniLeague joinMiniLeagueByCode(String code) {
    final normalized = code.trim().toUpperCase();
    final existing = _miniLeagues.where((l) => l.inviteCode == normalized);
    if (existing.isNotEmpty) return existing.first;
    final league = MiniLeague(
      id: 'ml-${_random.nextInt(999999)}',
      name: '${t('tab_mini_leagues')} $normalized',
      inviteCode: normalized,
      members: [t('you'), 'Ahmet', 'Elif'],
    );
    _miniLeagues = [..._miniLeagues, league];
    notifyListeners();
    return league;
  }
}
