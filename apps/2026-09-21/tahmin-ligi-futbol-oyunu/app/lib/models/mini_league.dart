/// Davet kodu ile oluşturulan/katılınan sosyal "mini lig".
class MiniLeague {
  final String id;
  final String name;
  final String inviteCode;
  final List<String> members;

  const MiniLeague({
    required this.id,
    required this.name,
    required this.inviteCode,
    required this.members,
  });
}
