import '../models/prediction.dart';

enum MatchOutcome { home, draw, away }

/// Puanlama kuralları (BRIEF.md: "doğru sonuç / doğru skor için farklı puan"):
/// - Tam skor tutarsa: 3 puan
/// - Sadece maç sonucu (1/X/2) tutarsa: 1 puan
/// - Hiçbiri tutmazsa: 0 puan
const int exactScorePoints = 3;
const int correctOutcomePoints = 1;
const int noMatchPoints = 0;

MatchOutcome outcomeOf(int homeScore, int awayScore) {
  if (homeScore > awayScore) return MatchOutcome.home;
  if (homeScore < awayScore) return MatchOutcome.away;
  return MatchOutcome.draw;
}

/// Bir tahminin, kesinleşmiş bir sonuca göre kaç puan getirdiğini hesaplar.
int calculatePoints({
  required Prediction prediction,
  required int finalHomeScore,
  required int finalAwayScore,
}) {
  final exactMatch = prediction.homeScore == finalHomeScore &&
      prediction.awayScore == finalAwayScore;
  if (exactMatch) return exactScorePoints;

  final sameOutcome = outcomeOf(prediction.homeScore, prediction.awayScore) ==
      outcomeOf(finalHomeScore, finalAwayScore);
  if (sameOutcome) return correctOutcomePoints;

  return noMatchPoints;
}
