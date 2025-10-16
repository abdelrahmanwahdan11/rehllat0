import 'package:flutter/material.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/services/app_state.dart';
import '../../models/experience.dart';
import '../../widgets/experience_card.dart';
import '../experience_detail/experience_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({required this.appState, super.key});

  final AppState appState;

  Future<List<Experience>> _load(String key) {
    return appState.dataRepository.loadExperiences(key);
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return RefreshIndicator(
      onRefresh: () async {
        await Future<void>.delayed(const Duration(milliseconds: 400));
      },
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Text(l10n.getString('home_greeting'), style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 24),
          _ExperienceSection(
            title: l10n.getString('section_recommended'),
            future: _load('recommended'),
            onTap: (Experience experience) => _openDetail(context, experience),
          ),
          const SizedBox(height: 24),
          _ExperienceSection(
            title: l10n.getString('section_nearby'),
            future: _load('nearby'),
            onTap: (Experience experience) => _openDetail(context, experience),
          ),
          const SizedBox(height: 24),
          _ExperienceSection(
            title: l10n.getString('section_volunteer'),
            future: _load('volunteer'),
            onTap: (Experience experience) => _openDetail(context, experience),
          ),
        ],
      ),
    );
  }

  void _openDetail(BuildContext context, Experience experience) {
    Navigator.of(context).push(
      MaterialPageRoute<Widget>(
        builder: (BuildContext context) => ExperienceDetailScreen(
          experienceId: experience.id,
          appState: appState,
        ),
      ),
    );
  }
}

class _ExperienceSection extends StatelessWidget {
  const _ExperienceSection({
    required this.title,
    required this.future,
    required this.onTap,
  });

  final String title;
  final Future<List<Experience>> future;
  final ValueChanged<Experience> onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        SizedBox(
          height: 280,
          child: FutureBuilder<List<Experience>>(
            future: future,
            builder: (BuildContext context, AsyncSnapshot<List<Experience>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator.adaptive());
              }
              if (snapshot.hasError) {
                return Center(child: Text(AppLocalizations.of(context).getString('msg_error_generic')));
              }
              final List<Experience> experiences = snapshot.data ?? <Experience>[];
              if (experiences.isEmpty) {
                return const Center(child: Text('No data'));
              }
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: experiences.length,
                itemBuilder: (BuildContext context, int index) {
                  final Experience experience = experiences[index];
                  return ExperienceCard(
                    experience: experience,
                    onTap: () => onTap(experience),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
