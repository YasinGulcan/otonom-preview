/// Liderlik tablosunda görünen tek bir satır.
class LeaderboardEntry {
  final String name;
  final int points;
  final bool isCurrentUser;

  const LeaderboardEntry({
    required this.name,
    required this.points,
    this.isCurrentUser = false,
  });
}
