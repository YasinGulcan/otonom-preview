import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../logic/scoring.dart';
import '../../models/match_fixture.dart';
import '../../state/app_state.dart';

/// Tek bir maçı; sonucuna göre "tamamlandı", "kilitli" veya "tahmin
/// girilebilir" durumlarından biri olarak gösteren kart.
class MatchCard extends StatefulWidget {
  const MatchCard({super.key, required this.match});

  final MatchFixture match;

  @override
  State<MatchCard> createState() => _MatchCardState();
}

class _MatchCardState extends State<MatchCard> {
  late int _homeScore;
  late int _awayScore;
  bool _watchingAd = false;

  @override
  void initState() {
    super.initState();
    final state = context.read<AppState>();
    final existing = state.predictionFor(widget.match.id);
    _homeScore = existing?.homeScore ?? 0;
    _awayScore = existing?.awayScore ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final match = widget.match;
    final prediction = state.predictionFor(match.id);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TeamsRow(match: match),
            const SizedBox(height: 8),
            if (match.isFinished)
              _FinishedResult(match: match, prediction: prediction, state: state)
            else if (state.isLocked(match))
              _LockedResult(prediction: prediction, state: state)
            else if (state.canEnterPrediction(match))
              _PredictionEntry(
                homeScore: _homeScore,
                awayScore: _awayScore,
                onHomeChanged: (v) => setState(() => _homeScore = v),
                onAwayChanged: (v) => setState(() => _awayScore = v),
                onSave: () {
                  state.submitPrediction(match.id, _homeScore, _awayScore);
                },
                state: state,
              )
            else
              _SubmittedAwaitingEdit(
                prediction: prediction!,
                state: state,
                watchingAd: _watchingAd,
                onWatchAd: () async {
                  setState(() => _watchingAd = true);
                  await state.watchRewardedAdToUnlockEdit(match.id);
                  if (mounted) setState(() => _watchingAd = false);
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _TeamsRow extends StatelessWidget {
  const _TeamsRow({required this.match});
  final MatchFixture match;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '${match.homeTeam} - ${match.awayTeam}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}

class _FinishedResult extends StatelessWidget {
  const _FinishedResult({
    required this.match,
    required this.prediction,
    required this.state,
  });

  final MatchFixture match;
  final dynamic prediction;
  final AppState state;

  @override
  Widget build(BuildContext context) {
    final points = prediction == null
        ? 0
        : calculatePoints(
            prediction: prediction,
            finalHomeScore: match.finalHomeScore!,
            finalAwayScore: match.finalAwayScore!,
          );
    final color = points == exactScorePoints
        ? Colors.green
        : points == correctOutcomePoints
            ? Colors.blue
            : Colors.grey;

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      runSpacing: 4,
      children: [
        Chip(label: Text(state.t('finished'))),
        Text(
          '${match.finalHomeScore} - ${match.finalAwayScore}',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        if (prediction != null)
          Text(
            '${state.t('your_prediction')}: ${prediction.homeScore}-${prediction.awayScore}',
          ),
        Chip(
          label: Text('+$points ${state.t('points_short')}'),
          backgroundColor: color.withValues(alpha: 0.15),
          labelStyle: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _LockedResult extends StatelessWidget {
  const _LockedResult({required this.prediction, required this.state});
  final dynamic prediction;
  final AppState state;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Chip(
          avatar: const Icon(Icons.lock, size: 16),
          label: Text(state.t('locked')),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            prediction != null
                ? '${state.t('your_prediction')}: ${prediction.homeScore}-${prediction.awayScore}'
                : state.t('no_prediction_locked'),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}

class _PredictionEntry extends StatelessWidget {
  const _PredictionEntry({
    required this.homeScore,
    required this.awayScore,
    required this.onHomeChanged,
    required this.onAwayChanged,
    required this.onSave,
    required this.state,
  });

  final int homeScore;
  final int awayScore;
  final ValueChanged<int> onHomeChanged;
  final ValueChanged<int> onAwayChanged;
  final VoidCallback onSave;
  final AppState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(state.t('enter_prediction'),
            style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _ScoreStepper(
              value: homeScore,
              semanticsLabel: 'home-score-stepper',
              onChanged: onHomeChanged,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text('-', style: TextStyle(fontSize: 20)),
            ),
            _ScoreStepper(
              value: awayScore,
              semanticsLabel: 'away-score-stepper',
              onChanged: onAwayChanged,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: FilledButton(
            onPressed: onSave,
            child: Text(state.t('save_prediction')),
          ),
        ),
      ],
    );
  }
}

class _ScoreStepper extends StatelessWidget {
  const _ScoreStepper({
    required this.value,
    required this.onChanged,
    required this.semanticsLabel,
  });

  final int value;
  final ValueChanged<int> onChanged;
  final String semanticsLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticsLabel,
      child: Row(
        children: [
          IconButton(
            key: Key('$semanticsLabel-minus'),
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: value > 0 ? () => onChanged(value - 1) : null,
          ),
          SizedBox(
            width: 28,
            child: Text(
              '$value',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          IconButton(
            key: Key('$semanticsLabel-plus'),
            icon: const Icon(Icons.add_circle_outline),
            onPressed: value < 9 ? () => onChanged(value + 1) : null,
          ),
        ],
      ),
    );
  }
}

class _SubmittedAwaitingEdit extends StatelessWidget {
  const _SubmittedAwaitingEdit({
    required this.prediction,
    required this.state,
    required this.watchingAd,
    required this.onWatchAd,
  });

  final dynamic prediction;
  final AppState state;
  final bool watchingAd;
  final VoidCallback onWatchAd;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '${state.t('your_prediction')}: ${prediction.homeScore}-${prediction.awayScore}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        if (watchingAd)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          )
        else
          TextButton.icon(
            onPressed: onWatchAd,
            icon: const Icon(Icons.ondemand_video, size: 18),
            label: Text(state.t('watch_ad_edit')),
          ),
      ],
    );
  }
}
