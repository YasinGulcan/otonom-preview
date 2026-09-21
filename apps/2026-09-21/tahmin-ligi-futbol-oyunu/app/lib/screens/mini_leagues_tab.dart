import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';

class MiniLeaguesTab extends StatelessWidget {
  const MiniLeaguesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final leagues = state.miniLeagues;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            state.t('no_real_money'),
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontStyle: FontStyle.italic),
          ),
        ),
        Expanded(
          child: leagues.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      state.t('no_mini_leagues'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : ListView.builder(
                  key: const Key('mini-league-list'),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: leagues.length,
                  itemBuilder: (context, index) {
                    final league = leagues[index];
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.emoji_events_outlined),
                        title: Text(league.name),
                        subtitle: Text(
                          '${state.t('invite_code')}: ${league.inviteCode} · '
                          '${league.members.length} ${state.t('members')}',
                        ),
                      ),
                    );
                  },
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  key: const Key('create-mini-league-btn'),
                  onPressed: () => _showCreateDialog(context),
                  child: Text(state.t('create_mini_league')),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  key: const Key('join-mini-league-btn'),
                  onPressed: () => _showJoinDialog(context),
                  child: Text(state.t('join_mini_league')),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showCreateDialog(BuildContext context) {
    final state = context.read<AppState>();
    final controller = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(state.t('create_mini_league')),
        content: TextField(
          key: const Key('mini-league-name-field'),
          controller: controller,
          decoration: InputDecoration(labelText: state.t('league_name')),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(state.t('cancel')),
          ),
          FilledButton(
            key: const Key('confirm-create-mini-league-btn'),
            onPressed: () {
              final name = controller.text.trim();
              if (name.isNotEmpty) {
                state.createMiniLeague(name);
              }
              Navigator.of(dialogContext).pop();
            },
            child: Text(state.t('create')),
          ),
        ],
      ),
    );
  }

  void _showJoinDialog(BuildContext context) {
    final state = context.read<AppState>();
    final controller = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(state.t('join_mini_league')),
        content: TextField(
          key: const Key('mini-league-code-field'),
          controller: controller,
          decoration: InputDecoration(labelText: state.t('enter_code')),
          autofocus: true,
          textCapitalization: TextCapitalization.characters,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(state.t('cancel')),
          ),
          FilledButton(
            key: const Key('confirm-join-mini-league-btn'),
            onPressed: () {
              final code = controller.text.trim();
              if (code.isNotEmpty) {
                state.joinMiniLeagueByCode(code);
              }
              Navigator.of(dialogContext).pop();
            },
            child: Text(state.t('join')),
          ),
        ],
      ),
    );
  }
}
