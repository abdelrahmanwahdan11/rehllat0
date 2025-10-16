import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/services/app_state.dart';
import '../../models/experience.dart';

class ExperienceDetailScreen extends StatelessWidget {
  const ExperienceDetailScreen({required this.experienceId, required this.appState, super.key});

  final String experienceId;
  final AppState appState;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return FutureBuilder<Experience?>(
      future: appState.dataRepository.findExperience(experienceId),
      builder: (BuildContext context, AsyncSnapshot<Experience?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator.adaptive()));
        }
        final Experience? experience = snapshot.data;
        if (experience == null) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(child: Text(l10n.getString('msg_error_generic'))),
          );
        }
        final DateFormat formatter = DateFormat.yMMMMd(appState.locale.languageCode);
        return Scaffold(
          appBar: AppBar(
            title: Text(experience.title),
          ),
          body: Stack(
            children: <Widget>[
              Positioned.fill(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 220,
                        width: double.infinity,
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
                        child: const Center(child: Icon(Icons.landscape, size: 96)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(experience.title, style: Theme.of(context).textTheme.headlineMedium),
                            const SizedBox(height: 8),
                            Text(
                              experience.location,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 8),
                            Text('${l10n.getString('label_time')}: ${formatter.format(experience.startAt)}'),
                            const SizedBox(height: 16),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: <Widget>[
                                Chip(label: Text(experienceTypeToString(experience.type))),
                                Chip(label: Text('${experience.durationHours}h')),
                                if (experience.isSponsored && experience.sponsor != null)
                                  Chip(label: Text('Sponsored by ${experience.sponsor!.name}')),
                              ],
                            ),
                            const SizedBox(height: 24),
                            if (experience.type == ExperienceType.tourism && experience.itinerary.isNotEmpty)
                              _InfoSection(
                                title: 'Itinerary',
                                children: experience.itinerary
                                    .map((String item) => ListTile(
                                          leading: const Icon(Icons.timeline_outlined),
                                          title: Text(item),
                                        ))
                                    .toList(),
                              ),
                            if (experience.type == ExperienceType.volunteer && experience.impactGoals.isNotEmpty)
                              _InfoSection(
                                title: 'Impact Goals',
                                children: experience.impactGoals
                                    .map((String item) => ListTile(
                                          leading: const Icon(Icons.favorite_outline),
                                          title: Text(item),
                                        ))
                                    .toList(),
                              ),
                            if (experience.isSponsored && experience.sponsor != null)
                              _InfoSection(
                                title: 'Sponsor',
                                children: <Widget>[
                                  ListTile(
                                    leading: const Icon(Icons.campaign_outlined),
                                    title: Text(experience.sponsor!.name),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    top: false,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            experience.isFree
                                ? l10n.getString('label_free')
                                : '${l10n.getString('label_price')}: ${NumberFormat.simpleCurrency(name: 'USD').format(experience.price)}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => appState.joinTrip(experience.id),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.secondary,
                              foregroundColor: Theme.of(context).colorScheme.onSecondary,
                              shape: const StadiumBorder(),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: Text(l10n.getString('cta_join_now')),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _InfoSection extends StatelessWidget {
  const _InfoSection({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        ...children,
        const SizedBox(height: 16),
      ],
    );
  }
}
