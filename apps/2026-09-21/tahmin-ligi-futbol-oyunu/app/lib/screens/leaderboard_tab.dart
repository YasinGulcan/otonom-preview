import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';

class LeaderboardTab extends StatefulWidget {
  const LeaderboardTab({super.key});

  @override
  State<LeaderboardTab> createState() => _LeaderboardTabState();
}

class _LeaderboardTabState extends State<LeaderboardTab> {
  bool _weekly = true;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final entries = state.leaderboard(weekly: _weekly);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: SegmentedButton<bool>(
            key: const Key('leaderboard-segmented'),
            segments: [
              ButtonSegment(value: true, label: Text(state.t('weekly'))),
              ButtonSegment(value: false, label: Text(state.t('seasonal'))),
            ],
            selected: {_weekly},
            onSelectionChanged: (s) => setState(() => _weekly = s.first),
          ),
        ),
        Expanded(
          child: ListView.separated(
            key: const Key('leaderboard-list'),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: entries.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final entry = entries[index];
              return ListTile(
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text(
                  entry.name,
                  style: TextStyle(
                    fontWeight:
                        entry.isCurrentUser ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                tileColor: entry.isCurrentUser
                    ? Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.4)
                    : null,
                trailing: Text(
                  '${entry.points} ${state.t('points_short')}',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
