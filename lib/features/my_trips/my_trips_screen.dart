import 'package:flutter/material.dart';

import '../../core/services/app_state.dart';
import '../../models/experience.dart';
import '../../models/trip.dart';
import '../../widgets/experience_card.dart';
import '../experience_detail/experience_detail_screen.dart';

class MyTripsScreen extends StatelessWidget {
  const MyTripsScreen({required this.appState, super.key});

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appState,
      builder: (BuildContext context, _) {
        return FutureBuilder<Map<String, List<Trip>>>(
          future: appState.dataRepository.loadUserTrips(),
          builder: (BuildContext context, AsyncSnapshot<Map<String, List<Trip>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            final Map<String, List<Trip>> baseTrips = snapshot.data ?? <String, List<Trip>>{};
            final List<Trip> upcomingTrips = List<Trip>.from(baseTrips['upcoming'] ?? <Trip>[])
              ..addAll(appState.joinedTrips.map(
                (String experienceId) => Trip(
                  id: 'local_$experienceId',
                  experienceId: experienceId,
                  status: TripStatus.upcoming,
                ),
              ));
            final List<_TabConfig> tabs = <_TabConfig>[
              _TabConfig(id: 'upcoming', label: 'Upcoming', trips: upcomingTrips),
              _TabConfig(id: 'completed', label: 'Completed', trips: baseTrips['completed'] ?? <Trip>[]),
              _TabConfig(id: 'saved', label: 'Saved', trips: baseTrips['saved'] ?? <Trip>[]),
            ];
            return DefaultTabController(
              length: tabs.length,
              child: Column(
                children: <Widget>[
                  TabBar(
                    tabs: tabs.map((_) => Tab(text: _.label)).toList(),
                    labelColor: Theme.of(context).colorScheme.primary,
                    unselectedLabelColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: tabs
                          .map(
                            (_TabConfig config) => _TabContent(
                              appState: appState,
                              trips: config.trips,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _TabConfig {
  const _TabConfig({required this.id, required this.label, required this.trips});

  final String id;
  final String label;
  final List<Trip> trips;
}

class _TabContent extends StatelessWidget {
  const _TabContent({required this.appState, required this.trips});

  final AppState appState;
  final List<Trip> trips;

  @override
  Widget build(BuildContext context) {
    if (trips.isEmpty) {
      return const Center(child: Text('No trips yet'));
    }
    return FutureBuilder<List<Experience>>(
      future: _loadExperiences(),
      builder: (BuildContext context, AsyncSnapshot<List<Experience>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        final List<Experience> experiences = snapshot.data ?? <Experience>[];
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: experiences.length,
          itemBuilder: (BuildContext context, int index) {
            final Experience experience = experiences[index];
            return SizedBox(
              height: 220,
              child: ExperienceCard(
                experience: experience,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<Widget>(
                      builder: (BuildContext context) => ExperienceDetailScreen(
                        experienceId: experience.id,
                        appState: appState,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Future<List<Experience>> _loadExperiences() async {
    final List<Experience> experiences = <Experience>[];
    for (final Trip trip in trips) {
      final Experience? experience = await appState.dataRepository.findExperience(trip.experienceId);
      if (experience != null) {
        experiences.add(experience);
      }
    }
    return experiences;
  }
}
