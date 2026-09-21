import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import 'fixtures_tab.dart';
import 'leaderboard_tab.dart';
import 'mini_leagues_tab.dart';

/// Uygulamanın ana ekranı: sadece yerel state ile render edilir (ağ
/// çağrısı yoktur), bu yüzden QA aşamasında golden-test ekran görüntüsü
/// için güvenilir bir hedeftir.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    final tabs = <Widget>[
      const FixturesTab(),
      const LeaderboardTab(),
      const MiniLeaguesTab(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(state.t('app_title')),
        actions: [
          IconButton(
            tooltip: 'TR / EN',
            icon: const Icon(Icons.translate),
            onPressed: () => context.read<AppState>().toggleLocale(),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Theme.of(context).colorScheme.secondaryContainer,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                children: [
                  Icon(
                    Icons.sports_esports_outlined,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      state.t('game_banner'),
                      style: TextStyle(
                        fontSize: 11,
                        color: Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: IndexedStack(index: _tabIndex, children: tabs),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tabIndex,
        onDestinationSelected: (i) => setState(() => _tabIndex = i),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.sports_soccer_outlined),
            selectedIcon: const Icon(Icons.sports_soccer),
            label: state.t('tab_fixtures'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.leaderboard_outlined),
            selectedIcon: const Icon(Icons.leaderboard),
            label: state.t('tab_leaderboard'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.groups_outlined),
            selectedIcon: const Icon(Icons.groups),
            label: state.t('tab_mini_leagues'),
          ),
        ],
      ),
    );
  }
}
