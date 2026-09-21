import '../models/match_fixture.dart';

/// Süper Lig'in statik/manuel fikstür verisi (MVP: canlı API yok).
///
/// `now` referans alınarak: 4. hafta tamamen oynanmış (sonuçlar belli),
/// 5. hafta güncel haftadır ve bir maçı zaten başlamış (kilitli) durumda,
/// diğerleri henüz başlamamıştır. Bu, kilitleme ve puanlama akışlarının
/// uygulamayı ilk açtığında da gözlemlenebilmesini sağlar.
List<MatchFixture> buildFixtures(DateTime now) {
  return [
    // --- Hafta 4: tamamlanmış ---
    MatchFixture(
      id: 'w4-1',
      week: 4,
      homeTeam: 'Galatasaray',
      awayTeam: 'Fenerbahçe',
      kickoff: now.subtract(const Duration(days: 10)),
      finalHomeScore: 2,
      finalAwayScore: 1,
    ),
    MatchFixture(
      id: 'w4-2',
      week: 4,
      homeTeam: 'Beşiktaş',
      awayTeam: 'Trabzonspor',
      kickoff: now.subtract(const Duration(days: 9)),
      finalHomeScore: 1,
      finalAwayScore: 1,
    ),
    MatchFixture(
      id: 'w4-3',
      week: 4,
      homeTeam: 'Başakşehir',
      awayTeam: 'Kasımpaşa',
      kickoff: now.subtract(const Duration(days: 9)),
      finalHomeScore: 0,
      finalAwayScore: 2,
    ),
    // --- Hafta 5: güncel hafta ---
    MatchFixture(
      id: 'w5-1',
      week: 5,
      homeTeam: 'Fenerbahçe',
      awayTeam: 'Beşiktaş',
      // Zaten başladı -> tahmin girişi kilitli.
      kickoff: now.subtract(const Duration(hours: 2)),
    ),
    MatchFixture(
      id: 'w5-2',
      week: 5,
      homeTeam: 'Galatasaray',
      awayTeam: 'Trabzonspor',
      kickoff: now.add(const Duration(days: 1)),
    ),
    MatchFixture(
      id: 'w5-3',
      week: 5,
      homeTeam: 'Kasımpaşa',
      awayTeam: 'Başakşehir',
      kickoff: now.add(const Duration(days: 2)),
    ),
    MatchFixture(
      id: 'w5-4',
      week: 5,
      homeTeam: 'Antalyaspor',
      awayTeam: 'Sivasspor',
      kickoff: now.add(const Duration(days: 2, hours: 3)),
    ),
  ];
}

/// Kullanıcının geçmiş (4. hafta) maçları için başlangıçta girmiş
/// olduğu varsayılan tahminler (demo/simülasyon amaçlı önceden dolu veri).
const Map<String, ({int home, int away})> seedUserPredictions = {
  'w4-1': (home: 2, away: 1), // tam isabet -> 3 puan
  'w4-2': (home: 2, away: 0), // yanlış sonuç -> 0 puan
  'w4-3': (home: 0, away: 2), // tam isabet -> 3 puan
};

/// Diğer (mock) kullanıcıların sabit puanları — MVP'de gerçek zamanlı
/// backend olmadığı için sosyal karşılaştırma amacıyla statik veri.
const Map<String, ({int weekly, int season})> mockOtherPlayers = {
  'Ahmet': (weekly: 4, season: 27),
  'Zeynep': (weekly: 1, season: 31),
  'Mert': (weekly: 0, season: 19),
  'Elif': (weekly: 3, season: 24),
  'Can': (weekly: 2, season: 15),
};
