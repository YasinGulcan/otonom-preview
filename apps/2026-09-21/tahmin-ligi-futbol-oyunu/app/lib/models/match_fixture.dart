/// Statik/manuel bir Süper Lig fikstür maçını temsil eder.
///
/// MVP kapsamında canlı veri kullanılmaz (bkz. BRIEF.md "MVP dışı bırakılanlar"):
/// maç listesi ve sonuçlar uygulama içinde sabit/simüle veridir.
class MatchFixture {
  final String id;
  final int week;
  final String homeTeam;
  final String awayTeam;
  final DateTime kickoff;

  /// Maç henüz oynanmadıysa null olur.
  final int? finalHomeScore;
  final int? finalAwayScore;

  const MatchFixture({
    required this.id,
    required this.week,
    required this.homeTeam,
    required this.awayTeam,
    required this.kickoff,
    this.finalHomeScore,
    this.finalAwayScore,
  });

  bool get isFinished => finalHomeScore != null && finalAwayScore != null;

  /// Maç başlama saati geçtiyse tahmin girişi kilitlenir.
  bool isLocked(DateTime now) => now.isAfter(kickoff);
}
