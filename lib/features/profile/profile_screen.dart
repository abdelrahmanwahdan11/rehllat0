import 'package:flutter/material.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/services/app_state.dart';
import '../../models/badge.dart';
import '../../models/review.dart';
import '../../models/user.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({required this.appState, super.key});

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: appState.dataRepository.loadUser(),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        final User? user = snapshot.data;
        if (user == null) {
          return const Center(child: Text('No user data'));
        }
        return FutureBuilder<List<Review>>(
          future: appState.dataRepository.loadReviews(),
          builder: (BuildContext context, AsyncSnapshot<List<Review>> reviewSnapshot) {
            final List<Review> reviews = reviewSnapshot.data ?? <Review>[];
            return ListView(
              padding: const EdgeInsets.all(16),
              children: <Widget>[
                _ProfileHeader(user: user),
                const SizedBox(height: 24),
                _ImpactDashboard(user: user),
                const SizedBox(height: 24),
                _BadgeCarousel(badges: user.badges),
                const SizedBox(height: 24),
                _ReviewSection(reviews: reviews),
              ],
            );
          },
        );
      },
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return Row(
      children: <Widget>[
        CircleAvatar(
          radius: 32,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Text(user.name.characters.first, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white)),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(user.name, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 4),
              Chip(label: Text(l10n.getString('role_${userRoleToString(user.role).toLowerCase()}'))),
            ],
          ),
        ),
      ],
    );
  }
}

class _ImpactDashboard extends StatelessWidget {
  const _ImpactDashboard({required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _MetricCard(label: 'Volunteer Hours', value: user.volunteerHours.toString()),
        const SizedBox(width: 16),
        _MetricCard(label: 'Completed Projects', value: user.completedProjects.toString()),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 8),
            Text(value, style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ),
    );
  }
}

class _BadgeCarousel extends StatelessWidget {
  const _BadgeCarousel({required this.badges});

  final List<Badge> badges;

  @override
  Widget build(BuildContext context) {
    if (badges.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Badges', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: badges.length,
            itemBuilder: (BuildContext context, int index) {
              final Badge badge = badges[index];
              return Container(
                width: 120,
                margin: const EdgeInsetsDirectional.only(end: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(Icons.emoji_events_outlined, size: 32),
                    const SizedBox(height: 12),
                    Text(badge.title, textAlign: TextAlign.center),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ReviewSection extends StatelessWidget {
  const _ReviewSection({required this.reviews});

  final List<Review> reviews;

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Reviews', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        ...reviews.map(
          (Review review) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(review.author.name, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Row(
                  children: List<Widget>.generate(
                    5,
                    (int index) => Icon(
                      index < review.rating ? Icons.star : Icons.star_border,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(review.comment),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
