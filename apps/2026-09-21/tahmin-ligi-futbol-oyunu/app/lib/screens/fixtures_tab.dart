import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/match_fixture.dart';
import '../state/app_state.dart';
import 'widgets/match_card.dart';

class FixturesTab extends StatelessWidget {
  const FixturesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final fixtures = [...state.fixtures]
      ..sort((a, b) {
        final weekCompare = b.week.compareTo(a.week);
        if (weekCompare != 0) return weekCompare;
        return a.kickoff.compareTo(b.kickoff);
      });

    final Map<int, List<MatchFixture>> byWeek = {};
    for (final match in fixtures) {
      byWeek.putIfAbsent(match.week, () => []).add(match);
    }
    final weeks = byWeek.keys.toList()..sort((a, b) => b.compareTo(a));

    return ListView(
      key: const Key('fixtures-list'),
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      children: [
        for (final week in weeks) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Text(
              '${state.t('week')} $week',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          for (final match in byWeek[week]!) MatchCard(match: match),
        ],
      ],
    );
  }
}
