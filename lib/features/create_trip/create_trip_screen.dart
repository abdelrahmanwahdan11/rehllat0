import 'package:flutter/material.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/services/app_state.dart';

class CreateTripScreen extends StatelessWidget {
  const CreateTripScreen({required this.appState, super.key});

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Text(
            l10n.getString('tab_create'),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          _InfoCard(
            icon: Icons.flag_outlined,
            title: 'Define the basics',
            description:
                'Set the trip type, schedule, and meeting location before inviting others.',
          ),
          const SizedBox(height: 12),
          _InfoCard(
            icon: Icons.group_outlined,
            title: 'Plan capacity & pricing',
            description:
                'Experiment with minimum and maximum group sizes and preview group pricing tiers instantly.',
          ),
          const SizedBox(height: 12),
          _InfoCard(
            icon: Icons.route_outlined,
            title: 'Craft the itinerary',
            description:
                'Add learning points, camping details, and gear checklists to keep participants prepared.',
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => appState.setActiveGradientType('Private'),
            child: Text(l10n.getString('cta_done')),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(icon, size: 32, color: theme.colorScheme.primary),
            const SizedBox(height: 12),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
